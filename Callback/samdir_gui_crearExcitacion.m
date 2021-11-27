function samdir_gui_crearExcitacion(GUI)

samdir_logMensajes(GUI.jLogPanel,'Obteniendo señal de excitación');
%Creo que tengo que ponerlo dentro de un try/catch porque si 
%ocurrio en el paso anterior un error esto no se deberia ejecutar.

%% Inicializacion 
structPreferencias.tipoVentana = set_preferencias('tipoVentana');
structPreferencias.usuario = set_preferencias('usuario');
structPreferencias.rangoFrecuencia = [set_preferencias('freqInicial') set_preferencias('freqFinal')];
structPreferencias.samplingRate = set_preferencias('samplingRate');
structPreferencias.tipoExcitacion = set_preferencias('tipo');
structPreferencias.duracionExcitacion = set_preferencias('duracion');
structPreferencias.inicioVentana = set_preferencias('inicioVentana');
structPreferencias.finVentana = set_preferencias('finVentana');

fftDegree = samdir_calculo_fftDegree(structPreferencias.samplingRate, structPreferencias.duracionExcitacion);
oct         = 1;
nivel       = 0;
amplitud    =  samdir_nivel(nivel);

%% Generación de la señal
switch(structPreferencias.tipoExcitacion)
    case {'Barrido Senoidal Lineal', 'Barrido Senoidal Logarítmico'}
         switch (structPreferencias.tipoExcitacion)
             case {'Barrido Senoidal Lineal'}
                    tipoExcitacion = 'linsweep';
             case {'Barrido Senoidal Logarítmico'}
                    tipoExcitacion = 'expsweep';
         end
         
         a = samdir_generate(tipoExcitacion,structPreferencias.rangoFrecuencia, structPreferencias.samplingRate,fftDegree);
         excitacion = samdir_ventaneo(structPreferencias.tipoVentana, structPreferencias.inicioVentana,structPreferencias.finVentana,a);
    
         plot(GUI.axTop, excitacion.timeVector, excitacion.timeData,'c');
         
    case {'Tono Senoidal', 'Tono Cosenoidal'}
         switch (structPreferencias.tipoExcitacion)
             case {'Tono Senoidal'}
                    tipoExcitacion = 'sine';
             case {'Tono Cosenoidal'}
                    tipoExcitacion = 'cosine';
         end
         
        if (oct==1)
            excitacion(10)    = samdirAudio;
            for i=1:10,
                excitacion(i)  = samdir_generate(tipoExcitacion,amplitud,frec_oct(i),structPreferencias.samplingRate,fftDegree);
                plot(GUI.axTop, excitacion(i).timeVector, excitacion(i).timeData,'c');
                hold(GUI.axTop,'on')
            end
        else
            excitacion(31)    = samdirAudio;
            for i=1:31,
                excitacion(i)  = samdir_generate(tipoExcitacion,amplitud,frec_ter(i),structPreferencias.samplingRate,fftDegree);
                plot(GUI.axTop, excitacion(i).timeVector, excitacion(i).timeData,'c');
                hold(GUI.axTop,'on')
            end
        end

    otherwise
         samdir_logMensajes(GUI.jLogPanel,'Error al Cargar la Señal de Excitacion');
    return;
end
    samdir_gui_confAxTop(GUI.axTop);
    samdir_logMensajes(GUI.jLogPanel,'Señal de excitacion obtenida');
    a = getappdata(0, 'playExcitacion');
 %  set(a,'Enable', 'on');
   setappdata(0,'playExcitacion', a);
   setappdata(0,'excitacion', excitacion);
   set(GUI.excitacionVerMenu, 'Enable', 'on');
   set(GUI.excitacionEspecVerMenu, 'Enable', 'on');

end