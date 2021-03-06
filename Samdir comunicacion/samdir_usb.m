%****************************************************************************************
%*   SISTEMA AUTOM?TICO DE MEDICI?N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC?STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_usb.m                                                    *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar?a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier?a Electr?nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci?n y Transferencia en Ac?stica (CINTRA)    *
%****************************************************************************************
%   samdir_usb - La clase USB CDC emula una conexi?n RS232 y lo muestra
%   como un puerto COM en Windows. Esta funci?n crea el objeto serial para
%   establecer la comunicaci?n, y lo devuelve como argumento.
%
%   Sintaxis: objeto_serial = samdir_usb()
%
%   pic = samdir_usb()
%
function varargout = samdir_usb(varargin)

% Esta instrucci?n busca los dispositivos seriales existentes
serialInfo = instrhwinfo('serial');

% Si la PC cuenta con puerto serial f?sico, se identificar? como COM1. El
% puerto emulado tendr? un n?mero mayor, entonces para identificarlo:
if(~isempty(serialInfo.AvailableSerialPorts))
    if length(serialInfo.AvailableSerialPorts)>1

        puerto = serialInfo.AvailableSerialPorts(2);
    else
        puerto = serialInfo.AvailableSerialPorts(1);
    end
    pic = serial(puerto,'BaudRate',9600,'DataBits',8);
    set(pic,'Parity','none','StopBits',1,'FlowControl','none');
    fopen(pic);
else
    pic = 0;
end
% Luego se crea el objeto serial con las caracter?sticas determinadas por
% el firmware del uC: 9600 baudios, 8 bits de datos, 1 bit de paridad, 
% sin control de flujo  
	
varargout(1) = {pic};
end