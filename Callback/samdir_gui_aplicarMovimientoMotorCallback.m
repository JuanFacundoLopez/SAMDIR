function samdir_gui_aplicarMovimientoMotorCallback(h,e,GUI)
    
    angulo = get(GUI.anguloText, 'String');
    samdir_logMensajes(GUI.jLogPanel, strcat('Moviendo hasta.. ', angulo));
    GUI.handles.controller.movimientoMotor(str2num(angulo));
end