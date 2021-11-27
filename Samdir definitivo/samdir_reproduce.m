%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_reproduce.m                                              *                                    
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_reproduce(varargin)
%   samdir_reproduce - Reproduce el objeto de tipo samdirAudio. Tambi�n es
%   llamado por el m�todo play.
%
%   Sintaxis:   samdirAudio.play
%               samdir_reproduce(a)

%% Inicializaci�n
audioObj    = varargin{1}; 

%% Variables globales
ID_sal      = 0;
Fs          = 44100;
nBits       = 16;
nChannels   = 1;

%% Reproducci�n
support_sal = audiodevinfo(0,ID_sal,Fs,nBits,nChannels);
if(support_sal)
    reprod      = audioplayer(audioObj.timeData,Fs,nBits,ID_sal);
    playblocking (reprod);
else
    fprintf('\nPar�metros de configuraci�n incorrectos.');
end

end
