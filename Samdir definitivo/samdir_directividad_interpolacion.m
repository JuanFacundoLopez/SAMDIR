%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_directividad_interpolacion.m                            *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************
%   samdir_directividad_interpolacion - Realiza una interpolación de los
%   datos (potencia y ángulos)en la resolución ingresada como argumento 
%   (limitada por la GUI). Además es necesario ingresar el tipo de
%   interpolación deseada.
%
%   Sintaxis: vector = samdir_directividad_interpolacion(vector,vector,int)
%
%   [pot_int,ang_int] = samdir_directividad_parametros(pot,ang,ang_int)
%***************************************************************************************
function varargout = samdir_directividad_interpolacion(varargin)
%% Inicialización
pot     = varargin{1}; 
ang     = varargin{2}; 
res_int = varargin{3}; 
tipo    = varargin{4}; 

%% Interpolación
ang_int = -180:res_int:180;
switch (tipo)
    
    case {'linear'} 
        pot_int = interp1(ang,pot,ang_int,'linear');
        
    case {'spline'}
        pot_int = interp1(ang,pot,ang_int,'spline');
        
    case {'pchip'} 
        pot_int = interp1(ang,pot,ang_int,'pchip');
        
end

% Valores de salida
varargout(1) = {pot_int};
varargout(2) = {ang_int};

end