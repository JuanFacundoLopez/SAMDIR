%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  Movimiento.m                                                    *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%   Este script realiza el movimiento del motor en un sentido y en otro



% Crea el objeto serial
pic = samdir_usb();
fopen(pic);

com_ok = samdir_comunicacion(pic,'a',1);

samdir_reset_mec(pic);

samdir_prueba_mec(pic);

samdir_mov_angular(pic,45,10);

fclose(pic);
delete (pic);
clear pic
