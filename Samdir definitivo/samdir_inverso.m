%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_inverso.m                                               *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_inverso(varargin)
%   samdir_inverso - Calcula el filtro seg�n el m�todo de A. Farina 
%   (Simultaneous measurement of impulse response and distortion with a 
%   swept-sine technique, 2000) realizando la inversi�n de las muestras en 
%   el tiempo y aplicando una envolvente exponencial de -10db/decada para 
%   compensar la energ�a.
%
%   Sintaxis: samdirAudio = samdir_inverso(samdirAudio, rangoFrecuencias)
%
%   b = samdir_inverso(a,[f0 f1])
%
%% Inicializaci�n
result = varargin{1}; 
f0 = varargin{2}(1);
f1 = varargin{2}(2);


%% Inversi�n de las muestras y pendiente -10dB/dec
w1=2*pi*f0;
w2=2*pi*f1;
L=result.trackLength/log(w2/w1);
result.timeData = result.timeData(end:-1:1);
result.timeData = result.timeData.*exp(-result.timeVector./L);
result.comment  = ['Filtro inverso - ' result.comment];

varargout(1) = {result};
end
