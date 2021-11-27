%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_directividad.m                                          *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%
%   Sintaxis: [struct samdirAudio,vec,vec] = samdir_normalizacion_directividad(samdirAudio,int,int)
%
%   [pot_db,pot_db_ref]= samdir_normalizacion_directividad(pot_db,num,giro);

function [pot_db_mod,pot_db_ref]= samdir_normalizacion_directividad(pot_db,num,giro)

%% Normalización a la medición en 0°
pot_db_ref = zeros (num,length(pot_db(1,:)));
for i=1:num,
	pot_db_ref(i,:)= pot_db(i,:) - pot_db(1,:);
end

% Si es un giro completo, se repite la primer medición para cerrar el
% gráfico polar
if (giro)
    pot_db(num+1,:)       = pot_db(1,:);
    pot_db_ref(num+1,:)   = pot_db_ref(1,:);
end

% Se realiza el ploteo de la directividad. La función dirplot() realiza el
% gráfico desde -180 a 180, por lo que es necesario antes reacomodar los 
% valores.
for i=1:length(pot_db(1,:)),
	pot_db_mod (:,i) = samdir_directividad_ordenar (pot_db_ref(:,i));
end


varargout(1) = {pot_db_mod};
varargout(2) = {pot_db_ref};
end