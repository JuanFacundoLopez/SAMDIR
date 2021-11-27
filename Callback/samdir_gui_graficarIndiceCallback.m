function samdir_gui_graficarIndiceCallback(h,e,GUI)
    index_selected = get(GUI.comboFrecuencias,'Value');
    GUI.handles.controller.graficarIndiceDirectividad(index_selected);
end