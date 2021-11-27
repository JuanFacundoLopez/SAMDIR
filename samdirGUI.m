
function varargout = samdirGUI(varargin)

% Display the GUI window

    %clc
    GUI = [];
    varargout{1} = initGUI(varargin{2});

    % Display the initial GUI window
function varargout =  initGUI(controlador)
        
        %Inicializa Archivos y Path necesarios
        %samdir_configuracion();
        
        % Inicializa Datos
        GUI.preferencias = [{['usuario' '@' datestr(now,'HH:MM:SS')]};...
                            {['tipo' ' ' [20 20000] ' ' '0,68' 'seg.']};...
                            {['tipoVentana' ' ' 'Hann']}; ...
                            {['Comentario: ' ' ' 'Temperatura: 27°C' ]};...
                            {['Equipo: ' ' ']};];
        GUI.ColorFondo = [0.200000 0.580000 0.810000];
        GUI.iconVer  = imread('\imagenes\preview_icon_24x24.jpg');
        samdir_preferencias_definidas();
        set_preferencias();
        setappdata(0,'creacionPanel2', 0);
        setappdata(0,'excitacion', 0);
        setappdata(0,'ir_ext', 0);
        rmappdata(0,'excitacion');
        rmappdata(0,'ir_ext');
        GUI.axTop2 = 0;
        [GUI.ventanaConfiguracion, GUI.ventanaAjuste] = samdir_preferencias();
%        samdir_gui_guardarAjustes(GUI.ventanaAjuste);
%        samdir_gui_guardarConfiguracion(GUI.ventanaConfiguracion);
       
        % Para todos los timers existentes
        try stop(timerfindall);    catch; end
        try delete(timerfindall);  catch; end
        
        % Crea una figura nueva
        GUI.hFig = findall(0, '-depth',1, 'type','figure', 'Name','Samdir');
        if isempty(GUI.hFig)
            GUI.hFig = figure('Name','Samdir', 'NumberTitle','off', 'Visible','off', 'Color','w', 'Position',[100,100,900,600], 'Toolbar','none', 'Menu', 'none');
        else
            clf(GUI.hFig);
            hc=findall(gcf); delete(hc(2:end));  % bypass javacomponent-clf bug on R2012b-R2013a
        end
        
        GUI.handles.controller = controlador;        
        drawnow; pause(0.05);
        oldWarn = warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
        javaFrame = get(handle(GUI.hFig),'JavaFrame');
        warning(oldWarn);
        folder = fileparts(mfilename('fullpath'));
        newIcon = javax.swing.ImageIcon([folder '/dollar.png']);
        javaFrame.setFigureIcon(newIcon);
        set(GUI.hFig,'Visible','on');
        drawnow; pause(0.05);
        
        % Prepara los paneles ajustables
        oldWarn = warning('off','MATLAB:hg:PossibleDeprecatedJavaSetHGProperty');
        hMainPanel = uipanel('Units','norm', 'Position',[0,0,1,1], 'BorderType','none', 'Background',GUI.ColorFondo);
        [hLeftBottomPanel,  hLeftTopPanel,  hLeftDivider]  = uisplitpane(hMainPanel,  'Orientation','Vertical','DividerLocation',0.15); %#ok<NASGU>
        [hIzqAbajoPanel,  hDerAbajoPanel,  hLeftDivider]  = uisplitpane(hLeftBottomPanel,  'Orientation','Horizontal','DividerLocation',0.80); %#ok<NASGU>
        warning(oldWarn);
    
        % Prepara el Registro de Pasos y el Logo del CINTRA
        GUI.hLogPanel = uicontrol('style','edit', 'max',5, 'Parent',hIzqAbajoPanel, 'Units','norm', 'Position',[0,0.2,1,0.8], 'Background','w');
        drawnow;
        jScroll = findjobj(GUI.hLogPanel);
        try jScroll = jScroll(1); catch; end
        try
         %   jScroll.setVerticalScrollBarPolicy(jScroll.java.VERTICAL_SCROLLBAR_AS_NEEDED);
            %jScroll.setBorder([]);
            jScroll = jScroll.getViewport;
            
        catch
            % may possibly already be the viewport
           
        end
        GUI.jLogPanel = handle(jScroll.getView,'CallbackProperties');
        GUI.jLogPanel.setEditable(false);
        set(GUI.jLogPanel,'ToolTipText','Registro de procesamiento');
     %   set(GUI.jLogPanel,'HyperlinkUpdateCallback',@linkCallbackFcn);
        samdir_logMensajes(GUI.jLogPanel, 'Initializando GUI Samdir...');
      
        GUI.image_Data = imread ('\imagenes\logo.jpg');
        
        GUI.hLogoSamdir = axes('Parent',hDerAbajoPanel,'Position',[0,0.2,1,0.85] );
        imshow(GUI.image_Data,'Parent',GUI.hLogoSamdir);
        s = warning('off', 'MATLAB:uitabgroup:OldVersion');
        crearMenu();
        
        GUI.hTabGroup = uitabgroup('v0',hLeftTopPanel,'Background',GUI.ColorFondo*.5, 'Margin',0.01); 
        jTabGroup = getappdata(handle(GUI.hTabGroup),'JTabbedPane');
        warning(s);
        GUI.tab(1) = uitab(GUI.hTabGroup, 'title','Señales');
        GUI.tab(2) = uitab(GUI.hTabGroup, 'title','IR+Ventana');
        GUI.tab(3) = uitab(GUI.hTabGroup, 'title','IR');
        GUI.tab(4) = uitab(GUI.hTabGroup, 'title','Directividad');
       % set(GUI.hTabGroup,'SelectionChangeFcn',@tab_SelectionChangeFcn);
        
        %jTabGroup.setEnabled(false); Todos
        jTabGroup.setEnabledAt(1,false);
        jTabGroup.setEnabledAt(2,false);
        jTabGroup.setEnabledAt(3,false);

        
        GUI.fontNamePrimerPanel = 'Leelawadee';%'Lucida Fax Demibold';%'Tahoma';%'AvantGarde';
        GUI.fontSizePrimerPanel = 9;
        
        drawnow;
        
        crearPanel_3(GUI.tab(3));
        crearPanel_2(GUI.tab(2));
        crearPanel_4(GUI.tab(4));
        crearPanel_1(GUI.tab(1));
        drawnow; pause(0.05);
        %% Creación de los botones para manejar la Ventana de Ajustes Panel1
       
        GUI.verFiltroButton = samdir_gui.botonVerFiltroCls.getTrigger();
        buttonVerFiltro = handle(GUI.verFiltroButton,'callbackproperties');
        set(buttonVerFiltro,'ActionPerformedCallback', ...
                {@VerFiltroCallback, GUI.ventanaAjuste, GUI });
        
        GUI.aceptarAjustesButton = samdir_gui.botonAceptarAjustesCls.getTrigger();
        buttonAceptarAjustes = handle(GUI.aceptarAjustesButton,'callbackproperties');
        set(buttonAceptarAjustes,'ActionPerformedCallback', ...
                {@AceptarAjustesCallback});
               
            
        %% Creación de los botones para manejar la Ventana de Configuración del Menú
        GUI.salirConfiguracionButton = samdir_gui.botonSalirCls.getTrigger();
        buttonPropSalir = handle(GUI.salirConfiguracionButton,'callbackproperties');
        
        set(buttonPropSalir,   'ActionPerformedCallback', {@SalirCallback,                     GUI});
       
        set(GUI.hTabGroup, 'SelectedTab', GUI.tab(1));

        if nargout
            [varargout{1}] = GUI;
        
        end
end

function crearMenu()
    % File main menu
    FileMenu = uimenu(GUI.hFig, 'Label', 'Archivo' );
    uimenu( FileMenu, 'Label', 'Importar Excitación', 'Callback', @(h,e)importarExcitacionCallback );
    uimenu( FileMenu, 'Label', 'Importar IR', 'Callback', @(h,e)importarIRCallback );
    uimenu( FileMenu, 'Label', 'Salir', 'Callback', @(h,e)SalirGUICallback );
    
    ConfiguracionMenu = uimenu(GUI.hFig, 'Label', 'Configuración');
    uimenu( ConfiguracionMenu, 'Label','Ajustes Generales','Callback',{@ConfiguracionCallback, GUI.ventanaConfiguracion}) ;
    
    VerMenu = uimenu(GUI.hFig, 'Label', 'Ver');
    respEnFrecuimenu = uimenu( VerMenu, 'Label','Respuesta en Frecuencia') ;
    GUI.excitacionVerMenu = uimenu( respEnFrecuimenu, 'Label','Señal Excitación','Enable', 'off','Callback',{@samdir_gui_verMenuCallback, GUI, 'excitacion'}) ;
    GUI.grabacionVerMenu  = uimenu( respEnFrecuimenu, 'Label','Señal Grabada',   'Enable', 'off','Callback',{@samdir_gui_verMenuCallback, GUI, 'grabada'}) ;
    GUI.irVerMenu         = uimenu( respEnFrecuimenu, 'Label','Señal IR',        'Enable', 'off','Callback',{@samdir_gui_verMenuCallback, GUI, 'ir'}) ;
    espectogramaUimenu = uimenu( VerMenu, 'Label','Espectrograma') ;
    GUI.excitacionEspecVerMenu = uimenu( espectogramaUimenu, 'Label','Señal Excitación','Enable', 'off','Callback',{@samdir_gui_verEspectMenuCallback, GUI, 'excitacion'}) ;
    GUI.grabacionEspecVerMenu  = uimenu( espectogramaUimenu, 'Label','Señal Grabada',   'Enable', 'off','Callback',{@samdir_gui_verEspectMenuCallback, GUI, 'grabada'}) ;
    GUI.irVerEspecMenu         = uimenu( espectogramaUimenu, 'Label','Señal IR',        'Enable', 'off','Callback',{@samdir_gui_verEspectMenuCallback, GUI, 'ir'}) ;
    GUI.irVerTonosPurosMenu    = uimenu( espectogramaUimenu, 'Label','Tonos Puros',        'Enable', 'off','Callback',{@samdir_gui_verEspectMenuCallback, GUI, 'tonosPuros'}) ;
    
    GUI.graficoBarrasMenu = uimenu(VerMenu, 'Label','Gráfico de Barras','Enable', 'off','Callback',{@graficoBarrasCallback}) ;  
    
    AyudaMenu = uimenu(GUI.hFig, 'Label', 'Ayuda' );
    uimenu( AyudaMenu, 'Label','Sobre el tema'); %'Callback',@(h,e)updateInterface(jt_lnf{idx,2})) ;
    uimenu( AyudaMenu, 'Label','Acerca de Samdir','Callback',@(h,e)abrirVentanaAbout()) ;
end

function boton = crearBotonesAudio(parent, icon, position, tooltipstring, callback)
    lineColor = java.awt.Color(0,0,0); 
    thickness = 1; 
    roundedCorners = false;
    newBorder = javax.swing.border.LineBorder(lineColor,thickness,roundedCorners);
    backgroundColor=java.awt.Color(0.141,0.518,1);
    boton = uicontrol('Style','pushbutton', 'CData', icon,'TooltipString', tooltipstring, ...
            'pos',position,'parent',parent,'HandleVisibility','callback');
    set(boton,'Callback', callback);
    jButton = findjobj(boton);
    jButton.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
   
    for i=1:1:length(jButton)
        set(jButton(i), 'Background', backgroundColor, 'Border', newBorder);
    end
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
function AjustesCallback(h,e)
    
    GUI.ventanaAjuste.setVisible(1);
end
function ObtenerCallback(h,e)
        
        result = GUI.handles.controller.checkExcitacion();
        if(result)
            if(GUI.ftRadiobutton.isSelected == true)
                GUI.handles.controller.seleccionMedicion('ir');
                medicion = GUI.handles.controller.obtenerMedicionesIR();
                if(medicion == 1)
                    panel2 = getappdata(0,'creacionPanel2');
                    if(panel2 == 0)
                        set(GUI.verButton,'visible',1);
                        set(GUI.aplicarButton,'visible',1);
                        setappdata(0,'creacionPanel2', 1);
                    end
                    GUI.handles.controller.modificacionIRVentana
                          
                end
            else
                GUI.handles.controller.seleccionMedicion('directividad');
                GUI.handles.controller.obtenerMedicionDirectividad();
                %samdir_gui_directividadCallbak(GUI);
            end
        end

end
function AceptarAjustesCallback(h,e)
    disp('Funcion de Acpetar');
    samdir_gui_guardarAjustes(GUI.ventanaAjuste);
    GUI.ventanaAjuste.setVisible(0);
end
function abrirVentanaAbout(h,e)
    samdir_logMensajes(GUI.jLogPanel, 'Acerca de GUI Samdir...');
    
    winAbout = javax.swing.JFrame('Acerca de GUI Samdir');
    winAbout.setSize(300,400);
    winAbout.setLocationRelativeTo([]);
    winAbout.setDefaultCloseOperation(javax.swing.WindowConstants.HIDE_ON_CLOSE);
    winAbout.setVisible(1);
end
function escucharExcitacionCallback(h,e)
    GUI.handles.controller.escucharExcitacion();
end
function verExcitacionCallback(h,e)
    GUI.handles.controller.verExcitacion();
end
function escucharGrabacionCallback(h,e)
    GUI.handles.controller.escucharGrabacion();
end
function verGrabacionCallback(h,e)
    GUI.handles.controller.verGrabacion();
end
function graficoBarrasCallback(h,e)
    GUI.handles.controller.graficoBarras();
end
function stopCallback(h,e)
        samdir_logMensajes(GUI.jLogPanel, 'Método no implementado todavía', 'w');
    end
function SalirGUICallback()
        button = questdlg('Ready to quit?', ...
                'Exit Dialog','Yes','No','No');
        switch button
                    case 'Yes',
                      samdir_logMensajes(GUI.jLogPanel, 'Saliendo de Matlab');
                      %Save variables to matlab.mat
                     % save
                     %clear all
                     %close all
                     clf(GUI.hFig);
                     hc=findall(gcf); delete(hc(2:end));  % bypass javacomponent-clf bug on R2012b-R2013a
                     clear all
                     close all
                    case 'No',
                      quit cancel;
        end
end
function checkCallback(h,e)
    if(GUI.ftRadiobutton.isSelected)
       set(GUI.medirDirButton, 'enable', 0);
       set(GUI.obtenerButton,  'enable', 1);
    end
    if(GUI.dirRadiobutton.isSelected)
       set(GUI.medirDirButton,'enable', 1)
       set(GUI.obtenerButton, 'enable', 0);
    end
end
function ampliarIRVentana(h,e)
   GUI.handles.controller.ventanaIRLupa();
end
function verIRCallback(h,e)
    GUI.handles.controller.verIRExtendidaLupa();
end
function crearPanel_1(panel)
        GUI.primerPanel = uipanel(panel, 'units','norm', 'pos',[0.69,0.03,0.3,0.93], 'Background',GUI.ColorFondo*.5,'BorderType', 'etchedout', 'BorderWidth', 2);
        
        %% Panel de Preferencias
        preferenciasPanel = uipanel(GUI.primerPanel, 'units','norm', 'pos',[0.05,0.74,0.92,0.25], 'title','Preferencias', 'Background',GUI.ColorFondo*.5,...
            'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
        
        GUI.infoConfiguracion = uicontrol('style','text ', 'Parent',preferenciasPanel, 'Units','norm', ...
            'Position',[0.03,0.05,0.94,0.9], 'Background','w');
         set(GUI.infoConfiguracion, 'String',  GUI.preferencias);
                  
        %% Panel de Medición
        
        medicionPanel = uipanel(GUI.primerPanel, 'units','norm', 'pos',[0.05,0.4,0.92,0.32], 'title','Medición', 'Background',GUI.ColorFondo*.5,...
                'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);

        medicionIRPanel = uipanel(medicionPanel, 'units','norm', 'pos',[0.05,0.54,0.92,0.42], 'title','', 'Background',GUI.ColorFondo*.5);
        medicionDirPanel = uipanel(medicionPanel, 'units','norm', 'pos',[0.05,0.04,0.92,0.42], 'title','', 'Background',GUI.ColorFondo*.5);
    
        GUI.ftRadiobutton = javax.swing.JRadioButton('Respuesta Impulsiva');
        GUI.dirRadiobutton = javax.swing.JRadioButton('Directividad');
        group = javax.swing.ButtonGroup();
        group.add(GUI.ftRadiobutton);
        group.add(GUI.dirRadiobutton);

        GUI.ftRadiobutton.setSelected(true);
        color=get(medicionPanel,'BackgroundColor');
        TransparencyFlag = true;
        if ischar(color)
            %obj.hgcontrol.getBackground();
        elseif numel(color)==4 && TransparencyFlag==true
            color=int16(color);
            GUI.ftRadiobutton.setBackground(java.awt.Color(color(1), color(2), color(3), color(4)));
            GUI.dirRadiobutton.setBackground(java.awt.Color(color(1), color(2), color(3), color(4)));
            GUI.ftRadiobutton.setForeground(java.awt.Color.white);
            GUI.dirRadiobutton.setForeground(java.awt.Color.white);
            GUI.ftRadiobutton.setFont(java.awt.Font(GUI.fontNamePrimerPanel,java.awt.Font.BOLD,12));
            GUI.dirRadiobutton.setFont(java.awt.Font(GUI.fontNamePrimerPanel,java.awt.Font.BOLD,12));
        else
            color=int16(color*255);
            GUI.ftRadiobutton.setBackground(java.awt.Color(color(1), color(2), color(3)));
            GUI.dirRadiobutton.setBackground(java.awt.Color(color(1), color(2), color(3)));
            GUI.ftRadiobutton.setForeground(java.awt.Color.white);
            GUI.dirRadiobutton.setForeground(java.awt.Color.white);
            GUI.ftRadiobutton.setFont(java.awt.Font(GUI.fontNamePrimerPanel,java.awt.Font.BOLD,12));
            GUI.dirRadiobutton.setFont(java.awt.Font(GUI.fontNamePrimerPanel,java.awt.Font.BOLD,12));
        end
        
        
        placeJavaComponent(GUI.ftRadiobutton, [0.1,0.68,0.8 0.28], medicionIRPanel);
        placeJavaComponent(GUI.dirRadiobutton, [0.1,0.68,0.8 0.28], medicionDirPanel);
        
        GUI.ajustesButton      = javax.swing.JButton('Ajustes');
        GUI.obtenerButton      = javax.swing.JButton('Medir');
        GUI.medirDirButton      = javax.swing.JButton('Medir');
           
        personalizarBoton(GUI.ajustesButton);
        personalizarBoton(GUI.obtenerButton);
        personalizarBoton(GUI.medirDirButton);
        
        placeJavaComponent(GUI.ajustesButton, [0.1,0.05,0.3,0.4], medicionDirPanel);
        placeJavaComponent(GUI.medirDirButton, [0.6,0.05,0.33,0.4], medicionDirPanel);
        placeJavaComponent(GUI.obtenerButton, [0.6,0.05,0.33,0.4], medicionIRPanel);
     
       % set(GUI.ftRadiobutton, 'PropertyChangeCallback ', {@checkCallback});
       % set(GUI.dirRadiobutton, 'MouseClickedCallback', {@checkCallback});
        jFtRadioButton = handle(GUI.ftRadiobutton,'CallbackProperties');
        jDirRadioButton = handle(GUI.dirRadiobutton,'CallbackProperties');
        jAjustesButton = handle(GUI.ajustesButton,'CallbackProperties');
        jObtenerButton = handle(GUI.obtenerButton,'CallbackProperties');
        jMedirDirButton = handle(GUI.medirDirButton,'CallbackProperties');
        
        set(jFtRadioButton, 'ActionPerformedCallback',@checkCallback)
        set(jDirRadioButton,'ActionPerformedCallback',@checkCallback)
        set(jAjustesButton, 'MouseClickedCallback',   @AjustesCallback);
        set(jObtenerButton, 'MouseClickedCallback',   {@ObtenerCallback});
        set(jMedirDirButton,'MouseClickedCallback',   {@ObtenerCallback});
        
        set(GUI.obtenerButton, 'enable', 1);
        set(GUI.medirDirButton, 'enable', 0);
        
        %% Panel del Motor
        motorPanel = uipanel(GUI.primerPanel, 'units','norm', 'pos',[0.05,0.03,0.92,0.35], 'title','Unidad de Control', 'Background',GUI.ColorFondo*.5, ...
            'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
        GUI.conexionMotor = uicontrol('style','text ', 'Parent',motorPanel, 'Units','norm', 'ForegroundColor', 'r', ...
                            'FontWeigh', 'bold','String', 'desconectado','Position',[0.64,0.85,0.35,0.15], 'Background','w');
        
        GUI.resetMotorButton       = javax.swing.JButton('Reset');
        GUI.pruebaMotorButton      = javax.swing.JButton('Prueba');
        GUI.conectarMotorButton    = javax.swing.JButton('Conectar');
        GUI.desconectarMotorButton = javax.swing.JButton('Desconectar');
        GUI.verificarMotorButton   = javax.swing.JButton('<html> <p align="center"> Verificar Conexión <br> </p> </html>');
        personalizarBoton(GUI.resetMotorButton);
        personalizarBoton(GUI.pruebaMotorButton);
        personalizarBoton(GUI.conectarMotorButton);
        personalizarBoton(GUI.desconectarMotorButton);
        personalizarBoton(GUI.verificarMotorButton);
        placeJavaComponent(GUI.resetMotorButton,       [0.02,0.55,0.25,0.18], motorPanel);
        placeJavaComponent(GUI.pruebaMotorButton,      [0.3,0.55,0.32,0.18], motorPanel);
        placeJavaComponent(GUI.conectarMotorButton,    [0.02,0.8,0.25,0.18], motorPanel);
        placeJavaComponent(GUI.desconectarMotorButton, [0.3,0.8,0.32,0.18], motorPanel);
        placeJavaComponent(GUI.verificarMotorButton,   [0.64,0.55,0.32,0.26], motorPanel);
        jResetMotorButton       = handle(GUI.resetMotorButton, 'CallbackProperties');
        jPruebaMotorButton      = handle(GUI.pruebaMotorButton,'CallbackProperties');
        jConectarMotorButton    = handle(GUI.conectarMotorButton,'CallbackProperties');
        jDesconectarMotorButton = handle(GUI.desconectarMotorButton,'CallbackProperties');
        jVerificarMotorButton   = handle(GUI.verificarMotorButton,'CallbackProperties');
        set(jResetMotorButton,      'ActionPerformedCallback',{@samdir_gui_resetMotorCallback,             GUI});
        set(jPruebaMotorButton,     'ActionPerformedCallback',{@samdir_gui_pruebaMotorCallback,            GUI});
        set(jDesconectarMotorButton,'ActionPerformedCallback',{@samdir_gui_desconectarMotorCallback,       GUI});
        set(jConectarMotorButton,   'ActionPerformedCallback',{@samdir_gui_conectarMotorCallback,          GUI});
        set(jVerificarMotorButton,  'ActionPerformedCallback',{@samdir_gui_verificarConexionMotorCallback, GUI});
        
        personalizarAnguloPanel = uipanel(motorPanel, 'units','norm', 'pos',[0.05,0.03,0.92,0.5], 'title','Medir IR en ángulo personalizado', ...
            'Background',GUI.ColorFondo*.5, ...
            'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
        
         %Check Medición
        GUI.checkMedicion = uicontrol(personalizarAnguloPanel,'Style','checkbox','Value',0,'String','Medición ', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.05 0.7 .6 0.25],'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');
         %Label Angulo
        uicontrol(personalizarAnguloPanel,'Style','text', 'units','norm','Position',[0.01,0.2,0.3,0.3],'FontSize', GUI.fontSizePrimerPanel,...
            'String','Ángulo ', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
        %Text der_rec
        GUI.anguloText = uicontrol(personalizarAnguloPanel,'Style', 'edit','String', '', 'Background','w',...
               'units','norm', 'Position', [0.3,0.18,0.25,0.35]);%,... 
          %Label °
        uicontrol(personalizarAnguloPanel,'Style','text', 'units','norm','Position',[0.57,0.18,0.05,0.3],'FontSize', GUI.fontSizePrimerPanel,...
            'String','°', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
        
        
        GUI.aplicarAngPersonalizadoMotorButton = javax.swing.JButton('Aplicar');
        personalizarBoton(GUI.aplicarAngPersonalizadoMotorButton);
        placeJavaComponent(GUI.aplicarAngPersonalizadoMotorButton, [0.7,0.15,0.26,0.45], personalizarAnguloPanel);
        japlicarMotorButton          = handle(GUI.aplicarAngPersonalizadoMotorButton, 'CallbackProperties');
        
        set(japlicarMotorButton, 'ActionPerformedCallback',{@samdir_gui_aplicarMovimientoMotorCallback,      GUI});
        set(GUI.checkMedicion,   'callback',               {@samdir_gui_medicionAnguloPersonalizadoCallback, GUI});
        set(GUI.aplicarAngPersonalizadoMotorButton,'Enable',0);
        set(GUI.anguloText,                        'Enable','off');

        
        %% Axes para los Graficos de la Señal de Excitación y Grabación
        axTopPanel = uipanel(panel, 'units','norm', 'pos',[0.01,0.5,0.67,0.44], 'BorderType', 'beveledout', 'BorderWidth', 2, 'Background',GUI.ColorFondo*.5);
        axBottomPanel = uipanel(panel, 'units','norm', 'pos',[0.01,0.025,0.67,0.44], 'BorderType', 'beveledout', 'BorderWidth', 2, 'Background',GUI.ColorFondo*.5);
        GUI.axTop    = axes('Parent',axTopPanel,  'XColor',[1,1,1], 'YColor',[1,1,1], 'pos',[0.05,0.28,0.9,0.67], 'Color',[.3,.3,1], 'Tag','axTop');
        GUI.axBottom = axes('Parent',axBottomPanel, 'XColor',[1,1,1], 'YColor',[1,1,1], 'pos',[0.05,0.28,0.9,0.67], 'Color',[.3,.3,1], 'Tag','axBottom');
        samdir_gui_confAxTop(GUI.axTop);
        samdir_gui_confAxTop(GUI.axBottom);
        GUI.iconPlay  = imread('\imagenes\play_icon_24x24.jpg');
        GUI.iconStop  = imread('\imagenes\stop_icon_24x24.jpg');
       
        GUI.playExcitacion = crearBotonesAudio(axTopPanel,    GUI.iconPlay, [28 5 29 27], 'reproducir', {@escucharExcitacionCallback});
        GUI.stopExcitacion = crearBotonesAudio(axTopPanel,    GUI.iconStop, [60 5 27 27], 'parar', {@stopCallback});
        GUI.verExcitacion  = crearBotonesAudio(axTopPanel,    GUI.iconVer,  [90 5 27 27], 'aumentar',  {@verExcitacionCallback});
        GUI.playGrabacion  = crearBotonesAudio(axBottomPanel, GUI.iconPlay, [28 5 29 27], 'reproducir', {@escucharGrabacionCallback});
        GUI.stopGrabacion  = crearBotonesAudio(axBottomPanel, GUI.iconStop, [60 5 27 27], 'parar', {@stopCallback});
        GUI.verGrabacion   = crearBotonesAudio(axBottomPanel, GUI.iconVer,  [90 5 27 27], 'aumentar',  {@verGrabacionCallback});

        
end
function crearPanel_2(panel)
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
    set(GUI.verButton,'visible',0);
    set(GUI.aplicarButton,'visible',0);
    %% Visor 
    lineColor = java.awt.Color(0.3,0.3,1); 
    thickness = 1; 
    roundedCorners = false;
    newBorder = javax.swing.border.LineBorder(lineColor,thickness,roundedCorners);
    backgroundColor=java.awt.Color(0.3,0.3,1);
    iconVer  = imread('\imagenes\preview_icon_24x24.jpg');
    boton = uicontrol('Style','pushbutton', 'CData', iconVer,'TooltipString', 'ver','units','norm', ...
            'pos',[0.9 0.08 .043 .06],'parent',GUI.axTopPanel_2,'HandleVisibility','callback');
    set(boton,'Callback', {@ampliarIRVentana});
    jButton = findjobj(boton);
    jButton.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
   
    for i=1:1:length(jButton)
        set(jButton(i), 'Background', backgroundColor, 'Border', newBorder);
    end

end
function crearPanel_3(panel)
    GUI.panel_IR = uipanel(panel, 'units','norm', 'pos',[0.76,0.04,0.23,0.88], 'Background', ...
        GUI.ColorFondo*.5,'BorderType', 'etchedout', 'BorderWidth', 2);
    irPanel = uipanel(GUI.panel_IR, 'units','norm', 'pos',[0.04,0.5,0.92,0.4], 'title','Extender Longitud', 'Background',GUI.ColorFondo*.5,...
            'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
        
    %% 
     %Label Resolucion IR
    uicontrol(GUI.panel_IR,'Style','text', 'units','norm','Position',[0.02,0.92,0.5,0.05],...
        'String','Resolución IR: ', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold',...
        'FontSize', 10);
    % Text Resolución IR
    GUI.resolucionIR = uicontrol(GUI.panel_IR,'Style', 'text','Background','w', 'units','norm', 'Position', [0.55,0.93,0.3,0.04]);
%    ir = getappdata(0, 'ir_vent');
%    grado = samdir_calculo_fftDegree(ir.samplingRate, ir.trackLength);
%    set(GUI.resolucionIR, 'String', num2str(samdir_resol_frec(ir.samplingRate,grado ))); 
    % Label Hz
    uicontrol(GUI.panel_IR,'Style','text', 'units','norm','Position',[0.8,0.92,0.2,0.05],...
         'String','[Hz]', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    % Checkbox Extender Resolucion
    GUI.extenderlongitud = uicontrol(irPanel,'Style','checkbox','Value',0,'String','Extender longitud 2^n', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.1 0.85 .8 0.1],'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');%,'callback','checkbox1_Callback'); %'tag','h_1',
   % Combo Samples 
   GUI.puntosResCombo = uicontrol(irPanel,'Style', 'popup','String', {'32768', '65536', '131072', '262144', '524288', '1048576'},...
            'units','norm', 'Position', [0.18,0.62,0.36,0.08], 'Background','w');%,...
        %Label puntos
    uicontrol(irPanel,'Style','text', 'units','norm','Position',[0.62,0.5,0.25,0.15],...
         'String','puntos', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
%     %Label Resolucion
    uicontrol(irPanel,'Style','text', 'units','norm','Position',[0.05,0.3,0.35,0.15],...
         'String','Resolución ', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
     %     %Text Resolucion
    GUI.resolucion = uicontrol(irPanel,'Style', 'text','Background','w',...
            'units','norm', 'Position', [0.46,0.35,0.3,0.12]);%,...
    sampingRate = set_preferencias('samplingRate');
    grado = 16;
    set(GUI.resolucion, 'String', num2str(samdir_resol_frec(sampingRate,grado )));    
%     %Label HZ
    uicontrol(irPanel,'Style','text', 'units','norm','Position',[0.8,0.3,0.2,0.15],...
         'String','[Hz]', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
    set(GUI.puntosResCombo,'Value',2);   
%        %% Botones
    GUI.guardarButton = javax.swing.JButton('Guardar');
    personalizarBoton(GUI.guardarButton);
    placeJavaComponent(GUI.guardarButton, [0.5,0.03,0.33,0.13], irPanel);
  
    %% Genera el axes para el grafico
    GUI.axTopPanel_3 = uipanel(panel, 'units','norm', 'pos',[0.01,0.03,0.74,0.93], 'BorderType', 'beveledout',...
            'BorderWidth', 2, 'Background',GUI.ColorFondo*.5);
    GUI.axTop3    = axes('Parent',GUI.axTopPanel_3,  'XColor',[1,1,1], 'YColor',[1,1,1], 'pos',[0.08,0.08,0.9,0.85], 'Color',[.3,.3,1], ...
        'Tag','axTop3');
    samdir_gui_confAxTop(GUI.axTop3);
   
    set(GUI.puntosResCombo,   'Callback',             {@samdir_gui_ExtenderLonguitudCallback,   GUI});
    set(GUI.extenderlongitud, 'Callback',             {@samdir_gui_ExtenderLonguitudCallback, GUI});
    set(GUI.guardarButton,    'MouseClickedCallback', {@samdir_gui_guardarIRCallback,         GUI});

    %% Botones Respuesta en Frecuencia y Energia
    
    GUI.respuestaEnFrecuenciaButton = javax.swing.JButton('Respuesta en Frecuencia');
    GUI.energiaButton = javax.swing.JButton('Energía');
    
    personalizarBoton(GUI.respuestaEnFrecuenciaButton);
    personalizarBoton(GUI.energiaButton);
    
    placeJavaComponent(GUI.respuestaEnFrecuenciaButton, [0.1,0.35,0.8,0.08], GUI.panel_IR);
    placeJavaComponent(GUI.energiaButton, [0.1,0.25,0.8,0.08], GUI.panel_IR);
    
    set(GUI.respuestaEnFrecuenciaButton, 'MouseClickedCallback', {@samdir_gui_respuestaEnFrecuenciaCallback, GUI});
    set(GUI.energiaButton,               'MouseClickedCallback', {@samdir_gui_energiaCallback,               GUI});
    set(GUI.guardarButton,'visible',0);
    set(GUI.respuestaEnFrecuenciaButton,'visible',0);
    set(GUI.energiaButton,'visible',0);
    %% Visor
 %   crearBotonesAudio(axTopPanel_3, GUI.iconVer, [0.93 0.08 .043 .06], 'ver', {@samdir_gui_VerIRCallback});
    %%
    lineColor = java.awt.Color(0.3,0.3,1); 
    thickness = 1; 
    roundedCorners = false;
    newBorder = javax.swing.border.LineBorder(lineColor,thickness,roundedCorners);
    backgroundColor=java.awt.Color(0.3,0.3,1);
    iconVer  = imread('\imagenes\preview_icon_24x24.jpg');
    botonVer = uicontrol('Style','pushbutton', 'CData', iconVer,'TooltipString', 'ver','units','norm', ...
            'pos',[0.92 0.08 .043 .06],'parent',GUI.axTopPanel_3,'HandleVisibility','callback');
    set(botonVer,'Callback', {@verIRCallback});
    jButton = findjobj(botonVer);
    jButton.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
   
    for i=1:1:length(jButton)
        set(jButton(i), 'Background', backgroundColor, 'Border', newBorder);
    end
end
function crearPanel_4(panel)
octava_ter = {'31.5','63','125','250','500','1k','2k','4k','8k','16k'};

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
        placeJavaComponent(GUI.verDirectividadButton, [0.45,0.04,0.28,0.18], personalizadoPanel);
        set(GUI.verDirectividadButton, 'MouseClickedCallback', {@samdir_gui_verDirectividadPersonalizadaCallback, GUI});
        
        %% Panel de Interpolación
        
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
        GUI.resInterpCombo = uicontrol(interpolacionPanel,'Style', 'popup','String', {'1', '2', '5'},...
            'units','norm', 'Position', [0.66,0.44,0.25,0.025], 'Background','w', 'Enable', 'off');%,...
        set(GUI.resInterpCombo,'Value',3); 
        % Label ° 
        uicontrol(interpolacionPanel,'Style','text','Value',0,'String','°', 'Background',GUI.ColorFondo*.5,...
             'units','normalized','Position',[0.92 0.22 .06 0.28],'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', ...
             'ForegroundColor', 'w');
        
        GUI.aplicarInterpolacionButton = javax.swing.JButton(' Aplicar ');
        personalizarBoton(GUI.aplicarInterpolacionButton);
        placeJavaComponent(GUI.aplicarInterpolacionButton, [0.45,0.01,0.28,0.18], interpolacionPanel);
        set(GUI.aplicarInterpolacionButton, 'MouseClickedCallback', {@samdir_gui_aplicarInterpolacionCallback, GUI});
        set(GUI.aplicarInterpolacionButton,'visible',0);
        set(GUI.aplicarInterpolacionButton,'Enable',0);
        set(GUI.verDirectividadButton,'visible',0);
        
        %% Panel de Medición
        parametrosPanel = uipanel(GUI.primerPanel, 'units','norm', 'pos',[0.05,0.02,0.88,0.32], 'title','Parámetros', 'Background',GUI.ColorFondo*.5,...
                'ForegroundColor', 'w', 'FontSize', GUI.fontSizePrimerPanel, 'FontWeigh', 'bold', 'FontName', GUI.fontNamePrimerPanel);
       %Combo Frecuencias
        GUI.comboFrecuencias = uicontrol(parametrosPanel,'Style', 'popup','String', octava_ter,...
            'units','norm', 'Position', [0.7,0.99,0.27,0.025], 'Background','w');%,...
        set(GUI.comboFrecuencias, 'CallBack', {@samdir_gui_selecFrecDirectividad, GUI});    
        %     %Label Q
        uicontrol(parametrosPanel,'Style','text', 'units','norm','Position',[0.01,0.65,0.15,0.15],...
         'String','Q ', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
       %Text Q
        GUI.factorQ = uicontrol(parametrosPanel,'Style', 'text','Background','w','units','norm', 'Position', [0.18,0.65,0.3,0.15]);
        %     %Label ID
        uicontrol(parametrosPanel,'Style','text', 'units','norm','Position',[0.01,0.45,0.15,0.15],...
         'String','ID ', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
       % Text ID
        GUI.indiceD = uicontrol(parametrosPanel,'Style', 'text','Background','w','units','norm', 'Position', [0.18,0.45,0.3,0.15]);
         %    Label dB
        uicontrol(parametrosPanel,'Style','text', 'units','norm','Position',[0.48,0.45,0.12,0.15],...
         'String','dB', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
       %    Label Angulo de Cobertura
        uicontrol(parametrosPanel,'Style','text', 'units','norm','Position',[0.001,0.22,0.7,0.15],...
         'String','Ángulo de cobertura', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
       %Text Angulo de cobertura
        GUI.anguloCobertura = uicontrol(parametrosPanel,'Style', 'text','Background','w','units','norm', 'Position', [0.7,0.22,0.28,0.15]);
         %    Label Angulo de Cobertura
        uicontrol(parametrosPanel,'Style','text', 'units','norm','Position',[0.95,0.22,0.05,0.15],...
         'String','°', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
        %     %Label ID/freq
        uicontrol(parametrosPanel,'Style','text', 'units','norm','Position',[0.025,0.05,0.2,0.15],...
         'String','ID/freq ', 'Background',GUI.ColorFondo*.5, 'ForegroundColor', 'w', 'FontWeigh', 'bold');
       
        GUI.verTodoQButton  = javax.swing.JButton('Ver todo');
        GUI.verTodoIDButton = javax.swing.JButton('Ver todo');
        GUI.verIDFreqButton = javax.swing.JButton('Ver');
        personalizarBoton (GUI.verTodoQButton);
        personalizarBoton (GUI.verTodoIDButton);
        personalizarBoton (GUI.verIDFreqButton);
        placeJavaComponent(GUI.verTodoQButton,  [0.7,0.63,0.28,0.18], parametrosPanel);
        placeJavaComponent(GUI.verTodoIDButton, [0.7,0.42,0.28,0.18], parametrosPanel);
        placeJavaComponent(GUI.verIDFreqButton, [0.3,0.05,0.28,0.18], parametrosPanel);
        set(GUI.verTodoQButton,  'MouseClickedCallback', {@samdir_gui_graficarFactorCallback, GUI});
        set(GUI.verTodoIDButton, 'MouseClickedCallback', {@samdir_gui_graficarIndiceCallback, GUI});
        set(GUI.verIDFreqButton, 'MouseClickedCallback', {@samdir_gui_graficarDirFreCallback, GUI});
        set(GUI.verTodoQButton, 'visible',0);
        set(GUI.verTodoIDButton,'visible',0);
        set(GUI.verIDFreqButton,'visible',0);
        
        %% Genera el axes para el grafico
        GUI.axTopPanel_4 = uipanel(panel, 'units','norm', 'pos',[0.01,0.03,0.7,0.93], 'BorderType', 'beveledout',...
            'BorderWidth', 2, 'Background','w');
         
        GUI.axBajas4    = axes('Parent',GUI.axTopPanel_4, 'pos',[0.09,0.08,0.9,0.85], 'Color','w', 'Tag','axBajas4');       
       
       set(GUI.interpolarCheck, 'callback', {@samdir_gui_interpolacionCallback, GUI});

       %% Panel de Botones
       axBotonesPanel = uipanel(panel, 'units','norm', 'pos',[0.6,0.89,0.11,0.072], 'BorderType', 'beveledout',...
           'BorderWidth', 2, 'Background','k');
       
       %Label ventanas/Total
       GUI.nVentana = uicontrol(axBotonesPanel,'Style','text', 'units','norm','Position',[0.05,0.14,0.3,0.7],...
        'String','  1/3  ', 'Background','w', 'ForegroundColor', 'k');
       % Botones siguiente/anterior
       GUI.iconSiguiente  = imread('siguienteIcon._24.jpg');
       GUI.iconAnterior   = imread('anteriorIcon_24.jpg');
       GUI.siguienteBoton = crearBotonesAudio(axBotonesPanel, GUI.iconSiguiente, [66 2 27 27], 'siguiente', {});
       GUI.anteriorBoton  = crearBotonesAudio(axBotonesPanel, GUI.iconAnterior,  [40 2 27 27], 'anterior',  {});
       set(GUI.siguienteBoton, 'Callback', {@cambioCallback, GUI, 'siguiente'});
       set(GUI.anteriorBoton,  'Callback', {@cambioCallback, GUI, 'anterior'});
       set(GUI.anteriorBoton, 'Enable', 'off');
        
       %%
       %crearBotonesAudio(GUI.axTopPanel_4, GUI.iconVer, [0.94 0.08 .043 .06], 'ver',{@samdir_gui_VerDirectividadCallback})
       %%
        lineColor = java.awt.Color(0.3,0.3,1); 
        thickness = 1; 
        roundedCorners = false;
        newBorder = javax.swing.border.LineBorder(lineColor,thickness,roundedCorners);
        backgroundColor=java.awt.Color(0.3,0.3,1);
        iconVer  = imread('\imagenes\preview_icon_24x24.jpg');
        botonVerDirectiv = uicontrol('Style','pushbutton', 'CData', iconVer,'TooltipString', 'ver','units','norm', ...
                'pos',[0.94 0.08 .043 .06],'parent',GUI.axTopPanel_4,'HandleVisibility','callback');
        set(botonVerDirectiv,'Callback', {@samdir_gui_VerDirectividadCallback, GUI});
        jVerButton = findjobj(botonVerDirectiv);
        jVerButton.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));

        for i=1:1:length(jVerButton)
            set(jVerButton(i), 'Background', backgroundColor, 'Border', newBorder);
        end
       
end
function cambioCallback(h,e, GUI, action)
        ventana = GUI.handles.controller.ventanaDirectividad;
        switch action
            case 'siguiente'
                ventana = ventana + 1;
            case 'anterior'
                ventana = ventana - 1;
        end
         GUI.handles.controller.ventanaDirectividad = ventana;
         octavas = length(GUI.handles.controller.leyenda);
         switch octavas
             case 10
                if(ventana == 1)
                    set(GUI.anteriorBoton, 'Enable', 'off');
                    set(GUI.siguienteBoton, 'Enable', 'on');
                    set (GUI.nVentana, 'String','  1/3  ');
                    GUI.handles.controller.graficarDirectividad(1, 4);
                elseif (ventana == 2)
                    set(GUI.anteriorBoton, 'Enable', 'on');
                    set(GUI.siguienteBoton, 'Enable', 'on');
                    set (GUI.nVentana, 'String','  2/3  ');
                    GUI.handles.controller.graficarDirectividad(5, 7);
                elseif (ventana == 3)
                    set(GUI.anteriorBoton, 'Enable', 'on');
                    set(GUI.siguienteBoton, 'Enable', 'off');
                    set (GUI.nVentana, 'String','  3/3  ');
                    GUI.handles.controller.graficarDirectividad(8, 10);
                end
             case 30
                if(ventana == 1)
                    set(GUI.anteriorBoton, 'Enable', 'off');
                    set(GUI.siguienteBoton, 'Enable', 'on');
                    set (GUI.nVentana, 'String','  1/5  ');
                    GUI.handles.controller.graficarDirectividad(1, 6);
                elseif (ventana == 2)
                    set(GUI.anteriorBoton, 'Enable', 'on');
                    set(GUI.siguienteBoton, 'Enable', 'on');
                    set (GUI.nVentana, 'String','  2/5  ');
                    GUI.handles.controller.graficarDirectividad(7, 12);
                elseif (ventana == 3)
                    set(GUI.anteriorBoton, 'Enable', 'on');
                    set(GUI.siguienteBoton, 'Enable', 'on');
                    set (GUI.nVentana, 'String','  3/5  ');
                    GUI.handles.controller.graficarDirectividad(13, 18);
                elseif (ventana == 4)
                    set(GUI.anteriorBoton, 'Enable', 'on');
                    set(GUI.siguienteBoton, 'Enable', 'on');
                    set (GUI.nVentana, 'String','  4/5  ');
                    GUI.handles.controller.graficarDirectividad(19, 24);
                elseif (ventana == 5)
                    set(GUI.anteriorBoton, 'Enable', 'on');
                    set(GUI.siguienteBoton, 'Enable', 'off');
                    set (GUI.nVentana, 'String','  5/5  ');
                    GUI.handles.controller.graficarDirectividad(25, 30);
                end
         end
        drawnow;
    end
end