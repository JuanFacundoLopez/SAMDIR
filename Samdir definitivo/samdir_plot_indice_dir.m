%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_indice_dir.m                                        *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%   samdir_plot_indice_dir - Realiza el gráfico del Índice de Directividad en
%   función del ángulo. Recibe como argumento el mismo y el vector de
%   ángulos.
%
%   samdir_plot_indice_dir(id,angulos)

function varargout = samdir_plot_indice_dir(varargin)
%% Inicialización  
id       = varargin{1}; 
ang     = varargin{2}; 

% Busca el maximo valor en Y y grafica con limites mayores
%yMax = round (max(id));    
%yMin = round (min(id)); 
%yLim = [yMin-2 yMax+2];

%% Gráfica
figure;
h = plot(ang, id);
xlabel('[grados]');
set(gca,'XTick',[-180, -135, -90, -45, 0, 45, 90, 135, 180]);
set(gca,'YTick',[-10, -5, 0, 5, 10]);
ylabel('[dB]');
set(gca,'YLim', [-10 10]);
grid on
title('Índice de Directividad');
set(gcf,'Name', 'Índice de Directividad');

end