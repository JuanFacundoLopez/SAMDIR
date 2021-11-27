%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_indice_dir.m                                        *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%   samdir_plot_indice_dir - Realiza el gr�fico del �ndice de Directividad en
%   funci�n del �ngulo. Recibe como argumento el mismo y el vector de
%   �ngulos.
%
%   samdir_plot_indice_dir(id,angulos)

function varargout = samdir_plot_indice_dir(varargin)
%% Inicializaci�n  
id       = varargin{1}; 
ang     = varargin{2}; 

% Busca el maximo valor en Y y grafica con limites mayores
%yMax = round (max(id));    
%yMin = round (min(id)); 
%yLim = [yMin-2 yMax+2];

%% Gr�fica
figure;
h = plot(ang, id);
xlabel('[grados]');
set(gca,'XTick',[-180, -135, -90, -45, 0, 45, 90, 135, 180]);
set(gca,'YTick',[-10, -5, 0, 5, 10]);
ylabel('[dB]');
set(gca,'YLim', [-10 10]);
grid on
title('�ndice de Directividad');
set(gcf,'Name', '�ndice de Directividad');

end