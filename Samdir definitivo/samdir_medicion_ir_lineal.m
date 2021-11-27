%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_medicion_ir-m                                           *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%   samdir_medicion_ir_lineal - Realiza la medici�n de la respuesta 
%   impulsiva del sistema mediante una se�al barrido senoidal lineal que 
%   es ingresada como argumento. Devuelve la IR sin procesar.
%
%   Sintaxis: samdirAudio = samdir_medicion_ir_lineal(samdirAudio)
%
%   ir = samdir_medicion_ir_lineal(excitacion)
%
function varargout = samdir_medicion_ir_lineal(varargin)
%% Inicializaci�n
audioObj    = varargin{1}; 
input       = varargin{2};
output      = varargin{3};
% Variables para ser obtenidas de la GUI
fs      = audioObj.samplingRate;

% Grabaci�n y deconvoluci�n mediante divisi�n de FFT
grab        = samdir_reproduce_graba(audioObj, input, output);
ir_cruda    = samdir_division_FFT(grab,audioObj);

varargout(1) = {ir_cruda};
varargout(2) = {grab};
end

