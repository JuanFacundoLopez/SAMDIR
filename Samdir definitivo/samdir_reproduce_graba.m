%***************************************************************************************
%*   SISTEMA AUTOM?TICO DE MEDICI?N DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROAC?STICOS  *
%***************************************************************************************
%* Nombre del Archivo:  samdir_reproduce_graba.m                                       *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana Mar?a                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingenier?a Electr?nica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigaci?n y Transferencia en Ac?stica (CINTRA)   *
%***************************************************************************************
%%
function varargout = samdir_reproduce_graba(varargin)
%   samdir_grabar - Reproduce una se?al ingresada como argumento y
%   devuelve la grabaci?n.
%
%   Sintaxis: samdirAudio = samdir_reproduce_graba(samdirAudio)
%   
%   b = samdir_grabar(a)
%   
%% Inicializaci?n  
%fs          = 48000;
excitacion  = varargin{1};
input       = varargin{2};
output      = varargin{3};
fs          = varargin{4};
grabacion   = samdirAudio;
grabacion.samplingRate = fs;

% Se revisa que los dispositivos seleccionados soportan los par?metros
support_ent = 1;
support_sal = 1;

if(support_ent&&support_sal)
    
    % Samples de silencio por la latencia en la grabaci?n
    latencia1 = 0.6*fs;         
    latencia2 = 0.6*fs; 
    silencio1 = zeros(latencia1,1);
    silencio2 = zeros(latencia2,1);
    excitacion_mod = [silencio1;excitacion.timeData;silencio2];
    
    % Creaci?n de los objetos de reproducci?n y grabaci?n
    entrada     = analoginput('winsound', input);   
    addchannel(entrada, 1);     
    entrada.SampleRate = fs;
    entrada.TriggerType = 'Immediate';
    entrada.SamplesPerTrigger = length(excitacion_mod);

    salida      = analogoutput('winsound',output);
    addchannel(salida, [1 2]);      
  %  addchannel(salida, 1);      
    salida.SampleRate = fs;    
    salida.TriggerType = 'Immediate'; 
    dato0 = zeros(length(excitacion_mod), 1);
    putdata(salida,[excitacion_mod dato0]);
   % putdata(salida,excitacion_mod);
    
    %% Reproducci?n y grabaci?n
    start([entrada salida]);
    datos = getdata(entrada);
    delete ([entrada salida]);
    
    %% Correlaci?n para eliminar la latencia
    grabacion.timeData  = samdir_correlacion(excitacion_mod,datos,latencia1,latencia2);
    grabacion.comment   = ['Grabaci?n - ' excitacion.comment];   
else
    fprintf('\nPar?metros de configuraci?n incorrectos.');    
end

varargout(1) = {grabacion};
end