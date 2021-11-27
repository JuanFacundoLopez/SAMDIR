%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  samdir_gui_directividadCallbak.m                                                 *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%% Mide las IR y grafica los diagramas de Directividad

function samdir_gui_directividadCallbak(GUI)
global theta
global rho
global limsmax
global limsmin
global octava_ent 
global octava_ter
    octava_ent = {'31.5Hz','63Hz','125Hz','250Hz','500Hz','1kHz','2kHz','4kHz','8kHz','16kHz'};
    octava_ter = {'25Hz','31.5Hz','40Hz','50Hz','63Hz','80Hz','100Hz','125Hz','160Hz','200Hz',...
                     '250Hz','315Hz','400Hz','500Hz','630Hz','800Hz','1kHz','1.25kHz','1.6kHz','2kHz',... 
                     '2.5kHz','3.15kHz','4kHz','5kHz','6.3kHz','8kHz','10kHz','12.5kHz','16kHz','20kHz'};
    
    samdir_gui_guardarAjustes(GUI.ventanaAjuste);
    anguloInicial = set_preferencias('medicionInicial');
    anguloFinal   = set_preferencias('medicionFinal');
    resolucion    = 90;%set_preferencias('resolucionDirectividad');
    resolucionFiltro = set_preferencias('resolucionFiltro');
    excitacion = getappdata(0,'excitacion');
  
%     [irs,pot,pot_db, frec_nominal] = samdir_directividad(excitacion,anguloInicial,anguloFinal,resolucion,GUI.jLogPanel);
%     [theta, rho, frec] = samdir_plot_directividad(pot_db,frec_nominal);
%     setappdata(0, 'rho', rho);
%     setappdata(0, 'theta', theta);
    
    jTabGroup = getappdata(handle(GUI.hTabGroup),'JTabbedPane');
    jTabGroup.setEnabledAt(3,true);
    set(GUI.hTabGroup, 'SelectedTab', GUI.tab(4));
    
    panel = crearPanel_4(GUI.tab(4), GUI);
    drawnow;
    GUI.axBajas4 = panel.axBajas4;
    
    GUI.resFrecuenciaCombo_1 = panel.resFrecuenciaCombo_1;
    GUI.resFrecuenciaCombo_2 = panel.resFrecuenciaCombo_2;
    GUI.resFrecuenciaCombo_3 = panel.resFrecuenciaCombo_3;
    switch resolucionFiltro
        case '1/1 Octava'
            set(GUI.resFrecuenciaCombo_1, 'String', octava_ent);
            set(GUI.resFrecuenciaCombo_2, 'String', octava_ent);
            set(GUI.resFrecuenciaCombo_3, 'String', octava_ent);
        case '1/3 Octava'
            set(GUI.resFrecuenciaCombo_1, 'String', octava_ter);
            set(GUI.resFrecuenciaCombo_2, 'String', octava_ter);
            set(GUI.resFrecuenciaCombo_3, 'String', octava_ter);
    end
    limsmax = 0;
    limsmin = 0;
%     for i=1:frec
%         lims = findscale(rho(:,i), 10);
%         if lims(2) > limsmax
%             limsmax = lims(2);
%         end
%         if lims(3) < limsmin
%             limsmin = lims(3);
%         end
%     end
%     params = [limsmax limsmin 10];
%     setappdata(0, 'params', params);
%   graficarDiagrama(1, 4, GUI.axBajas4, theta, rho, params, octava_ent, 1);

   setappdata(0, 'VentanaDirectividad', 1);
   drawnow;
end

function GUI = crearPanel_4(panel, GUI)
global octava_ter

        GUI.primerPanel = uipanel(panel, 'units','norm', 'pos',[0.72,0.03,0.27,0.93], 'Background',GUI.ColorFondo*.5,...
                                'BorderType', 'etchedout', 'BorderWidth', 2);
                
        %% Panel de Preferencias
        personalizadoPanel = uipanel(GUI.primerPanel, 'units','norm', 'pos',[0.05,0.66,0.88,0.32], 'title','Visualización Personalizada', 'Background',GUI.ColorFondo*.5,...
            'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
        
        %Check Frecuencia 1
        GUI.checkFrec_1 = uicontrol(personalizadoPanel,'Style','checkbox','Value',0,'String','Frecuencia ', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.05 0.8 .6 0.12],'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');%,'callback','checkbox1_Callback'); %'tag','h_1',
        %Combo Frecuencia 1
        GUI.resFrecuenciaCombo_1 = uicontrol(personalizadoPanel,'Style', 'popup','String', octava_ter,...
            'units','norm', 'Position', [0.5,0.85,0.36,0.08], 'Background','w');%,...
        uicontrol(personalizadoPanel,'Style','text', 'units','norm','Position',[0.88,0.75,0.11,0.15],...
         'String','[Hz]', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
             %Check Frecuencia 2
        GUI.checkFrec_2 = uicontrol(personalizadoPanel,'Style','checkbox','Value',0,'String','Frecuencia ', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.05 0.56 .6 0.12],'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');%,'callback','checkbox1_Callback'); %'tag','h_1',
        %Combo Frecuencia 2
        GUI.resFrecuenciaCombo_2 = uicontrol(personalizadoPanel,'Style', 'popup','String', octava_ter,...
            'units','norm', 'Position', [0.5,0.63,0.36,0.08], 'Background','w');%,...
        uicontrol(personalizadoPanel,'Style','text', 'units','norm','Position',[0.88,0.52,0.11,0.15],...
         'String','[Hz]', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
        %Check Frecuencia 3
        GUI.checkFrec_3 = uicontrol(personalizadoPanel,'Style','checkbox','Value',0,'String','Frecuencia ', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.05 0.32 .6 0.12],'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');%,'callback','checkbox1_Callback'); %'tag','h_1',
        %Combo Frecuencia 2
        GUI.resFrecuenciaCombo_3 = uicontrol(personalizadoPanel,'Style', 'popup','String', octava_ter,...
            'units','norm', 'Position', [0.5,0.39,0.36,0.08], 'Background','w');%,...
        uicontrol(personalizadoPanel,'Style','text', 'units','norm','Position',[0.88,0.28,0.11,0.15],...
         'String','[Hz]', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
     
        GUI.verDirectividadButton = javax.swing.JButton(' Ver ');
        personalizarBoton(GUI.verDirectividadButton);
        placeJavaComponent(GUI.verDirectividadButton, [0.45,0.06,0.28,0.15], personalizadoPanel);
        set(GUI.verDirectividadButton, 'MouseClickedCallback', {@samdir_gui_verDirectividadPersonalizadaCallback, GUI});
        
        %% Panel de Medición
        
        interpolacionPanel = uipanel(GUI.primerPanel, 'units','norm', 'pos',[0.05,0.36,0.88,0.29], 'title','Interpolación', 'Background',GUI.ColorFondo*.5,...
                'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
             %Check Frecuencia 1
        GUI.interpolarCheck = uicontrol(interpolacionPanel,'Style','checkbox','Value',0,'String','Interpolar ', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.08 0.82 .6 0.12],'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');%,'callback','che  ckbox1_Callback'); %'tag
        % Label Tipo 
        uicontrol(interpolacionPanel,'Style','text','Value',0,'String','Tipo ', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.01 0.42 .3 0.26], 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');
         %Combo Tipo de interpolacion
        GUI.tipoInterpCombo = uicontrol(interpolacionPanel,'Style', 'popup','String', {'Segmentaria Lineal', 'Segmentaria Cúbica', ' Hermite cúbica'},...
            'units','norm', 'Position', [0.35,0.72,0.56,0.03], 'Background','w', 'Enable', 'off');%,...
        % Label Resolucion 
        uicontrol(interpolacionPanel,'Style','text','Value',0,'String','Resolución ', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.08 0.14 .35 0.28], 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');
         %Combo resolucion de interpolacion
        GUI.resInterpCombo = uicontrol(interpolacionPanel,'Style', 'popup','String', {'5', '2', '1'},...
            'units','norm', 'Position', [0.66,0.44,0.25,0.025], 'Background','w', 'Enable', 'off');%,...
        % Label ° 
        uicontrol(interpolacionPanel,'Style','text','Value',0,'String','°', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.92 0.22 .06 0.28],'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');
        set(GUI.interpolarCheck, 'callback', {@samdir_gui_interpolacionCallback, GUI});
        
        GUI.aplicarInterpolacionButton = javax.swing.JButton(' Aplicar ');
        personalizarBoton(GUI.aplicarInterpolacionButton);
        placeJavaComponent(GUI.aplicarInterpolacionButton, [0.45,0.01,0.28,0.18], interpolacionPanel);
       % set(GUI.verDirectividadButton, 'MouseClickedCallback', {@samdir_gui_verDirectividadPersonalizadaCallback, GUI});
        %% Panel de Medición
        
        parametrosPanel = uipanel(GUI.primerPanel, 'units','norm', 'pos',[0.05,0.02,0.88,0.32], 'title','Parámetros', 'Background',GUI.ColorFondo*.5,...
                'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);

        
        %% Genera el axes para el grafico
        GUI.axTopPanel_4 = uipanel(panel, 'units','norm', 'pos',[0.01,0.03,0.7,0.93], 'BorderType', 'beveledout',...
            'BorderWidth', 2, 'Background','w');
         
        GUI.axBajas4    = axes('Parent',GUI.axTopPanel_4, 'pos',[0.08,0.08,0.9,0.85], 'Color','w');       
       
       % samdir_gui_confAxTop(GUI.axTop4);

       %% Panel de Botones
       axBotonesPanel = uipanel(panel, 'units','norm', 'pos',[0.6,0.89,0.11,0.072], 'BorderType', 'beveledout',...
           'BorderWidth', 2, 'Background','k');
       
       %Label ventanas/Total
       GUI.nVentana = uicontrol(axBotonesPanel,'Style','text', 'units','norm','Position',[0.05,0.14,0.3,0.7],...
        'String','  1/3  ', 'Background','w', 'ForegroundColor', 'k');
       % Botones siguiente/anterior
       GUI.iconSiguiente  = imread('siguienteIcon._24.jpg');
       GUI.iconAnterior   = imread('anteriorIcon_24.jpg');
       GUI.siguienteBoton = crearBotones(axBotonesPanel, GUI.iconSiguiente, [66 2 27 27], 'siguiente');
       GUI.anteriorBoton  = crearBotones(axBotonesPanel, GUI.iconAnterior,  [40 2 27 27], 'anterior');
       set(GUI.siguienteBoton, 'Callback', {@cambioCallback, GUI, 'siguiente'});
       set(GUI.anteriorBoton,  'Callback', {@cambioCallback, GUI, 'anterior'});
       set(GUI.anteriorBoton, 'Enable', 'off');
       
       %%
       crearVisor(GUI.axTopPanel_4, [0.92 0.08 .043 .06], {@samdir_gui_VerDirectividadCallback}, GUI.iconVer)
       %%
       
end
function boton = crearBotones(parent, icon, position, tooltipstring)
    lineColor = java.awt.Color(0,0,0); 
    thickness = 1; 
    roundedCorners = false;
    newBorder = javax.swing.border.LineBorder(lineColor,thickness,roundedCorners);
    backgroundColor=java.awt.Color(0.141,0.518,1);
    boton = uicontrol('Style','pushbutton', 'CData', icon,'TooltipString', tooltipstring, ...
            'pos',position,'parent',parent,'HandleVisibility','callback');
    jButton = findjobj(boton);
    jButton.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
   
    for i=1:1:length(jButton)
        set(jButton(i), 'Background', backgroundColor, 'Border', newBorder);
    end
end
function lims = findscale(rho, rticks)
	clicks = [.001 .002 .005 .01 .02 .05 .1 ...
              .2 .5 1 2 5 10 20 50 100 200 500 1000];
	lenclicks = length(clicks);
	rhi = max(rho);
	rlo = min(rho);
	rrng = rhi - rlo;
	rawclick = rrng/rticks;
	n = 1;
	while clicks(n) < rawclick
        n = n + 1;
        if n > lenclicks
            close;
            error('Cannot autoscale; unrealistic decibel range.');
        end
	end
	click = clicks(n);
	
	m = floor(rhi/click);
	rmax = click * m;
	if rhi - rmax ~= 0
        rmax = rmax + click;
	end	
	rmin = rmax - click * rticks;
	
	% Check that minimum rho value is at least one tick
	% above rmin. If not, increase click value and
	% rescale.
    if rlo < rmin + click
        if n < lenclicks
            click = clicks(n+1);
        else
            error('Cannot autoscale; unrealistic decibel range.');
        end
        
        m = floor(rhi/click);
        rmax = click * m;
        if rhi - rmax ~= 0
            rmax = rmax + click;
        end
        rmin = rmax - click * rticks;
    end
    lims = [click rmax rmin];
end
function graficarDiagrama(inicio, fin, axes, theta, rho, parametrs, leyenda, ventana)
    hold off
    vectorColor = ['c', 'r', 'b', 'g', 'c', 'r', 'b', 'c', 'r', 'b'];
    
    nLeyenda = 0;
    for i=inicio:fin,
         nLeyenda = nLeyenda + 1;
         dirplot(theta',rho(:,i), vectorColor(i), parametrs, axes);
         hold(axes,'on')
         
         %legend([int2str(frec),'Hz'],-1);  %Incorporarlo para todas las
         %Frec
    end
    switch ventana
        case 1
            legend(leyenda{1},leyenda{2},leyenda{3}, leyenda{4}, -1);
            titulo = 'Diagrama de Directividad - Frecuencias Bajas';
        case 2
            legend(leyenda{5},leyenda{6},leyenda{7}, -1);
            titulo = 'Diagrama de Directividad - Frecuencias Medias';
        case 3
            legend(leyenda{8},leyenda{9},leyenda{10}, -1);%'Position',[0.39,0.45,0.25,0.1]
            titulo = 'Diagrama de Directividad - Frecuencias Altas';
    end
    title(titulo);
   
end
function cambioCallback(h,e, GUI, action)
    ventana = getappdata(0,'VentanaDirectividad');
global theta
global rho
global limsmax
global limsmin
global octava_ent

    switch action
        case 'siguiente'
            ventana = ventana + 1;
        case 'anterior'
            ventana = ventana - 1;
    end
    
    if(ventana == 1)
        set(GUI.anteriorBoton, 'Enable', 'off');
        set(GUI.siguienteBoton, 'Enable', 'on');
        set (GUI.nVentana, 'String','  1/3  ');
        graficarDiagrama(1, 4, GUI.axBajas4, theta, rho, [limsmax limsmin 10], octava_ent, ventana);
        drawnow;
      
    elseif (ventana == 2)
        set(GUI.anteriorBoton, 'Enable', 'on');
        set(GUI.siguienteBoton, 'Enable', 'on');
        set (GUI.nVentana, 'String','  2/3  ');
        graficarDiagrama(5, 7, GUI.axBajas4, theta, rho, [limsmax limsmin 10], octava_ent, ventana);
        drawnow;
        
        

    elseif (ventana == 3)
        set(GUI.anteriorBoton, 'Enable', 'on');
        set(GUI.siguienteBoton, 'Enable', 'off');
        set (GUI.nVentana, 'String','  3/3  ')
        graficarDiagrama(8, 10, GUI.axBajas4, theta, rho, [limsmax limsmin 10], octava_ent, ventana);
        drawnow;

    end
    
    drawnow;
    setappdata(0,'VentanaDirectividad', ventana);
   
end

% Coloca un compoenente de Java dentro del panel en una posición especifica normalizada
function placeJavaComponent ( jcomponent, position, parent )
    jcomponent = javaObjectEDT( jcomponent );  % ensure component is auto-delegated to EDT
    jcomponent.setOpaque(false);  % useful to demonstrate L&F backgrounds
    [jc,hContainer] = javacomponent( jcomponent, [], parent ); %#ok<ASGLU>
    set(hContainer, 'Units','Normalized', 'Position',position);
end  % placeJavaComponen
function personalizarBoton(jcomponent)
        jBorder = javax.swing.BorderFactory.createRaisedBevelBorder; 
        %jcomponent.setForeground(java.awt.Color.blue);
        jcomponent.setBackground(java.awt.Color.gray);
        jcomponent.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        jcomponent.setContentAreaFilled(true);
        jcomponent.setBorder(jBorder);
        jcomponent.setOpaque(true);
end

function crearVisor(parent, posicion, callback, icono)
    lineColor = java.awt.Color(0.3,0.3,1); 
    thickness = 1; 
    roundedCorners = false;
    newBorder = javax.swing.border.LineBorder(lineColor,thickness,roundedCorners);
    backgroundColor=java.awt.Color(0.3,0.3,1);
    boton2 = uicontrol('Style','pushbutton', 'CData', icono,'TooltipString', 'ver','units','norm', ...
            'pos',posicion,'parent',parent,'HandleVisibility','callback');
    set(boton2,'Callback', callback);
    jButton2 = findjobj(boton2);
    jButton2.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
   
    for i=1:1:length(jButton2)
        set(jButton2(i), 'Background', backgroundColor, 'Border', newBorder);
    end
end