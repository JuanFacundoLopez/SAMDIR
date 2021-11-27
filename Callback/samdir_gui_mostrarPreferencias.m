function [preferencias structPreferencias]= samdir_gui_mostrarPreferencias()

dateto = datestr(now,'mm/dd/yy HH:MM:SS AM');
rangoFrecuencia = ['[' num2str(set_preferencias('freqInicial')) ' ' num2str(set_preferencias('freqFinal')) ']'];
%set_preferencias('rangoFrecuencia', rangoFrecuencia);
ventana = [ num2str(set_preferencias('inicioVentana')) ' ' num2str(set_preferencias('finVentana'))];

preferencias = [{[set_preferencias('usuario') '@' dateto ]};...
    {[set_preferencias('tipo') ' ' rangoFrecuencia ' ' ]};
    {[num2str(set_preferencias('duracion')) ' seg.' ' ' num2str(set_preferencias('samplingRate'))]};...
    {[set_preferencias('tipoVentana') ' ' ventana]}; ...
    {['Comentario: ' ' ' set_preferencias('comentarios') ]}; ...
    {['Equipo: ' ' ' set_preferencias('equipos') ]}];

tipoDeVentana = set_preferencias('tipoVentana');

switch (tipoDeVentana)
    
    case {'Hann'}                       %Ventana Hann
        structPreferencias.tipoVentana = 'hann';            
    case {'Hamming'}                    %Ventana Hamming
        structPreferencias.tipoVentana = 'hamming';            
    case {'Flat Top'}                 %Ventana Flat Top
        structPreferencias.tipoVentana = 'flattopwin';            
    case {'Blackman'}                   %Ventana Blackman
        structPreferencias.tipoVentana = 'blackman';            
    case {'Bartlett'}                   %Ventana Bartlett
        structPreferencias.tipoVentana = 'bartlett';            
    case {'Bartlett-Hann'}                %Ventana Bartlett-Hann modificada
        structPreferencias.tipoVentana = 'barthannwin';            
    case {'Blackman-Harris'}             %Ventana Blackman-Harris de 4 terminos
        structPreferencias.tipoVentana = 'blackmanharris';            
    case {'Bohman'}                  %Ventana Bohman 
        structPreferencias.tipoVentana = 'bohmanwin';            
    case {'Chebyshev'}                    %Ventana Chebyshev 
        structPreferencias.tipoVentana = 'chebwin';            
    case {'Gaussian'}                   %Ventana Gaussian 
        structPreferencias.tipoVentana = 'gausswin';            
    case {'Kaiser'}                     %Ventana Kaiser 
        structPreferencias.tipoVentana = 'kaiser';            
    case {'Nuttall'}                 %Ventana Nuttall
        structPreferencias.tipoVentana = 'nuttallwin';            
    case {'Parzen'}                  %Ventana Parzen
        structPreferencias.tipoVentana = 'parzenwin';            
    case {'Rectangular'}                    %Ventana Rectangular
        structPreferencias.tipoVentana = 'rectwin';            
    case {'Taylor'}                  %Ventana Taylor
       structPreferencias.tipoVentana = 'taylorwin';             
    case {'Tukey'}                   %Ventana Tukey 
       structPreferencias.tipoVentana = 'tukeywin';            
    case {'Triangular'}                     %Ventana Triangular 
       structPreferencias.tipoVentana = 'triang';
        
end
structPreferencias.usuario = set_preferencias('usuario');
structPreferencias.rangoFrecuencia = [set_preferencias('freqInicial') set_preferencias('freqFinal')];
structPreferencias.samplingRate = set_preferencias('samplingRate');
structPreferencias.tipoExcitacion = set_preferencias('tipo');
structPreferencias.duracionExcitacion = set_preferencias('duracion');
structPreferencias.inicioVentana = set_preferencias('inicioVentana');
structPreferencias.finVentana = set_preferencias('finVentana');
end