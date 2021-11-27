%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_directividad_ordenar.m                                  *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************
%   samdir_directividad_ordenar - Ordena el vector ingresado como argumento
%   de forma que el primer elemento quede en el centro.
%   Ejemplo: para un vector ordenado 0º 90º 180º 270º 0º devuelve
%   -180º -90º 0º 90º 180º. El vector ingresado debe tener un número impar
%   de elementos. Se supone que el primer elemento es igual al último.
%
%   Sintaxis: vector = samdir_directividad_ordenar(vector)
%
%   pot_mod = samdir_directividad_ordenar(pot)
%***************************************************************************************
function varargout = samdir_directividad_ordenar(varargin)
%% Inicialización
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
