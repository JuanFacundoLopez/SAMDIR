%****************************************************************************************
%*   SISTEMA AUTOM?TICO DE MEDICI?N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC?STICOS   * 
%****************************************************************************************
%* Nombre del Archivo:  samdir_prueba_mec.m                                             *                                                  
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar?a                       *
%*                      Proyecto Final de Grado                                         *
%*                      Ingenier?a Electr?nica - UTN-FRC - Argentina                    *
%* Entidad:             Centro de Investigaci?n y Transferencia en Ac?stica (CINTRA)    *
%****************************************************************************************
%   samdir_prueba_mec - Realiza mediante software una prueba mec?nica del 
%   sistema para asegurarse que se pueda controlar el transductor sin
%   fallar en la resoluci?n. Para eso mueve el transductor 90 grados en
%   sentido horario y luego la misma cantidad en sentido antihorario. 
%   Antes debe ubicar en 0? la plataforma.
%
%   samdir_prueba_mec(pic)
%
function varargout = samdir_prueba_mec(varargin)
%% Inicializaci?n
pic     = varargin{1}; 

%% Inicio de la prueba
% Primero pregunta si la prueba se ha realizado 
test_ok = samdir_comunicacion(pic,'test_ok?',1);

if (test_ok)
    fprintf('\n La prueba mec?nica ya se ha realizado');
else
    % Resetea volviendo a la posici?n 0?
    samdir_reset_mec(pic);
    % Manda la orden de iniciar el test
    test_tx = samdir_comunicacion(pic,'test',1);
    % Pregunta nuevamente
    test_ok = samdir_comunicacion(pic,'test_ok?',1);
end

if (test_ok)
    fprintf('\n Prueba mec?nica exitosa');
else
    fprintf('\n Prueba mec?nica fallida');    
end

end
