%****************************************************************************************
%*   SISTEMA AUTOM?TICO DE MEDICI?N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC?STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  cal_fft.m                                                       *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar?a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier?a Electr?nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci?n y Transferencia en Ac?stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = cal_fft(varargin)
% Sirve para asegurar que las dimensiones de entrada y salida coincidan

for ind = 1:numel(varargin{1})
    varargin{1}(ind) = samdir_fft(varargin{1}(ind));
end
varargout{1} = varargin{1};