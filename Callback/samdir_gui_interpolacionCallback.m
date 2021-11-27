function samdir_gui_interpolacionCallback(h,e,GUI)

    
    if (get(GUI.interpolarCheck,'Value') == get(GUI.interpolarCheck,'Max'))
        set(GUI.tipoInterpCombo, 'Enable', 'on');
        set(GUI.resInterpCombo, 'Enable', 'on');
        set(GUI.aplicarInterpolacionButton, 'Enable', 1);
        GUI.handles.controller.interpolacionDirectividad = true;
        if(GUI.handles.controller.aplicoInterpolacion)
            samdir_gui_aplicarInterpolacionCallback(h,e, GUI)
        end
    else
        set(GUI.tipoInterpCombo,'Enable', 'off');
        set(GUI.resInterpCombo, 'Enable', 'off');
        set(GUI.aplicarInterpolacionButton, 'Enable', 0);
        GUI.handles.controller.interpolacionDirectividad = false;
        if(GUI.handles.controller.aplicoInterpolacion)
            GUI.handles.controller.resetDirectividad();
            GUI.handles.controller.graficarDirectividad(1,4);
        end
    end
    
end