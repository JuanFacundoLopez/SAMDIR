%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Medicion_Directividad_Interpolacion                            *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%% Ejemplo Medicion Directividad

% Variables para ser obtenidas de la GUI
f0          = 22;
f1          = 22000;
fs          = 48000;
fft_d       = 16;
nivel       = 0;
nBits       = 16;
label_oct   = {'31.5','63','125','250','500','1k','2k','4k','8k','16k'};
label_ter   = {'25','31.5','40','50','63','80','100','125','160','200',...
'250','315','400','500','630','800','1k','1.25k','1.6k','2k',... 
'2.5k','3.15k','4k','5k','6.3k','8k','10k','12.5k','16k','20k'};
a           = samdir_generate('expsweep',[f0 f1],fs,fft_d);
% Multiplica la señal por el nivel indicado, por ej: -3dB.
amp         = samdir_nivel(nivel);
a.timeData  = a.timeData.*amp;
b           = samdir_ventaneo('hann',0.05,0.05,a);
[irs,pot_db]    = samdir_directividad(b,0,360,90);
% aplicando interpolación
ang= -180:90:180;
% for (i=1:5)
%     [pot_int(:,i),ang_int] = samdir_directividad_interpolacion(pot_db(:,i),ang,5,'spline');
% end

samdir_plot_directividad(pot_int,label_oct);


