%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_division_FFT.m                                           *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%   samdir_deconv_lineal - Realiza la deconvolución mediante la división
%   de la FFT de la señal grabada y la FFT de la señal de excitación.
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

%% Inicialización
grab    = varargin{1}; 
exc     = varargin{2}; 

%% Deconvolución por división de FFT
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
