%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_directividad_parametros.m                               *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************
%   samdir_directividad_parametros - A partir del vector de potencias
%   ingresado calcula el Factor de Directividad, el �ndice de Directividad
%   y el �ngulo de Cobertura (Ancho del Haz). Los dos primeros son vectores
%   en funci�n del �ngulo, el �ltimo es un valor.
%   Se asume que el vector ingresado est� ordenado de la forma
%   -180� -90� 0� 90� 180�.
%
%   Sintaxis: vector = samdir_directividad_parametros(vector,int)
%
%   [ang_cob,q,id] = samdir_directividad_parametros(pot,res)
%***************************************************************************************
function varargout = samdir_directividad_parametros(varargin)
%% Inicializaci�n
pot_dB  = varargin{1}; 
res     = varargin{2}; 

ang     = -180:res:180;
izq     = 0;
der     = 0;
%% Calculo �ngulo de cobertura
% Es el �ngulo en el cual la potencia se mantiene entre 0 y -6dB

centro  = round(length(pot_dB)/2);
% B�squeda �ngulo derecho
for i=centro:length(pot_dB),
    if (pot_dB(i)<-6)
        der = i;
        break
    end
end
% B�squeda �ngulo izquierdo
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

%% C�lculo Factor de Directividad
% Es la relaci�n entre una fuente isotr�pica de potencia igual a la que
% estamos midiendo, para cada �ngulo

% Paso los valores en dB a magnitud
pot     = 10.^(pot_dB/10);
% Potencia fuente isotr�pica equivalente
pot_iso = sum(pot)/length(pot);
% Factor Q
factor_q= pot/pot_iso;

%% C�lculo �ndice de Directividad
% Es el valor del Factor de Directividad en dB
ind_dir = db(factor_q,'power');

% Valores de salida
varargout(1) = {ang_cob};
varargout(2) = {factor_q};
varargout(3) = {ind_dir};
end
