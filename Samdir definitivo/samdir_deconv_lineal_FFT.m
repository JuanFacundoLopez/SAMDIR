%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_deconv_lineal_FFT.m                                      *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_deconv_lineal_FFT(varargin)
%   samdir_deconv_lineal - Realiza la deconvoluci�n lineal, mediante la
%   multiplicaci�n de la FFT de la se�al grabada y la FFT del filtro 
%   inverso de la se�al de excitaci�n.
%
%   Sintaxis: samdirAudio = samdir_deconv_lineal_FFT(samdirAudio, samdirAudio)
%
%   c = samdir_deconv_lineal_FFT(a,b)
%
%% Variables de la GUI
fs      = 48000;

%% Inicializaci�n
grab    = varargin{1}; 
inv     = varargin{2}; 

%% Convoluci�n FFT
audioObj = samdirAudio;
audioObj.samplingRate = fs;

% Antes de multiplicar, se deben crear dos vectores de 2*n-1 samples para
% evitar convoluci�n circular, se rellenan con ceros.
inv_mod     = [inv.timeData; zeros(inv.nSamples-1,1)];
grab_mod    = [grab.timeData; zeros(grab.nSamples-1,1)];

INV     = fft (inv_mod);
GRAB    = fft (grab_mod);
IR      = INV.*GRAB;
ir      = ifft (IR);
audioObj.timeData = ir;

% Si las se�ales ten�an una longitud de 2^N, la IR tiene una longitud de
% 2^(N+1)-1 muestras, por lo que se agrega un sample. Tambi�n se camb�a el
% tipo de se�al de potencia a energ�a y el 'comment'.

audioObj.timeData(audioObj.nSamples+1) = 0;
audioObj.comment = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end