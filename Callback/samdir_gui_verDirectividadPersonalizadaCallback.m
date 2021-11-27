function samdir_gui_verDirectividadPersonalizadaCallback(h,e, GUI)
    figure;
    hold off;
    if (get(GUI.checkFrec_1,'Value') == get(GUI.checkFrec_1,'Max'))
        index_selected = get(GUI.resFrecuenciaCombo_1,'Value');
        GUI.handles.controller.graficarDirectividadPersonalizada(index_selected, 'k');
      %  dirplot(theta',rho(:,index_selected), 'b', parametrs);
        hold on;
    end
    
    if (get(GUI.checkFrec_2,'Value') == get(GUI.checkFrec_2,'Max'))
        index_selected = get(GUI.resFrecuenciaCombo_2,'Value');
         GUI.handles.controller.graficarDirectividadPersonalizada(index_selected, 'b');
        %dirplot(theta',rho(:,index_selected), 'k', parametrs);
        hold on;
    end
    
    if (get(GUI.checkFrec_3,'Value') == get(GUI.checkFrec_3,'Max'))
        index_selected = get(GUI.resFrecuenciaCombo_3,'Value');
         GUI.handles.controller.graficarDirectividadPersonalizada(index_selected, 'r');
        %dirplot(theta',rho(:,index_selected), 'r', parametrs);
        hold on;
    end
    
    
    
    
end