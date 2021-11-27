%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Ver_Filtros.m                                                  *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%% Muestra en pantalla la respuesta en frecuencia de los filtros generados

% Variables para ser obtenidas de la GUI
fs      = 48000;
fft_d   = 16;
orden_filtro    = 10;
bandas_octava   = 1;

% Generaci�n de un impulso, FT constante en todo el ancho de banda
a = samdir_generate('impulse',1,fs,fft_d);

% Generaci�n de los filtros
[filtros, frec_nominal] = samdir_banco_filtros(bandas_octava,orden_filtro);

% Caracterizaci�n
b = samdirAudio();
b.samplingRate = fs;

for i = 1:length(frec_nominal)
    b(i).timeData = filter(filtros(i),a.timeData);
   % b(i).comment = ['Filtro pasa banda - Frec. central' frec_nominal(i) 'Hz'];
   % b(i).comment = [strcat['Filtro pasa banda - Frec. central', frec_nominal(i),' Hz']];
end

% Muestra todos los filtros en la misma gr�fica
samdir_plot_freq_mult (b, 'Filtros seleccionados');

% Si se quiere graficar alguno individualmente, ya tiene como comentario su
% frecuencia central ----> b(1).plot_freq
% Si se necesita esta informacion como vector se llama a "frec_nominal"


