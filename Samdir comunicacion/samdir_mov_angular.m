%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_mov_angular.m                                            *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%   samdir_mov_angular - Mueve la plataforma hasta el ángulo deseado.
%   Devuelve la posición actual, para poder utilizar esta función varias
%   veces (medida en pasos en sentido horario).
%
%   samdir_mov_angular(objeto serie,ángulo,pos.actual);
% 
%   Sintaxis: samdir_mov_angular(pic,45,10);
%

function varargout = samdir_mov_angular(varargin)
%% Inicialización
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
    % Si el ángulo nuevo es menor al actual, el valor será negativo
    if(pasos_ef<0)
        pasos_ef= abs(pasos_ef);
        % Si el desplazamiento es mayor a 180º, el sentido es horario
        if (pasos_ef>media_vuelta)
            sentido = 1;
            pasos_ef = vuelta - pasos_ef;
        else
            sentido = 0;
        end
        sent_ok = samdir_comunicacion(pic,'sentido',sentido);
        mov_ok = samdir_comunicacion(pic,'pasos',pasos_ef); 
    else
    % Si el ángulo nuevo es igual o mayor al actual
    % Si el desplazamiento es mayor a 180º, el sentido es antihorario
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

%fprintf('El dispositivo está ubicado en el ángulo indicado.\n ');


varargout(1) = {pos_actual};
varargout(2) = {mov_ok};
end