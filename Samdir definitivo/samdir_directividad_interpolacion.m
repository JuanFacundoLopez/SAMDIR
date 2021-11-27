%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_directividad_interpolacion.m                            *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************
%   samdir_directividad_interpolacion - Realiza una interpolaci�n de los
%   datos (potencia y �ngulos)en la resoluci�n ingresada como argumento 
%   (limitada por la GUI). Adem�s es necesario ingresar el tipo de
%   interpolaci�n deseada.
%
%   Sintaxis: vector = samdir_directividad_interpolacion(vector,vector,int)
%
%   [pot_int,ang_int] = samdir_directividad_parametros(pot,ang,ang_int)
%***************************************************************************************
function varargout = samdir_directividad_interpolacion(varargin)
%% Inicializaci�n
pot     = varargin{1}; 
ang     = varargin{2}; 
res_int = varargin{3}; 
tipo    = varargin{4}; 

%% Interpolaci�n
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