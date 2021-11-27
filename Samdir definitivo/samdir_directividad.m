%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_directividad.m                                          *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%   samdir_directividad - Si la señal de excitación es un barrido lineal o 
%   exponencial, realiza la medicion de IR en distintos ángulos y luego 
%   obtiene el diagrama polar. En caso de que la señal de excitación
%   sea un tono, realiza el diagrama polar a partir de los niveles de 
%   presión sonora registrados.
%   Los ángulos de inicio y final son tomados de la GUI, al igual que la 
%   resolución angular.
%
%   Sintaxis: [struct samdirAudio,vec,vec] = samdir_directividad(samdirAudio,int,int,int)
%
%   [ir,pot_db,pot_db_ref]= samdir_directividad(excitacion,ang1,ang2,res);
%
function varargout = samdir_directividad(varargin)
%% Inicialización de variables
excitacion  = varargin{1}; 
ang1        = varargin{2};
ang2        = varargin{3};
res         = varargin{4};

% Variables globales de la GUI
orden_filtro    = 6;
bandas_octava   = 1;

f0      = 22;
f1      = 22000;
tipo_exc= 'sine';
label_oct   = {'31.5','63','125','250','500','1k','2k','4k','8k','16k'};
label_ter   = {'20','25','31.5','40','50','63','80','100','125','160','200',...
'250','315','400','500','630','800','1k','1.25k','1.6k','2k',... 
'2.5k','3.15k','4k','5k','6.3k','8k','10k','12.5k','16k','20k'};

%% Cálculo de la cantidad de ensayos a realizar
[num,giro] = samdir_ensayos(res,ang1,ang2);

%% Movimiento del motor
% Inicialización del struct destino de las grabaciones y las IR
struct_grab(num)    = samdirAudio;
struct_ir(num)      = samdirAudio;
struct_ir_vent(num) = samdirAudio;

% Realización de las grabaciones y el movimiento
switch (tipo_exc)
    
    case {'linsweep','expsweep'} 
        for i=1:num,
            struct_grab(i) = samdir_reproduce_graba(excitacion);
            fprintf('\nMe estoy moviendo.\n');
            pause (2);
        end
    
    case {'sine','cosine'} 
        for i=1:num,
            for j=1:length(excitacion),
                struct_grab(i,j) = samdir_reproduce_graba(excitacion(j));
            end
            fprintf('\nMe estoy moviendo.\n');
            pause (2);
        end
end

%% Post-procesamiento
fprintf('\nProcesamiento de las señales obtenidas.\n');

% Obtención de las IRs
switch (tipo_exc)
    
    case {'linsweep'} 
        % Deconvoluciones
        for i=1:num,
            struct_ir(i) = samdir_division_FFT(struct_grab(i),excitacion);
        end
        
    case {'expsweep'}
        % Creación del filtro inverso
        inv     = samdir_inverso(excitacion,[f0 f1]);
        % Deconvoluciones
        for i=1:num,
            struct_ir(i) = samdir_deconv_lineal_FFT(struct_grab(i),inv);
        end
        
    case {'sine','cosine'} 
        % No hay IR
end


% Se ventanea cada IR con los parámetros de la GUI
% for i=1:num,
%     struct_ir_vent(i) = samdir_ventaneo_aplicar(struct_ir,vent,vector)
% end

% Se rellena con ceros si es necesario

%% Cálculo de potencia por bandas
switch (tipo_exc)
    
    case {'linsweep','expsweep'} 
        % Se realiza el cálculo de la potencia por banda con los filtros de la GUI
        fprintf('\nCreación de los filtros.\n');
        % Creación de los filtros
        [filtros, frec_central] = samdir_banco_filtros(bandas_octava,orden_filtro);
        % Matrices que contendran el valor de potencia/banda de frecuencia
        pot     = zeros (num,length(frec_central));
        pot_db  = zeros (num,length(frec_central));
        fprintf('\nAplicación de los filtros.\n');
        % Filtrado y calculo de potencia por bandas de las IR
        for i=1:num,
            [pot_db(i,:)]= samdir_potencia_bandas_2(filtros, struct_ir(i));
        end

    case {'sine','cosine'} 
        % Se realiza el cálculo de la potencia por banda
        pot     = zeros (num,length(excitacion));
        for i=1:num,
            for j=1:length(excitacion),
                pot(i,j)    = sum(struct_grab(i,j).timeData.^2)/length(struct_grab(i,j).timeData);
                pot_db(i,j) = db(pot(i,j),'power');
            end
        end
        
end

%% Normalización a la medición en 0°
pot_db_ref = zeros (num,length(pot_db(1,:)));
for i=1:num,
	pot_db_ref(i,:)= pot_db(i,:) - pot_db(1,:);
end

% Si es un giro completo, se repite la primer medición para cerrar el
% gráfico polar
if (giro)
    pot_db(num+1,:)       = pot_db(1,:);
    pot_db_ref(num+1,:)   = pot_db_ref(1,:);
end

% Se realiza el ploteo de la directividad. La función dirplot() realiza el
% gráfico desde -180 a 180, por lo que es necesario antes reacomodar los 
% valores.
for i=1:length(pot_db(1,:)),
	pot_db_mod (:,i) = samdir_directividad_ordenar (pot_db_ref(:,i));
end

if (length(pot_db_mod(1,:))==10)
    frec_nominal = label_oct;
else
    frec_nominal = label_ter;
end

samdir_plot_directividad(pot_db_mod,frec_nominal);

% Se guarda las IRs si es seleccionado en la GUI

%% Cálculo de los parámetros de directividad
for i=1:length(pot_db_mod(1,:)),
    [ang_cob(i),q(:,i),id(:,i)] = samdir_directividad_parametros(pot_db_mod(:,i),res);
end

% Graficas

%% Retorno de IRs y valores de potencia
if (tipo_exc=='sine')|(tipo_exc=='sine')
    % Como este metodo no obtiene la IR, devuelve un valor nulo
    struct_ir   = 0;        
end

 varargout(1) = {struct_ir};
 varargout(2) = {pot_db_mod};
end

