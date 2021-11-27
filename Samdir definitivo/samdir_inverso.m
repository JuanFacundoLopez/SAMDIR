%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_inverso.m                                               *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_inverso(varargin)
%   samdir_inverso - Calcula el filtro según el método de A. Farina 
%   (Simultaneous measurement of impulse response and distortion with a 
%   swept-sine technique, 2000) realizando la inversión de las muestras en 
%   el tiempo y aplicando una envolvente exponencial de -10db/decada para 
%   compensar la energía.
%
%   Sintaxis: samdirAudio = samdir_inverso(samdirAudio, rangoFrecuencias)
%
%   b = samdir_inverso(a,[f0 f1])
%
%% Inicialización
result = varargin{1}; 
f0 = varargin{2}(1);
f1 = varargin{2}(2);


%% Inversión de las muestras y pendiente -10dB/dec
w1=2*pi*f0;
w2=2*pi*f1;
L=result.trackLength/log(w2/w1);
result.timeData = result.timeData(end:-1:1);
result.timeData = result.timeData.*exp(-result.timeVector./L);
result.comment  = ['Filtro inverso - ' result.comment];

varargout(1) = {result};
end
