%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_directividad_ordenar.m                                  *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************
%   samdir_directividad_ordenar - Ordena el vector ingresado como argumento
%   de forma que el primer elemento quede en el centro.
%   Ejemplo: para un vector ordenado 0� 90� 180� 270� 0� devuelve
%   -180� -90� 0� 90� 180�. El vector ingresado debe tener un n�mero impar
%   de elementos. Se supone que el primer elemento es igual al �ltimo.
%
%   Sintaxis: vector = samdir_directividad_ordenar(vector)
%
%   pot_mod = samdir_directividad_ordenar(pot)
%***************************************************************************************
function varargout = samdir_directividad_ordenar(varargin)
%% Inicializaci�n
vector      = varargin{1}; 

%% Ordenamiento
vec_nuevo   = zeros (1,length(vector));
mitad       = round (length(vector)/2)-1;
for i=1:mitad
    vec_nuevo(i) = vector(mitad+i);
end
for i=mitad+1:length(vector)
    vec_nuevo(i) = vector(i-mitad);
end

varargout(1) = {vec_nuevo};
end
