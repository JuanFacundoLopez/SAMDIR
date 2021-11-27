%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_division_FFT.m                                           *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%   samdir_deconv_lineal - Realiza la deconvoluci�n mediante la divisi�n
%   de la FFT de la se�al grabada y la FFT de la se�al de excitaci�n.
%
%   Sintaxis: samdirAudio = samdir_division_FFT(samdirAudio, samdirAudio)
%
%   c = samdir_division_FFT(a,b)
%
function varargout = samdir_division_FFT(varargin)
%% Variables de la GUI
fs      = 48000;
f0      = 22;
f1      = 22000;

%% Inicializaci�n
grab    = varargin{1}; 
exc     = varargin{2}; 

%% Deconvoluci�n por divisi�n de FFT
audioObj = samdirAudio;
audioObj.samplingRate = fs;

GRAB    = fft (grab.timeData);
EXC     = fft (exc.timeData);
IR      = GRAB./EXC;
ir      = real(ifft(IR));

% Filtrado
[B,A]               = butter(4,[f0/fs f1/fs]);  
audioObj.timeData   = filter(B,A,ir);

% Como esta IR aparece en el origen, se la centra agregandole ceros al
% inicio.
audioObj.timeData   = [zeros(audioObj.nSamples,1);audioObj.timeData];
audioObj.comment    = 'Respuesta al Impulso';
audioObj.signalType = 'energy'; 

varargout(1) = {audioObj};
end
