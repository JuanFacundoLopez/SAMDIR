function samdir_gui_ExtenderLonguitudCallback(h,e,GUI)

    index_selected = get(GUI.puntosResCombo,'Value');
    switch(index_selected)
        case 1
            grado = 15;            
        case 2
            grado = 16;
        case 3
            grado = 17;
        case 4
            grado = 18;
        case 5
            grado = 19;
        case 6
            grado = 20;
        otherwise
            grado = 16;
    end
         
    resolucion =  GUI.handles.controller.resolucionFrecuencia(grado);
    set(GUI.resolucion, 'String', num2str(resolucion));

      if (get(GUI.extenderlongitud,'Value') == get(GUI.extenderlongitud,'Max'))
        
        resol_ir_ext = GUI.handles.controller.extenderIR(grado);
        set(GUI.resolucionIR, 'String', num2str(resol_ir_ext));
      end
end