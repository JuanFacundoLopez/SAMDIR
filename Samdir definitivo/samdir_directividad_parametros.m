%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_directividad_parametros.m                               *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************
%   samdir_directividad_parametros - A partir del vector de potencias
%   ingresado calcula el Factor de Directividad, el Índice de Directividad
%   y el Ángulo de Cobertura (Ancho del Haz). Los dos primeros son vectores
%   en función del ángulo, el último es un valor.
%   Se asume que el vector ingresado está ordenado de la forma
%   -180º -90º 0º 90º 180º.
%
%   Sintaxis: vector = samdir_directividad_parametros(vector,int)
%
%   [ang_cob,q,id] = samdir_directividad_parametros(pot,res)
%***************************************************************************************
function varargout = samdir_directividad_parametros(varargin)
%% Inicialización
pot_dB  = varargin{1}; 
res     = varargin{2}; 

ang     = -180:res:180;
izq     = 0;
der     = 0;
%% Calculo ángulo de cobertura
% Es el ángulo en el cual la potencia se mantiene entre 0 y -6dB

centro  = round(length(pot_dB)/2);
% Búsqueda ángulo derecho
for i=centro:length(pot_dB),
    if (pot_dB(i)<-6)
        der = i;
        break
    end
end
% Búsqueda ángulo izquierdo
for i=centro:-1:1,
    if (pot_dB(i)<-6)
        izq = i;
        break
    end
end

if (izq==0)|(der==0)
    ang_cob = 360;
else
    ang_ini = ang(izq);
    ang_fin = ang(der);
    ang_cob = ang_fin - ang_ini;
end

%% Cálculo Factor de Directividad
% Es la relación entre una fuente isotrópica de potencia igual a la que
% estamos midiendo, para cada ángulo

% Paso los valores en dB a magnitud
pot     = 10.^(pot_dB/10);
% Potencia fuente isotrópica equivalente
pot_iso = sum(pot)/length(pot);
% Factor Q
factor_q= pot/pot_iso;

%% Cálculo Índice de Directividad
% Es el valor del Factor de Directividad en dB
ind_dir = db(factor_q,'power');

% Valores de salida
varargout(1) = {ang_cob};
varargout(2) = {factor_q};
varargout(3) = {ind_dir};
end
