%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_comunicacion.m                                           *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%   samdir_comunicacion - Esta función establece la comunicación con el
%   microcontrolador y define las variables del movimiento.
%   La comunicación con el uC es simple, por lo que se basará en enviar
%   caracteres individuales cuyo significado es el siguiente:
%   
%   'id'        - se envia para establecer la comunicación.
%   'test_ok?'  - pregunta por el test de prueba
%   'sentido'   - sentido de giro (cant: 1 horario, 0 antihorario)
%   'pasos'     - cantidad de pasos
%   'fin'       - fin del movimiento
%   'sensores'  - revisa el estado de los sensores
%   'test'      - entra a la función que realiza la prueba
%   'tipo_med'  - entra a la función que imprime el tipo de medición 
%               (cant: 1 Medición Directividad, 0 Medición IR)
%   'barra'     - entra a la función que imprime la barra de porcentaje
%
%   Sintaxis: samdir_comunicacion(obj_ser,orden,cant)
%
%   samdir_comunicacion(pic,'c',1)
%
function varargout = samdir_comunicacion(varargin)
%% Inicialización
pic     = varargin{1}; 
orden   = varargin{2}; 
cant    = varargin{3};
resp    = 0;
switch (orden)
    %% Identificación del dispositivo
    case {'id'}
    fprintf(pic,'%c','a');
    resp  = fscanf(pic,'%d',1);             % Respuesta
    
    %% Se ejecutó el test de prueba?  
    case {'test_ok?'}
    fprintf(pic,'%c','b');
    resp = fscanf(pic,'%d',1);              % Respuesta
    
    %% Sentido de giro
    case {'sentido'}
    fprintf(pic,'%c','c');
   % resp = fscanf(pic,'%d',1);              % Respuesta
    % Pasa el sentido de int a char
    sent_tx = char(cant+48);
    fprintf(pic,'%c',sent_tx);
%     sent_rx = fscanf(pic,'%d',1);           % Sentido recibido
%     if (cant == sent_rx)
%         resp = 1;
%     else
%         resp = 0;
%     end
    resp =  fscanf(pic,'%d',1);           % Sentido recibido
    %% Cantidad de pasos
    case {'pasos'}
    fprintf(pic,'%c','d');
    
  %  resp = fscanf(pic,'%d',1);              % Respuesta
    % Pasa los pasos de int a char
%     unidad      = mod(cant,10);
%     unidad_tx   = char(unidad+48);
%     decena      = (cant - mod(cant,10))/10;
%     decena_tx   = char(decena+48);
%     fprintf(pic,'%c',unidad_tx);
%     dummy = fscanf(pic,'%d',1);             % Respuesta
%     fprintf(pic,'%c',decena_tx);
%     pasos_rx = fscanf(pic,'%2d',2);         % Pasos recibidos
%     if (cant == pasos_rx)
%         resp = 1;
%     else
%         resp = 0;
%     end
    uDiezMil =  floor(cant/10000);
    uDiezMil_tx   = char(uDiezMil+48);
    fprintf(pic,'%c',uDiezMil_tx);
    
    cant = cant - uDiezMil*10000;
    uMil =  floor(cant/1000);
    uMil_tx   = char(uMil+48);
    fprintf(pic,'%c',uMil_tx);
    
    cant = cant - uMil*1000;
    uCentena =  floor(cant/100);
    uCentena_tx   = char(uCentena+48);
    fprintf(pic,'%c',uCentena_tx);
    
    cant = cant - uCentena*100;
    uDecena =  floor(cant/10);
    uDecena_tx   = char(uDecena+48);
    fprintf(pic,'%c',uDecena_tx);
    
    cant = cant - uDecena*10;
    uUnidad =  cant;
    uUnidad_tx   = char(uUnidad+48);
    fprintf(pic,'%c',uUnidad_tx);
    
    resp = fscanf(pic,'%d',1);

    %% Fin de la transmisión
    case {'fin'}
    fprintf(pic,'%c','e');
    resp = fscanf(pic,'%d',1);              % Respuesta
    
    %% Revisa el estado de los sensores
    case {'sensores'}
    fprintf(pic,'%c','f');
    resp = fscanf(pic,'%d',1);              % Respuesta
    if (resp)                               % Si hay alguno activado
        fprintf(pic,'%c','f');              % Pregunta dummy
        resp = fscanf(pic,'%d',1);          % Sensor activado
    else
        resp = 0;
    end
    
    %% Realiza el test y setea una bandera en el pic
    case {'test'}
    fprintf(pic,'%c','g');
    resp = fscanf(pic,'%d',1);              % Respuesta
    
    %% Tipo de medición
    case {'tipo_med'}
    fprintf(pic,'%c','h');
    resp = fscanf(pic,'%d',1);              % Respuesta
    tipo_tx= char(cant+48);
    fprintf(pic,'%c',tipo_tx);
    tipo_rx = fscanf(pic,'%d',1);           % Tipo de medición recibido
    if (cant == tipo_rx)
        resp = 1;
    else
        resp = 0;
    end
    
    %% Entra a la función barra
    case {'barra'}
    fprintf(pic,'%c','i');
    resp = fscanf(pic,'%d',1);              % Respuesta
    % Pasa el porcentaje de int a char
    unidad      = mod(cant,10);
    unidad_tx   = char(unidad+48);
    decena      = (cant - mod(cant,10))/10;
    decena_tx   = char(decena+48);
    fprintf(pic,'%c',unidad_tx);
    dummy = fscanf(pic,'%d',1);             % Respuesta
    fprintf(pic,'%c',decena_tx);
    porc_rx = fscanf(pic,'%2d',2);          % Porcentaje recibido
    if (cant == porc_rx)
        resp = 1;
    else
        resp = 0;
    end
    
end

varargout(1) = {resp};

end

