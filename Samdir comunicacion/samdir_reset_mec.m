%****************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_reset_mec.m                                              *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)    *
%****************************************************************************************
%   Resetea el sistema, llevándolo a la posición 0°. Esto se realiza 
%   mediante 4 sensores ubicados en las posiciones:
%   
%   sen_1   0°, 
%   sen_2   90°,
%   sen_3   180°,
%   sen_4   270°. 
%   
%   Cuando la plataforma se mueve por algunas de estas
%   posiciones, se elige el camino más corto para llegar a 0°.
%
%   Sintaxis: samdir_reset_mec(pic);
%
function varargout = samdir_reset_mec(varargin)
%% Inicialización
pic     = varargin{1}; 

%% Chequea el estado de los sensores y mueve de acuerdo al resultado
sens = samdir_comunicacion(pic,'sensores',1);
% Configura el sentido horario
sent_ok = samdir_comunicacion(pic,'sentido',1);
% Mueve la plataforma de a un paso hasta que se active un sensor
while (sens == 0)
    mov_ok = samdir_comunicacion(pic,'pasos',1);
    sens = samdir_comunicacion(pic,'sensores',1);
end

% De acuerdo al sensor activado, se efectúa el movimiento más corto
switch (sens)
    case {2}
        % Sentido antihorario, de 90º a 0º
        sent_ok = samdir_comunicacion(pic,'sentido',0);
        mov_ok = samdir_comunicacion(pic,'pasos',50);
    
    case {3}
        % Sentido antihorario, de 180º a 0º
        sent_ok = samdir_comunicacion(pic,'sentido',0);
        mov_ok = samdir_comunicacion(pic,'pasos',100);

    case {4}
        % Sentido horario, de 270º a 0º
        sent_ok = samdir_comunicacion(pic,'sentido',1);
        mov_ok = samdir_comunicacion(pic,'pasos',50);
        
end

fprintf('La mesa está en 0°.\n');

end