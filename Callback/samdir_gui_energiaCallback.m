function samdir_gui_energiaCallback(h,e,GUI)
    samdir_logMensajes(GUI.jLogPanel, 'Obteniendo Gr�fico de Energ�a ...');
    GUI.handles.controller.energiaBoton();
end