function SalirCallback(src, evt, GUI)

%%% Get action command string
    GUI.handles.controller.guardarConfiguracion(GUI.ventanaConfiguracion);
    GUI.ventanaAjuste.botonAceptar();
    GUI.handles.controller.guardarConfiguracion(GUI.ventanaAjuste);
    GUI.handles.controller.mostrarPreferencias();
    GUI.handles.controller.crearExcitacion();
    GUI.ventanaConfiguracion.setVisible(0);
end