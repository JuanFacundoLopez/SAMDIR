function samdir_gui_verMenuCallback(h,e,GUI, signal, tipo)
    GUI.handles.controller.verMenuRespuestaEnFrecuencia(signal, tipo);
    switch(signal)
        case 'excitacion'
            signal = getappdata(0, 'excitacion');
        case 'grabada'
            signal = getappdata(0, 'grabada');
        case 'ir'
            ir_ext = getappdata(0,'ir_ext');
            if(~isempty(ir_ext))
                signal = ir_ext;
            else
                ir_vent = getappdata(0,'ir_vent');
                signal = ir_vent;
            end
        otherwise
            samdir_logMensajes(GUI.jLogPanel, 'Error al pasar señal', 'w');
    end
    
    if (~isempty(signal))
        if isa(signal, 'samdirAudio')
            if(strcmp(tipo, 'tiempo'))
                signal.plot;
            else
                signal.plot_freq;
            end
        end
    else
        samdir_logMensajes(GUI.jLogPanel, 'La señal que quiere ver no se encuentra', 'w');
    end
end