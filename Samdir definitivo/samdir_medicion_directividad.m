%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_medicion_directividad                                   *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%%
function varargout = samdir_medicion_directividad(varargin)
%   samdir_medicion_directividad - Realiza las grabaciones de la respuesta
%   del sistema mediante una señal de excitación que es ingresada como
%   argumento. También se le ingresa la cantidad de mediciones.
%   Devuelve el struct de grabaciones.
%
%   Sintaxis: samdirAudio = samdir_medicion_directividad(samdirAudio,ensayos)
%
%   grab(5) = samdir_medicion_directividad(excitacion,5)
%
%% Inicialización
modo = false;
audioObj    = varargin{1};
num         = varargin{2};
if(nargin == 3)
    pos_actual = 0;
    pic = varargin{3};
    modo = true;
end
% Inicialización del struct destino de las grabaciones
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
