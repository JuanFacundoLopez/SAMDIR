function GUI = crearPanel_2(panel, GUI)
    GUI.panel_IRvent = uipanel(panel, 'units','norm', 'pos',[0.75,0.03,0.24,0.93], 'Background', ...
        GUI.ColorFondo*.5,'BorderType', 'etchedout', 'BorderWidth', 2);
    ventanaPanel = uipanel(GUI.panel_IRvent, 'units','norm', 'pos',[0.04,0.25,0.92,0.74], 'title','Ventana', 'Background',GUI.ColorFondo*.5,...
            'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
    
    %% Generación de los controles 
    tipoVentanas = {'Hann', 'Hamming', 'Flat Top', 'Blackman', 'Bartlett', 'Bartlett-Hann', 'Blackman-Harris', 'Bohman', ...
        'Chebyshev', 'Gaussian', 'Kaiser', 'Nuttall', 'Parzen', 'Rectangular', 'Taylor', 'Tukey', 'Triangular'};
     
    %% VENTANA RECTANGULAR 
    ventanaRectangularPanel = uipanel(ventanaPanel, 'units','norm', 'pos',[0.04,0.72,0.92,0.25], 'title','Ventana Rectangular', 'Background',GUI.ColorFondo*.5,...
            'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
    %Label izq_rec
    uicontrol(ventanaRectangularPanel,'Style','text', 'units','norm','Position',[0.01,0.64,0.32,0.22],...
        'String','Izquierda', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    %Text izq_rec
    GUI.izq_rec = uicontrol(ventanaRectangularPanel,'Style', 'edit','String', '0.02', 'Background','w',...
           'units','norm', 'Position', [0.42,0.63,0.34,0.26]);%,...
    %Label seg.
     uicontrol(ventanaRectangularPanel,'Style','text', 'units','norm','Position',[0.78,0.64,0.2,0.22],...
        'String','seg', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    %Label der_rec
    uicontrol(ventanaRectangularPanel,'Style','text', 'units','norm','Position',[0.01,0.2,0.3,0.2],...
        'String','Derecha', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    %Text der_rec
    GUI.der_rec = uicontrol(ventanaRectangularPanel,'Style', 'edit','String', '0.1', 'Background','w',...
           'units','norm', 'Position', [0.42,0.18,0.34,0.26]);%,...
    %Label seg.   
    uicontrol(ventanaRectangularPanel,'Style','text', 'units','norm','Position',[0.78,0.2,0.2,0.22],...
        'String','seg', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');

    %% VENTANA PERSONALIZADA 
    ventanaPersonalizadaPanel = uipanel(ventanaPanel, 'units','norm', 'pos',[0.04,0.15,0.92,0.55], 'title','Ventana Personalizada', 'Background',GUI.ColorFondo*.5,...
            'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
        
    %Label Ventana Izq.
    uicontrol(ventanaPersonalizadaPanel,'Style','text', 'units','norm','Position',[0.01,0.64,0.4,0.24],...
        'String','Ventana Izquierda', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    %Text Ventana Izq.
    GUI.ventanaIzq = uicontrol(ventanaPersonalizadaPanel,'Style', 'edit','String', '0.1', 'Background','w',...
           'units','norm', 'Position', [0.46,0.77,0.34,0.12]);%,...
    %Label seg.
    uicontrol(ventanaPersonalizadaPanel,'Style','text', 'units','norm','Position',[0.8,0.7,0.15,0.15],...
        'String','ms', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    %Label tipo ventana 1
    uicontrol(ventanaPersonalizadaPanel,'Style','text', 'units','norm','Position',[0.03,0.47,0.2,0.15],...
        'String','Tipo', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    %Popup Ventana 1
    GUI.tipoVentana1 = uicontrol(ventanaPersonalizadaPanel,'Style', 'popup','String', tipoVentanas,...
           'units','norm', 'Position', [0.46,0.58,0.3,0.08], 'Background','w');%,...
         %  'Callback', @setmap); 
    
    %Label Ventana Der.
    uicontrol(ventanaPersonalizadaPanel,'Style','text', 'units','norm','Position',[0.01,0.16,0.4,0.24],...
        'String','Ventana Derecha', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    %Text Ventana Der.
    GUI.ventanaDer = uicontrol(ventanaPersonalizadaPanel,'Style', 'edit','String', '0.1', 'Background','w',...
           'units','norm', 'Position', [0.46,0.3,0.34,0.12]);%,...
    %Label seg.
    uicontrol(ventanaPersonalizadaPanel,'Style','text', 'units','norm','Position',[0.8,0.24,0.15,0.15],...
        'String','ms', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    %Label tipo
    uicontrol(ventanaPersonalizadaPanel,'Style','text', 'units','norm','Position',[0.03,0.03,0.2,0.15],...
        'String','Tipo', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    GUI.tipoVentana2 = uicontrol(ventanaPersonalizadaPanel,'Style', 'popup','String', tipoVentanas,...
           'units','norm', 'Position', [0.46,0.12,0.3,0.08], 'Background','w');%,...
         %  'Callback', @setmap); 
    %% Botones
    GUI.verButton      = javax.swing.JButton('Ver');
    GUI.aplicarButton      = javax.swing.JButton('Aplicar');
           
    personalizarBoton(GUI.verButton);
    personalizarBoton(GUI.aplicarButton);
        
    placeJavaComponent(GUI.verButton, [0.1,0.01,0.33,0.07], ventanaPanel);
    placeJavaComponent(GUI.aplicarButton, [0.6,0.01,0.33,0.07], ventanaPanel);
   
    %% Genera el axes para el grafico
    GUI.axTopPanel_2 = uipanel(panel, 'units','norm', 'pos',[0.01,0.03,0.72,0.93], 'BorderType', 'beveledout',...
            'BorderWidth', 2, 'Background',GUI.ColorFondo*.5);
    GUI.axTop2    = axes('Parent',GUI.axTopPanel_2,  'XColor',[1,1,1], 'YColor',[1,1,1], 'pos',[0.08,0.08,0.9,0.85], 'Color',[.3,.3,1], ...
        'Tag','axTop2');
    samdir_gui_confAxTop(GUI.axTop2);
      
    set(GUI.verButton,     'MouseClickedCallback',    {@samdir_gui_VerVentanaCallback,     GUI});
    set(GUI.aplicarButton, 'MouseClickedCallback',    {@samdir_gui_AplicarVentanaCallback, GUI});
    
    %% Visor 
    lineColor = java.awt.Color(0.3,0.3,1); 
    thickness = 1; 
    roundedCorners = false;
    newBorder = javax.swing.border.LineBorder(lineColor,thickness,roundedCorners);
    backgroundColor=java.awt.Color(0.3,0.3,1);
    iconVer  = imread('\imagenes\preview_icon_24x24.jpg');
    boton = uicontrol('Style','pushbutton', 'CData', iconVer,'TooltipString', 'ver','units','norm', ...
            'pos',[0.9 0.08 .043 .06],'parent',GUI.axTopPanel_2,'HandleVisibility','callback');
    set(boton,'Callback', {@samdir_gui_VerIRVentanaCallback});
    jButton = findjobj(boton);
    jButton.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
   
    for i=1:1:length(jButton)
        set(jButton(i), 'Background', backgroundColor, 'Border', newBorder);
    end

end