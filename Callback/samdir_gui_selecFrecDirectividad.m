function samdir_gui_selecFrecDirectividad(h,e,GUI)
    index_selected = get(GUI.comboFrecuencias,'Value');
    GUI.handles.controller.mostrarParametrosDirectividad(index_selected);
end