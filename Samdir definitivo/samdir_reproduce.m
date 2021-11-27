%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_reproduce.m                                              *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_reproduce(varargin)
%   samdir_reproduce - Reproduce el objeto de tipo samdirAudio. También es
%   llamado por el método play.
%
%   Sintaxis:   samdirAudio.play
%               samdir_reproduce(a)

%% Inicialización
audioObj    = varargin{1}; 

%% Variables globales
ID_sal      = 0;
Fs          = 44100;
nBits       = 16;
nChannels   = 1;

%% Reproducción
support_sal = audiodevinfo(0,ID_sal,Fs,nBits,nChannels);
if(support_sal)
    reprod      = audioplayer(audioObj.timeData,Fs,nBits,ID_sal);
    playblocking (reprod);
else
    fprintf('\nParámetros de configuración incorrectos.');
end

end
