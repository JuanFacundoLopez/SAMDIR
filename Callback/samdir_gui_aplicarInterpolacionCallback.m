function samdir_gui_aplicarInterpolacionCallback(h,e, GUI)

        index_selected = get(GUI.tipoInterpCombo,'Value');
        maps = get(GUI.tipoInterpCombo,'String');
        tipoInterpolacion = maps{index_selected};
        switch tipoInterpolacion
            case 'Segmentaria Lineal'
                tipoInterpolacion = 'linear';
            case 'Segmentaria Cúbica'
                tipoInterpolacion = 'spline';
            case ' Hermite cúbica'
                tipoInterpolacion = 'pchip';
            otherwise
                tipoInterpolacion = 'linear';
        end
        index_selected = get(GUI.resInterpCombo,'Value');
        if(index_selected == 3)
            index_selected = 5;
        end
            
        samdir_logMensajes(GUI.jLogPanel, strcat('Aplicar interpolacion',' ',tipoInterpolacion,' ','con resolucion',' ' ,num2str(index_selected)));
        GUI.handles.controller.aplicarInterpolacion(tipoInterpolacion, index_selected);
        GUI.handles.controller.aplicoInterpolacion = true;
        GUI.handles.controller.resetDirectividad();
        GUI.handles.controller.graficarDirectividad(1,4);
end