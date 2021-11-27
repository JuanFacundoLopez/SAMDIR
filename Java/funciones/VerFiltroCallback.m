function VerFiltroCallback(h,e, ventanaAjuste, GUI)
   

 hashMap = ventanaAjuste.ReadObject();
 data = Hash2Struct(hashMap);
 set_preferencias(data);

 fs      = set_preferencias('samplingRate');
 fft_d   = set_preferencias('nBits');
 orden_filtro = set_preferencias('ordenFiltro');
 bandasOctava = set_preferencias('resolucionFiltro');
 
 switch (bandasOctava)
    case {'1/1 Octava'}                     
        bandas_octava = 1;            
    case {'1/3 Octava'}              
        bandas_octava = 3; 
 end
% Generación de un impulso, FT constante en todo el ancho de banda

a = samdir_generate('impulse',1,fs,fft_d);
samdir_logMensajes(GUI.jLogPanel,'Obteniendo filtros ...');

% Generación de los filtros
[filtros, frec_nominal] = samdir_banco_filtros(bandas_octava,orden_filtro);

% Caracterización
b = samdirAudio();
b.samplingRate = fs;

for i = 1:length(frec_nominal)
    b(i).timeData = filter(filtros(i),a.timeData);
   % b(i).comment = ['Filtro pasa banda - Frec. central' frec_nominal(i) 'Hz'];
   % b(i).comment = [strcat['Filtro pasa banda - Frec. central', frec_nominal(i),' Hz']];
end

% Muestra todos los filtros en la misma gráfica
samdir_plot_freq_mult (b, 'Filtros seleccionados');

% Si se quiere graficar alguno individualmente, ya tiene como comentario su
% frecuencia central ----> b(1).plot_freq
% Si se necesita esta informacion como vector se llama a "frec_nominal"

end