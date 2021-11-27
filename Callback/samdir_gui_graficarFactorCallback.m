function samdir_gui_graficarFactorCallback(h,e,GUI)
     index_selected = get(GUI.comboFrecuencias,'Value');
     GUI.handles.controller.graficarFactorDirectividad(index_selected);
end