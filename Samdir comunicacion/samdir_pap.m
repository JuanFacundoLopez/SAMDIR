function samdir_pap(varargin)
%% Inicialización
pic         = varargin{1}; 
angulo      = varargin{2}; 

mov_ok = 0;
% Variable global
reduccion   = 30;

%% Desplazamiento
resolucion  = 1.8/reduccion;

pasos = round (angulo/resolucion);
mov_ok = samdir_comunicacion(pic,'pasos',pasos); 

end