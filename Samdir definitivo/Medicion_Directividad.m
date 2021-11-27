%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Medicion_Directividad                                          *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%% Ejemplo Medicion Directividad

% Variables para ser obtenidas de la GUI
f0          = 22;
f1          = 22000;
fs          = 48000;
fft_d       = 16;
nivel       = 0;
nBits       = 16;

a           = samdir_generate('expsweep',[f0 f1],fs,fft_d);
% Multiplica la se�al por el nivel indicado, por ej: -3dB.
amp         = samdir_nivel(nivel);
a.timeData  = a.timeData.*amp;
b           = samdir_ventaneo('hann',0.05,0.05,a);
[irs,pot_db]    = samdir_directividad(b,0,360,90);

