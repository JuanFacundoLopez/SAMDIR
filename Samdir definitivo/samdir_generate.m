%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_generate.m                                               *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_generate(varargin)
%  samdir_generate - Genera las señales necesarias para la medición.
%  Este script está basado en ITA-Toolbox, proyecto desarrollado por
%  Institute of Technical Acoustics, RWTH Aachen University.
%  Autor: Pascal Dietrich -- Email: pdi@akustik.rwth-aachen.de
%
%  A continuación se muestran ejemplos:
%
%  Sintaxis: samdirAudio = samdir_generate('tipo', Amplitud,(Frec),SamplingRate,fft_degree)
%
%  a = samdir_generate('impulse',1,44100,15)
%  a = samdir_generate('impulsetrain',1,44100,15,cantidad de impulsos)
%  a = samdir_generate('sine',1,1000,44100,15)
%  a = samdir_generate('cosine',1,1000,44100,15)
%  a = samdir_generate('whitenoise',1,44100,15)
%  a = samdir_generate('pinknoise',1,44100,15)
%
%  Barridos:

%  Sintaxis: samdirAudio = samdir_generate(sweeptype,freq_range,[stopmargin],sr,fft_degree)
%  
%  b = samdir_generate('expsweep',[2 22000],44100,18) 
%  b = samdir_generate('linsweep',[2 22000],0.5,44100,18)
%
%  sweeptype:  	puede ser linsweep (lineal) o expsweep (exponencial)
%  freq_range: 	vector con la frecuencia inicial y la final de la forma [f1 f2]
%  stopmargin: 	segundos de silencio al final del barrido
%  sr:         	frecuencia de muestreo en Hz
%  fft_degree: 	grado de la FFT, lo que indica la duración de la señal.

%% Inicialización

error(nargchk(0,7,nargin,'string'));

% if there is no input parameter --> GUI                        %VER
if nargin == 0
else
    signal_type  = varargin{1};
    
    %% Generación de las distintas señales
    audioObj = samdirAudio();
    switch lower(signal_type)
            
        
        case {'impulse'}                        %Impulso
            if nargin ~= 4
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            SamplingRate = varargin{3};
            fft_degree   = varargin{4};
            if fft_degree > 40
                nSamples = fft_degree;
            else
                nSamples = 2^fft_degree;
            end
            audioObj.timeData   = zeros(nSamples,1);
            
            audioObj.timeData(1,:) = Amplitude;
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = 'Impulso';
            audioObj.signalType = 'energy';     %señal de energia %VER
        
            
        case {'impulsetrain'}                   %Tren de impulsos
            if nargin ~= 5
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            SamplingRate = varargin{3};
            fft_degree   = varargin{4};
            repetition   = varargin{5};
            FullSize = 2^fft_degree;
            Interval = round(FullSize/repetition);
            audioObj.timeData   = zeros(FullSize,1);
            audioObj.timeData(1:Interval:FullSize,:) = Amplitude;
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = 'Tren de impulsos';
            audioObj.signalType = 'energy';     %señal de energia %VER
        
            
        case {'sine'}                           %Tono senoidal
            if nargin ~= 5 
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            Frequency    = varargin{3};
            SamplingRate = varargin{4};
            fft_degree   = varargin{5};
            audioObj.timeData = Amplitude.*sin((1:2^(fft_degree))./ SamplingRate * 2.* pi * Frequency).';
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = ['Seno - '  num2str(Frequency) 'Hz' ];
            audioObj.signalType = 'power';      %señal de potencia %VER
        
            
        case {'cosine'}                         %Tono cosenoidal
            if nargin ~= 5
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            Frequency    = varargin{3};
            SamplingRate = varargin{4};
            fft_degree   = varargin{5};
            audioObj.timeData = Amplitude.*cos((1:2^(fft_degree))./ SamplingRate * 2.* pi * Frequency).';
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = ['Coseno - '  num2str(Frequency) 'Hz' ];
            audioObj.signalType = 'power';      %señal de potencia %VER
          
            
        case {'whitenoise'}                     %Ruido blanco
            if nargin ~= 4
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            SamplingRate = varargin{3};
            fft_degree   = varargin{4};
            if fft_degree > 30
                nSamples = fft_degree;
            else
                nSamples = 2.^fft_degree;
            end
           
            audioObj.timeData  = randn(round(nSamples),1).*Amplitude;
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = 'Ruido Blanco';
            audioObj.signalType = 'power';      %señal de potencia %VER
            
            
       case {'pinknoise'}                       %Ruido rosa
            if nargin ~= 4
                error('samdir_generate: Verificar la sintaxis')
            end
            Amplitude    = varargin{2};
            SamplingRate = varargin{3};
            fft_degree   = varargin{4};
            audioObj.timeData   = randn(2.^fft_degree,1).*Amplitude;
            audioObj.samplingRate = SamplingRate;
            audioObj.comment = 'Ruido Rosa';
            audioObj    =   samdir_fft(audioObj);
            bin_dist    =   audioObj.samplingRate ./ (2 .* (audioObj.nBins - 1));
            bin_vector  =   (0:audioObj.nBins-1).' .* bin_dist;
            audioObj.freqData  =   audioObj.freqData ./  sqrt(bin_vector .* 2 .* pi .* 1i);
            audioObj.signalType = 'power';      %señal de potencia %VER
            audioObj      =   samdir_ifft(audioObj);
            
            
        case {'linsweep','expsweep'}            %Barridos
            switch lower(signal_type)
                case {'linsweep'}
                    methodStr = 'linear';
                case {'expsweep'}
                    methodStr = 'exponential';
            end
            if nargin == 4                      %sin stopmargin y con vector de frecuencia
                f0 = varargin{2}(1); f1 = varargin{2}(2); samplingRate = varargin{3}; FFT_degree = varargin{4};
            elseif nargin == 5
                if length(varargin{2}) == 2     %vector de frecuencia
                    f0 = varargin{2}(1); f1 = varargin{2}(2); stopMargin = varargin{3}; samplingRate = varargin{4}; FFT_degree = varargin{5};
                else                            %la frecuencia se da en forma separada
                    f0 = varargin{2}; f1 = varargin{3}; samplingRate = varargin{4}; FFT_degree = varargin{5};
                end
            elseif nargin == 6
                f0 = varargin{2}; f1 = varargin{3}; stopMargin = varargin{4}; samplingRate = varargin{5}; FFT_degree = varargin{6};
            else
                error('samdir_generate: Verificar la sintaxis')
            end
            if (FFT_degree > 35) && (samplingRate > 35)
                FFT_degree = log2(FFT_degree);
            else
                if FFT_degree > samplingRate
                    [FFT_degree, samplingRate] = deal(samplingRate,FFT_degree);
                end
            end
            if ~exist('stopMargin','var')       %hace un barrido completo;
                nSamples = 2.^FFT_degree;
            else                                %hace un barrido descontando el tiempo de silencio;
                nSamples = 2.^FFT_degree - round(stopMargin.*samplingRate./2)*2;
                if nSamples <= 0;
                    error(['samdir_generate: El margen de silencio es muy grande. La señal tiene ' num2str(2.^FFT_degree ./ samplingRate) 's.'])
                end
            end
            sil=2.^FFT_degree-nSamples;         %Cantidad de ceros a agregar
            v_sil=zeros(sil,1);                 %Vector de ceros
            t = (0:nSamples-1)./samplingRate;   %VER cambie el inicio
            t1  = nSamples./samplingRate;
            phi = 90;                           %VER
            if f0 <= 1e-6
                if verboseMode, disp('samdir_generate:La frecuencia inferior debe ser mayor que 1e-6'); end;
                f0 = 1e-6;
            end
            if strcmp(methodStr,'exponential') ;%la funcion chirp de matlab usa 'logarithmic'
                methodStr4chirp = 'logarithmic';
            else
                methodStr4chirp = methodStr;
            end;
            audioObj.samplingRate = samplingRate;
            audioObj.timeData    = chirp(t,f0,t1,f1,methodStr4chirp,phi).';
            time_orig = audioObj.timeData;
            time_orig = [time_orig;v_sil];      %Vector de ceros agregado al final
            audioObj.timeData = time_orig;
            if strcmp(methodStr,'exponential')
                audioObj.comment = ['Barrido senoidal exponencial de ' num2str(f0) ' a ' num2str(f1) 'Hz'];
            else
                audioObj.comment = ['Barrido senoidal lineal de ' num2str(f0) ' a ' num2str(f1) 'Hz'];
                
            %audioObj.samplingRate = samplingRate;
            
            audioObj.signalType = 'power';      %señal de potencia %VER
     
            end
    end

%% Devuelve el valor de salida
varargout(1) = {audioObj};

end
