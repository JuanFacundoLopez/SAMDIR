%***************************************************************************************
%*   SISTEMA AUTOM?TICO DE MEDICI?N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC?STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_medicion_ir_exponencial.m                               *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar?a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier?a Electr?nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci?n y Transferencia en Ac?stica (CINTRA)   *
%***************************************************************************************/
%   samdir_medicion_ir_exponencial() - Realiza la medici?n de la respuesta 
%   impulsiva del sistema mediante un barrido exponencial que es ingresado 
%   como argumento. Devuelve la IR sin procesar.
%
%   Sintaxis: samdirAudio = samdir_medicion_ir_exponencial(samdirAudio)
%
%   ir = samdir_medicion_ir_exponencial(excitacion)
%
function varargout = samdir_medicion_ir_exponencial(varargin)
%% Inicializaci?n
audioObj        = varargin{1}; 
input           = varargin{2};
output          = varargin{3};
rangoFrecuencia = varargin{4};
fs              = varargin{5}; 
% Variables para ser obtenidas de la GUI
%f0      = 22;
%f1      = 22000;

inv     = samdir_inverso(audioObj,rangoFrecuencia);
grab    = samdir_reproduce_graba(audioObj, input, output, fs);
ir_cruda= samdir_deconv_lineal_FFT(grab,inv);

varargout(1) = {ir_cruda};
varargout(2) = {grab};
end
