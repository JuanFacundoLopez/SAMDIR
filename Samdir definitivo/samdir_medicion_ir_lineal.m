%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_medicion_ir-m                                           *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%   samdir_medicion_ir_lineal - Realiza la medición de la respuesta 
%   impulsiva del sistema mediante una señal barrido senoidal lineal que 
%   es ingresada como argumento. Devuelve la IR sin procesar.
%
%   Sintaxis: samdirAudio = samdir_medicion_ir_lineal(samdirAudio)
%
%   ir = samdir_medicion_ir_lineal(excitacion)
%
function varargout = samdir_medicion_ir_lineal(varargin)
%% Inicialización
audioObj    = varargin{1}; 
input       = varargin{2};
output      = varargin{3};
% Variables para ser obtenidas de la GUI
fs      = audioObj.samplingRate;

% Grabación y deconvolución mediante división de FFT
grab        = samdir_reproduce_graba(audioObj, input, output);
ir_cruda    = samdir_division_FFT(grab,audioObj);

varargout(1) = {ir_cruda};
varargout(2) = {grab};
end

