%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Directividad.m                                                 *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%% Ejemplo: Genera la se�al de excitaci�n. Mide las IR y grafica los diagramas de Directividad

f0      = 22;
f1      = 22000;
fs      = 48000;
fft_d   = 16;
nivel   = 0;
nBits       = 16;

a = samdir_generate('expsweep',[f0 f1],fs,fft_d);
amp = samdir_nivel(nivel);
a.timeData=a.timeData.*amp;
b = samdir_ventaneo('hann',0.05,0.05,a)
[irs,pot_db_abs,pot_db_ref] = samdir_directividad(b, false);