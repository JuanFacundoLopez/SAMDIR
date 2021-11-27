function samdir_gui_respuestaEnFrecuenciaCallback(h,e,GUI)
    samdir_logMensajes(GUI.jLogPanel, 'Obteniendo Respuesta en Frecuencia ...');
    GUI.handles.controller.respuestaFrecuenciaBoton();
end