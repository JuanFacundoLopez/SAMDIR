function samdir_gui_guardarIRCallback(h,e,GUI)

    samdir_logMensajes(GUI.jLogPanel, 'Guardando IR.wav');
    %Recibir el valor indicando que se pudo guardar bien
    GUI.handles.controller.guardarIR();
    
end