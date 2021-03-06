%****************************************************************************************
%*   SISTEMA AUTOM?TICO DE MEDICI?N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC?STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_energia.m                                                *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar?a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier?a Electr?nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci?n y Transferencia en Ac?stica (CINTRA)    *
%****************************************************************************************
%%
function varargout = samdir_energia(varargin)
%   samdir_potencia_bandas - Calcula la energ?a de la se?al ingresada
%   como argumento, luego realiza el gr?fico con el eje de abcisas en dB.
%
%   Sintaxis: samdir_energia(samdirAudio)
%
%% Variables Globales


%% Inicializaci?n
audioObj    = varargin{1};
energia     = audioObj.timeData.^2;
xVec = audioObj.timeVector;

% Busca el maximo valor en Y, normaliza y pasa a dB
yMax         = max(energia);    
energia_norm = energia/yMax;
energia_db   = db(energia_norm,'power');

% Busca el m?nimo valor en db, y si es menor que -120dB pone ese l?mite
yMin         = min(energia_db);  
if yMin < -120
     yLim = [-120 5];
else
     yLim = [yMin-10 5];
end

for i=1:length(energia),
    if energia_db(i) < -120,
        % Para que no se vea la l?nea en los espacios vac?os
        energia_db(i) = -130;
    end
end

%% Gr?fica
figure;
h = plot(xVec, energia_db);
xlabel('seg');
ylabel('dB');
set(gca,'XLim', xVec([1 end]));
set(gca,'YLim', yLim);
grid on
audioObj.comment = ['Energ?a - ' audioObj.comment];
title(audioObj.comment);
set(gcf,'Name', audioObj.comment);

end
