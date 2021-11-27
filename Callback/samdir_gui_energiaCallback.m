function samdir_gui_energiaCallback(h,e,GUI)
    samdir_logMensajes(GUI.jLogPanel, 'Obteniendo Gráfico de Energía ...');
    GUI.handles.controller.energiaBoton();
end