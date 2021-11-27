%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_deconv_lineal_FFT.m                                      *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_deconv_lineal_FFT(varargin)
%   samdir_deconv_lineal - Realiza la deconvolución lineal, mediante la
%   multiplicación de la FFT de la señal grabada y la FFT del filtro 
%   inverso de la señal de excitación.
%
%   Sintaxis: samdirAudio = samdir_deconv_lineal_FFT(samdirAudio, samdirAudio)
%
%   c = samdir_deconv_lineal_FFT(a,b)
%
%% Variables de la GUI
fs      = 48000;

%% Inicialización
grab    = varargin{1}; 
inv     = varargin{2}; 

%% Convolución FFT
audioObj = samdirAudio;
audioObj.samplingRate = fs;

% Antes de multiplicar, se deben crear dos vectores de 2*n-1 samples para
% evitar convolución circular, se rellenan con ceros.
inv_mod     = [inv.timeData; zeros(inv.nSamples-1,1)];
grab_mod    = [grab.timeData; zeros(grab.nSamples-1,1)];

INV     = fft (inv_mod);
GRAB    = fft (grab_mod);
IR      = INV.*GRAB;
ir      = ifft (IR);
audioObj.timeData = ir;

% Si las señales tenían una longitud de 2^N, la IR tiene una longitud de
% 2^(N+1)-1 muestras, por lo que se agrega un sample. También se cambía el
% tipo de señal de potencia a energía y el 'comment'.

audioObj.timeData(audioObj.nSamples+1) = 0;
audioObj.comment = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end