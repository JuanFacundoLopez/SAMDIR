%****************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_mov_angular.m                                            *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)    *
%****************************************************************************************
%   samdir_mov_angular - Mueve la plataforma hasta el �ngulo deseado.
%   Devuelve la posici�n actual, para poder utilizar esta funci�n varias
%   veces (medida en pasos en sentido horario).
%
%   samdir_mov_angular(objeto serie,�ngulo,pos.actual);
% 
%   Sintaxis: samdir_mov_angular(pic,45,10);
%

function varargout = samdir_mov_angular(varargin)
%% Inicializaci�n
pic         = varargin{1}; 
angulo      = varargin{2}; 
pos_actual  = varargin{3};
mov_ok = 0;
% Variable global
reduccion   = 30;

%% Desplazamiento
resolucion  = 1.8/reduccion;
media_vuelta= 100*reduccion;
vuelta= 200*reduccion;

pasos = round (angulo/resolucion);
% Cantidad efectiva de pasos a mover
pasos_ef = pasos - pos_actual;

com_ok = samdir_comunicacion(pic,'id',1);
%test_ok = samdir_comunicacion(pic,'test_ok?',1);

if (com_ok)
    % Si el �ngulo nuevo es menor al actual, el valor ser� negativo
    if(pasos_ef<0)
        pasos_ef= abs(pasos_ef);
        % Si el desplazamiento es mayor a 180�, el sentido es horario
        if (pasos_ef>media_vuelta)
            sentido = 1;
            pasos_ef = vuelta - pasos_ef;
        else
            sentido = 0;
        end
        sent_ok = samdir_comunicacion(pic,'sentido',sentido);
        mov_ok = samdir_comunicacion(pic,'pasos',pasos_ef); 
    else
    % Si el �ngulo nuevo es igual o mayor al actual
    % Si el desplazamiento es mayor a 180�, el sentido es antihorario
        if (pasos_ef>media_vuelta)
            sentido = 0;
            pasos_ef = vuelta - pasos_ef;
            sent_ok = samdir_comunicacion(pic,'sentido',sentido);
        else
            sentido = 1;
            sent_ok = samdir_comunicacion(pic,'sentido',sentido);
        end
        mov_ok = samdir_comunicacion(pic,'pasos',pasos_ef); 
    end    

end
pos_actual = pasos;

%fprintf('El dispositivo est� ubicado en el �ngulo indicado.\n ');


varargout(1) = {pos_actual};
varargout(2) = {mov_ok};
end