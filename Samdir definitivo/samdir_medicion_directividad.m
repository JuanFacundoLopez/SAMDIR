%***************************************************************************************
%*   SISTEMA AUTOM�TICO DE MEDICI�N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC�STICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_medicion_directividad                                   *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar�a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier�a Electr�nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci�n y Transferencia en Ac�stica (CINTRA)   *
%***************************************************************************************/
%%
function varargout = samdir_medicion_directividad(varargin)
%   samdir_medicion_directividad - Realiza las grabaciones de la respuesta
%   del sistema mediante una se�al de excitaci�n que es ingresada como
%   argumento. Tambi�n se le ingresa la cantidad de mediciones.
%   Devuelve el struct de grabaciones.
%
%   Sintaxis: samdirAudio = samdir_medicion_directividad(samdirAudio,ensayos)
%
%   grab(5) = samdir_medicion_directividad(excitacion,5)
%
%% Inicializaci�n
modo = false;
audioObj    = varargin{1};
num         = varargin{2};
if(nargin == 3)
    pos_actual = 0;
    pic = varargin{3};
    modo = true;
end
% Inicializaci�n del struct destino de las grabaciones
struct_grab(num) = samdirAudio;

%% Ensayos y movimiento del motor
for i=1:num,
    if(modo)
        struct_grab(i) = samdir_reproduce_graba(audioObj, logger);
        
        samdir_logMensajes(logger,'Me estoy moviendo');
        pause (2);
    else
        struct_grab(i) = samdir_reproduce_graba(audioObj);
        fprintf('\nMe estoy moviendo.\n');
        pause (2);
    end
end

varargout(1) = {struct_grab};
end
