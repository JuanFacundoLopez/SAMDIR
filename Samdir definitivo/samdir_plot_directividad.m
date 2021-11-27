%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_plot_directividad                                       *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%%
function varargout = samdir_plot_directividad(varargin)
%   samdir_plot_directividad - Realiza el gráfico polar de la matriz
%   recibida como argumento frecuencia(filas)/ángulos(columnas). Además es 
%   necesario recibir el vector con las frecuencias nominales.
%
%   Sintaxis: samdir_plot_directividad(matriz_frecuencia_angulos)
%
%   samdir_plot_directividad(matriz_db)
%
%% Inicialización
matriz_db    = varargin{1}; 
frec_nominal = varargin{2}; 

%% Reordenamiento de los elementos
% La función dirplot() empieza en -180º y repite el último elemento para
% poder cerrar la curva, es necesario reordenar las filas de la matriz
% ingresada ya que empieza en 0°.
ens     = length(matriz_db(:,1))-1;     % Cantidad de mediciones
grad    = 360/ens;                      % Resolución angular
frec    = length(matriz_db(1,:));       % Bandas de frecuencia
theta   = -180:grad:180;                % Vector ángulos


%% Gráfica
% Límites de la gráfica
Rhomax = max(matriz_db(:,1));
Rhomin = min(matriz_db(:,1));
%z=[Rhomax Rhomin 8];
% for i=1:frec,
%     figure;
%     dirplot(theta',matriz_nueva(:,i),'-b');
%     title('Diagrama de Directividad');
%     %legend([int2str(frec),'Hz'],-1);    
% end

varargout(1) = {theta};
varargout(2) = {frec_nominal}; 

end

