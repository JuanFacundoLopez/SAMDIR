%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_fft.m                                                    *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function result = samdir_fft(varargin)
%   samdir_fft - Calcula el espectro de una señal dada en el dominio del
%   tiempo. Se descartan las frecuencias negativas ya que no tienen sentido
%   físico
%
%   Sintaxis: samriAudio = samdir_fft(samdirAudio)
%
%   Este script está basado en ITA-Toolbox, proyecto desarrollado por
%   Institute of Technical Acoustics, RWTH Aachen University.
%   Autor: Pascal Dietrich -- Email: pdi@akustik.rwth-aachen.de

%% Inicialización
error(nargchk(1,2,nargin));

if isa(varargin{1}, 'samdirAudio')
    audioObj = varargin{1};
%Verifica si ya está en el dominio de la frecuencia. Si es así, lo retorna  VER
    if audioObj.isFreq
        result = audioObj;
        return;
    end
else
    error('Error: esta función solo trabaja con objetos del tipo samdirAudio')
end

%% VER
if audioObj.isempty
   audioObj.domain = 'freq';
   result = audioObj;
   return;
end

%% Realiza la FFT
fftResult = fft(audioObj.timeData);

%% Se descartan las frecuencias negativas
nSamples = audioObj.nSamples;
if audioObj.isEvenSamples
    fftResult = fftResult(1:(nSamples+2)/2,:);
else
    disp('Numero impar de samples');
    fftResult = fftResult(1:(nSamples+1)/2,:);
end

%% Normalización del espectro de acuerdo a si son señales de potencia o energía (impulsos)

switch audioObj.signalType
    case 'power'
        MulFac = 1/nSamples;
    case 'energy'
        MulFac = 1;
end

% Para obtener la correcta magnitud de las componentes en frecuencia es
% necesario normalizar dividiendo la salida de la FFT entre el valor N del
% total de samples.
% Además, como sólo utilizamos la mitad del espectro (frecuencias
% positivas), las amplitudes deben ser multiplicadas por 2, menos las
% correspondientes a DC y Frecuencia Nyquist (fs/2). A su vez, los valores
% en amplitudes deben ser pasados a valor eficaz, dividiendo por sqrt(2)
% (menos el correspondiente a DC)
% Entonces, DC---> igual,       fs/2 ---> / sqrt(2).
% Las restantes ---> * 2 / sqrt(2) = * sqrt(2)
% Las señales de energía no se modifican.

if audioObj.isPower
    if audioObj.isEvenSamples
        fftResult(end,:) = fftResult(end,:)/sqrt(2);
        fftResult(2:end-1,:) = fftResult(2:end-1,:)*sqrt(2);
    else
        fftResult(2:end,:) = fftResult(2:end,:)*sqrt(2);
    end
end

audioObj.freqData = MulFac * fftResult;
%% Devuelve el valor de salida
result = audioObj;
end
