function samdir_gui_medicionAnguloPersonalizadoCallback(h,e,GUI)

    if (get(GUI.checkMedicion,'Value') == get(GUI.checkMedicion,'Max'))
        set(GUI.anguloText, 'Enable', 'on');
        set(GUI.aplicarAngPersonalizadoMotorButton, 'Enable', 1);
       
    else
        set(GUI.anguloText, 'Enable', 'off');
        set(GUI.aplicarAngPersonalizadoMotorButton, 'Enable', 0);
    end
    

end