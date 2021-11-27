%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   *
%****************************************************************************************
%* Nombre del Archivo:  samdir_plot_factor_q.m                                          *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%   samdir_plot_factor_q - Realiza el gr�fico del Factor de Directividad en
%   funci�n del �ngulo. Recibe como argumento el mismo y el vector de
%   �ngulos.
%
%   samdir_plot_factor_q(factor_q,angulos)

function varargout = samdir_plot_factor_q(varargin)
%% Inicializaci�n  
q       = varargin{1}; 
ang     = varargin{2}; 

% Busca el maximo valor en Y y grafica con limites mayores
yMax = round (max(q));   
yMin = 0;    
yLim = [yMin yMax+1];

%% Gr�fica
figure;
h = semilogy(ang, q);
xlabel('[grados]');
set(gca,'XTick',[-180, -135, -90, -45, 0, 45, 90, 135, 180]);
set(gca,'YTick',[0.1 0.2 0.4 0.6 0.8 1 2 4 6 8 10]);
%set(gca,'yLim', yLim);
set(gca,'YLim', [0.1 10]);
grid on
title('Factor de Directividad');
set(gcf,'Name', 'Factor de Directividad');

end