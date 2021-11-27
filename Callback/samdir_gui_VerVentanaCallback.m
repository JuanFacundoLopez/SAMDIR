function samdir_gui_VerVentanaCallback(h,e, GUI)

    samdir_logMensajes(GUI.jLogPanel, 'IR + Ventana');
    izq_rec = str2double(get(GUI.izq_rec,'String')); %0.02
    der_rec = str2double(get(GUI.der_rec,'String')); %0.1
    val = get(GUI.tipoVentana1,'Value');
    maps = get(GUI.tipoVentana1,'String');
    tipo_1 = maps{val};
    izq = str2double(get(GUI.ventanaIzq,'String')); %0.1
    val = get(GUI.tipoVentana2,'Value');
    maps = get(GUI.tipoVentana2,'String');
    tipo_2 = maps{val};
    der = str2double(get(GUI.ventanaDer,'String')); %0.1
    GUI.handles.controller.ventanaIRVer(izq_rec,der_rec,tipo_1,izq,tipo_2,der);

end