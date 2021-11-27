%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_banco_filtros.m                                          *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_banco_filtros(varargin)
%   samdir_banco_filtros - Genera el banco de filtros de acuerdo a los
%   argumentos de entrada y lo devuelve como salida. Adem�s devuelve un
%   vector con las frecuencias nominales de los filtros.
%
%   Sintaxis: struct_filtros = samdir_banco_filtros(bandas_por_octava, orden)
%
%   filtros = samdir_banco_filtros(3,8)
%
%% Variables Globales
fs = 48000; 
% Frecuencias nominales seg�n norma IRAM 4081:1977
% 10 frecuencias para banda de octava completa, 31 para tercios de octava.
frec_oct    = [31.5,63,125,250,500,1000,2000,4000,8000,16000];
frec_ter    = [20,25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,...
800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000];
label_oct   = {'31.5','63','125','250','500','1k','2k','4k','8k','16k'};
label_ter   = { '20','25','31.5','40','50','63','80','100','125','160','200',...
                '250','315','400','500','630','800','1k','1.25k','1.6k','2k',... 
                '2.5k','3.15k','4k','5k','6.3k','8k','10k','12.5k','16k','20k'};
%% Inicializaci�n
BandsPerOctave  = varargin{1}; % Bandas por octava
N               = varargin{2}; % Orden del filtro

% Frecuencias nominales seg�n norma IRAM 4081:1977
% 10 frecuencias para banda de octava completa, 31 para tercios de octava.

%% Dise�o del banco de filtros
F0      = 1000;  % Frecuencia central

% Devuelve las especificaciones para dise�ar el filtro con los argumentos
% ingresados, en este caso son filtros de octava completa o fracci�n de
% octava. El primer argumento es la cantidad de bandas por octava, luego la
% clase, despues el campo correspondiente a la especificaci�n, el orden del
% mismo y la frecuencia central. Por �ltimo, la frecuencia de muestreo
f       = fdesign.octave(BandsPerOctave,'Class 1','N,F0',N,F0,fs);

% Se obtiene un vector con todas las frecuencias del rango de audio
F0      = validfrequencies(f);
Nfc     = length(F0);

% Se dise�a el banco de filtros. En este caso con las especificaciones
% guardadas en f, del tipo Butterworth
for i=1:Nfc,
    f.F0 = F0(i);
    Hd(i) = design(f,'butter');
end

% Devuelve los filtros creados y las frecuencias nominales
varargout(1) = {Hd};
varargout(2) = {F0};
          
end

