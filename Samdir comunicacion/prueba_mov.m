%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  Movimiento.m                                                    *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
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
