classdef controlador < handle
    
    properties
        mModelo
        mVista
        mVistaSamdir
       
    end
    properties(Access = private, Hidden = true)
        % here are default values defined
        mTipoSenial                = 'sweep';      % 'sweep' / 'tonoPuro'     
        mSeleccionExcitacion       = false;
        mTipoMedicion              = 'ir';           %'ir' / 'directividad'
        mVentanaDirectividad       = 1;             % 1 / 2 / 3
        mInterpolacionDirectividad = false;         %false/true
        mAplicoInterpolacion       = false;         %false/true
        mPic                       = 0;             %serial
        mPosicion                  = 0;
    end
    properties(Dependent = true, Hidden = false)
        % here are default values defined
        tipoSenial 
        seleccionExcitacion
        tipoMedicion
        ventanaDirectividad
        interpolacionDirectividad
        aplicoInterpolacion
        pic
        posicion
    end

    
    methods
        function obj = controlador(modelo)
            obj.mModelo = modelo;
            obj.mVista = vista(obj);
        end
        
        function result = get.tipoSenial(this)
            result = this.mTipoSenial;
        end
        
        function set.tipoSenial(this, value)
            this.mTipoSenial = value;
        end
        
        function result = get.seleccionExcitacion(this)
            result = this.mSeleccionExcitacion;
        end
        
        function set.seleccionExcitacion(this, value)
            this.mSeleccionExcitacion = value;
        end
        
        function result = get.tipoMedicion(this)
            result = this.mTipoMedicion;
        end
        
        function set.tipoMedicion(this, value)
            this.mTipoMedicion = value;
        end
        
        function result = get.ventanaDirectividad(this)
            result = this.mVentanaDirectividad;
        end
        
        function set.ventanaDirectividad(this, value)
            this.mVentanaDirectividad = value;
        end
        
        function result = get.interpolacionDirectividad(this)
            result = this.mInterpolacionDirectividad;
        end
        
        function set.interpolacionDirectividad(this,value)
            this.mInterpolacionDirectividad = value;
        end
        
        function result = get.aplicoInterpolacion(this)
            result = this.mAplicoInterpolacion;
        end
        
        function set.aplicoInterpolacion(this,value)
            this.mAplicoInterpolacion = value;
        end
        
        function result = get.pic(this)
            result = this.mPic;
        end
        
        function set.pic(this,value)
            this.mPic = value;
        end
        
        function result = get.posicion(this)
            result = this.mPosicion;
        end
        
        function set.posicion(this,value)
            this.mPosicion = value;
        end
        
        function setDensity(obj,density)
            obj.mModelo.setDensity(density)
        end
        
        function setVolume(obj,volume)
            obj.mModelo.setVolume(volume)
        end
        
        function setUnits(obj,units)
            obj.mModelo.setUnits(units)
        end
        
        function calculate(obj)
            obj.mModelo.calculate()
        end
        
        function reset(obj)
            obj.mModelo.reset()
        end
        function seleccionMedicion(this, tipo)
            this.tipoMedicion = tipo;
        end
        function crearExcitacion(obj)
           obj.inicializacion();
           if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.crearExcitacionSweep();
                samdir_gui_graficarExcitacionSweep(obj.mVista.mGui.axTop,obj.mModelo.senialExcitacion);
                set(obj.mVista.mGui.graficoBarrasMenu, 'Enable', 'off');
           else
                obj.mModelo.crearExcitacionTonoPuro();
                samdir_gui_graficarExcitacionTono(obj.mVista.mGui.axTop,obj.mModelo.senialExcitacionTono);
                samdir_logMensajes(obj.mVista.mGui.jLogPanel, 'Se muestra el tono de 1000Hz, ampliar para observar el resto','w');
                obj.mVista.mGui.ftRadiobutton.setSelected(false);
                obj.mVista.mGui.dirRadiobutton.setSelected(true);
                set(obj.mVista.mGui.obtenerButton, 'enable', 0);
                set(obj.mVista.mGui.medirDirButton,'enable', 1);
                set(obj.mVista.mGui.graficoBarrasMenu, 'Enable', 'on');
           end
           samdir_logMensajes(obj.mVista.mGui.jLogPanel, 'Señal de excitacion obtenida');
           samdir_gui_confAxTop(obj.mVista.mGui.axTop);
           obj.seleccionExcitacion = true;

           set(obj.mVista.mGui.excitacionVerMenu, 'Enable', 'on');
           set(obj.mVista.mGui.excitacionEspecVerMenu, 'Enable', 'on');
           
        end
        
        function graficoBarras(this)
             samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Obteniendo Gráfico...');
             this.mModelo.medicionIRTonos(); 
             samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Gráfico Obtenido');
        end
        
        function verMenuRespuestaEnFrecuencia(this, signal)
               switch(signal)
                    case 'excitacion'
                        if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                            this.mModelo.verExcitacionSweep;
                        else
                            this.mModelo.verExcitacionTono;
                        end
                    case 'grabada'
                        if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                            this.mModelo.verGrabacionSweep;
                        else
                            this.mModelo.verGrabacionTono;
                        end
                    case 'ir'
                        this.mModelo.verIR();
                    otherwise
                        samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Error al pasar señal', 'w');
               end
        end
        function escucharExcitacion(obj)
            if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.escucharExcitacionSweep();
            else
                obj.mModelo.escucharExcitacionTono();
            end
        end
        function verExcitacion(obj)
            if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.verExcitacionSweep();
            else
                obj.mModelo.verExcitacionTono();
            end
        end
        
        function escucharGrabacion(obj)
            if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.escucharGrabacionSweep();
            else
                obj.mModelo.escucharGrabacionTono();
            end
        end
        function verGrabacion(obj)
            if(strcmp(obj.mModelo.TipoSenial(), 'sweep'))
                obj.mModelo.verGrabacionSweep();
            else
                obj.mModelo.verGrabacionTono();
            end
        end
        
        function guardarConfiguracion(obj, ventana)
            samdir_gui_guardarConfiguracion(ventana)
            obj.mModelo.guardarConfiguracion();
        end
        function mostrarPreferencias(obj)
            [messageout structPreferencias] = samdir_gui_mostrarPreferencias();
            obj.mTipoSenial = structPreferencias.tipoExcitacion;
            set(obj.mVista.mGui.infoConfiguracion, 'String', '');
            set(obj.mVista.mGui.infoConfiguracion, 'String', messageout);
        end
       function mensajeGUI(message)
           
                samdir_logMensajes(obj.mVista.mGui.jLogPanel, message);
           
       end
       function result = checkExcitacion(this)
            if(this.seleccionExcitacion)
                result = true;
            else
                samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Ingrese Señal de Excitación', 'w');
                result = false;
            end
       end
       
       function inicializacion(this)
            
            samdir_gui_guardarConfiguracion(this.mVista.mGui.ventanaConfiguracion);
            this.mModelo.guardarConfiguracion();
            this.resetDirectividad();
       end
       
       function obtenerMedicionDirectividad(this)
            
            this.inicializacion();
            samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Obteniendo Directividad...');
            if(strcmp(this.mModelo.TipoSenial(), 'sweep'))
                this.mModelo.medicionDirectividadSweep(this.pic);
                set(this.mVista.mGui.grabacionVerMenu, 'Enable', 'on');
                set(this.mVista.mGui.grabacionEspecVerMenu, 'Enable', 'on');
                samdir_gui_graficarGrabacionSweep(this.mVista.mGui.axBottom, this.mModelo.senialGrabadaDirect(1));
                samdir_gui_confAxTop(this.mVista.mGui.axBottom);
                jTabGroup = getappdata(handle(this.mVista.mGui.hTabGroup),'JTabbedPane');
                jTabGroup.setEnabledAt(1,true);
                set(this.mVista.mGui.hTabGroup, 'SelectedTab', this.mVista.mGui.tab(2));
                this.modificacionIRVentana();
                
            else
                this.mModelo.medicionDirectividadTonoPuro(this.pic);
                jTabGroup = getappdata(handle(this.mVista.mGui.hTabGroup),'JTabbedPane');
                jTabGroup.setEnabledAt(3,true);
                set(this.mVista.mGui.hTabGroup, 'SelectedTab', this.mVista.mGui.tab(4));
                this.ajustesPanelDirectividad();
                this.mModelo.medicionDirectividadTonoPotenciaxBandas();
            end
            
       end
       
       function ajustesPanelDirectividad(this)
            set(this.mVista.mGui.aplicarInterpolacionButton,'visible',1);
            set(this.mVista.mGui.verDirectividadButton,     'visible',1);
            set(this.mVista.mGui.verTodoQButton,            'visible',1);
            set(this.mVista.mGui.verTodoIDButton,           'visible',1);
%            set(this.mVista.mGui.verIDFreqButton,           'visible',1);
           
            switch (this.mModelo.octavas)
                case 1
                    set(this.mVista.mGui.resFrecuenciaCombo_1, 'String', this.mModelo.label_oct);
                    set(this.mVista.mGui.resFrecuenciaCombo_2, 'String', this.mModelo.label_oct);
                    set(this.mVista.mGui.resFrecuenciaCombo_3, 'String', this.mModelo.label_oct);
                    set(this.mVista.mGui.comboFrecuencias,     'String', this.mModelo.label_oct);
                    set (this.mVista.mGui.nVentana, 'String','  1/3  ');
               case 3
                    set(this.mVista.mGui.resFrecuenciaCombo_1, 'String', this.mModelo.label_ter);
                    set(this.mVista.mGui.resFrecuenciaCombo_2, 'String', this.mModelo.label_ter);
                    set(this.mVista.mGui.resFrecuenciaCombo_3, 'String', this.mModelo.label_ter);
                    set(this.mVista.mGui.comboFrecuencias,     'String', this.mModelo.label_ter);
                    set (this.mVista.mGui.nVentana, 'String','  1/5  ');
            end
           
       end
        
       function medicion = obtenerMedicionesIR(this)
          
              samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Obteniendo Respuesta Impulsiva ...');
              if(strcmp(this.mModelo.TipoSenial(), 'sweep'))
                this.mModelo.medicionIR();
                set(this.mVista.mGui.grabacionVerMenu, 'Enable', 'on');
                set(this.mVista.mGui.grabacionEspecVerMenu, 'Enable', 'on');
                samdir_gui_graficarGrabacionSweep(this.mVista.mGui.axBottom, this.mModelo.senialGrabada)
                samdir_gui_confAxTop(this.mVista.mGui.axBottom);
                pause(0.7);
                
                jTabGroup = getappdata(handle(this.mVista.mGui.hTabGroup),'JTabbedPane');
                jTabGroup.setEnabledAt(1,true);
                set(this.mVista.mGui.hTabGroup, 'SelectedTab', this.mVista.mGui.tab(2));
                medicion = 1;
                
              else
                samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Ingrese una señal de tipo sweep', 'w');
                medicion = 2;
              end
       end
       function modificacionIRVentana(this)
           if(strcmp(this.tipoMedicion(), 'ir'))
                this.mModelo.ventanaIR('ir');
           else
               this.mModelo.ventanaIR('directividad');
           end

           samdir_gui_graficarIRmasVentana(this.mVista.mGui.axTop2, this.mModelo.senialIRModificada, this.mModelo.ventana);
       end
       
       function ventanaIRVer(this, izq_rec,der_rec,tipo_1,izq,tipo_2,der)
           if(strcmp(this.tipoMedicion(), 'ir'))
               this.mModelo.ventanaIRVer(izq_rec,der_rec,tipo_1,izq,tipo_2,der, 'ir');
               samdir_gui_graficarIRmasVentana(this.mVista.mGui.axTop2, this.mModelo.senialIRModificada, this.mModelo.ventana);
           else
               this.mModelo.ventanaIRVer(izq_rec,der_rec,tipo_1,izq,tipo_2,der, 'directividad');
               samdir_gui_graficarIRmasVentana(this.mVista.mGui.axTop2, this.mModelo.senialIRModificada, this.mModelo.ventana);
           end
       end
       function ventanaIRLupa(this)
            this.mModelo.ventanaIRLupa();
       end
       function aplicarVentanaIR(this)
           this.resetDirectividad();
           this.mModelo.aplicarVentanaIR(this.tipoMedicion());
           pause(1);
           if(strcmp(this.tipoMedicion(), 'ir'))
               jTabGroup = getappdata(handle(this.mVista.mGui.hTabGroup),'JTabbedPane');
               jTabGroup.setEnabledAt(2,true);
               set(this.mVista.mGui.hTabGroup, 'SelectedTab', this.mVista.mGui.tab(3));
               samdir_gui_graficarIRVentaneada(this.mVista.mGui.axTop3, this.mModelo.senialIRVentaneada);
               set(this.mVista.mGui.guardarButton,'visible',1);
               set(this.mVista.mGui.respuestaEnFrecuenciaButton,'visible',1);
               set(this.mVista.mGui.energiaButton,'visible',1);
           else
               cla(this.mVista.mGui.axBajas4, 'reset');
               if(strcmp(this.mModelo.TipoSenial(), 'sweep'))
                   jTabGroup = getappdata(handle(this.mVista.mGui.hTabGroup),'JTabbedPane');
                   jTabGroup.setEnabledAt(3,true);
                   set(this.mVista.mGui.hTabGroup, 'SelectedTab', this.mVista.mGui.tab(4));
                   this.ajustesPanelDirectividad();
                   this.mModelo.medicionDirectividadSweepPotenciaxBandas();
                   
               else
                   
                   
               end
               this.mModelo.medicionDirectividadParametros();
               this.mModelo.medicionDirectividadSweepPlot();

                   switch (this.mModelo.octavas)
                    case 1
                        this.graficarDirectividad(1, 4);
                    case 3
                        this.graficarDirectividad(1, 6);
                    end

                   this.mostrarParametrosDirectividad(1);
                   samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Directividad obtenida');
           end
       end
       %Hacer que devuelva algun valor indicando que se pudo guardar bien
       function leyenda = leyenda(this)
          
           octavas = this.mModelo.octavas;
               if(octavas == 1)
                    leyenda = this.mModelo.label_oct;
               else
                    leyenda = this.mModelo.label_ter;
               end
       end
       function guardarIR(this)
           this.mModelo.guardarIR();
       end
       function resolucion = resolucionFrecuencia(this, grado)
           resolucion = this.mModelo.resolucionFrecuencia(grado);
       end
       function resolucion = extenderIR(this, grado)
           resolucion = this.mModelo.extenderIR(grado);
           samdir_gui_graficarIRVentaneada(this.mVista.mGui.axTop3, this.mModelo.senialIRExtendida)
       end
       function verIRExtendidaLupa(this)
            if(~isempty(this.mModelo.senialIRExtendida))
                samdir_gui_VerIRCallback(this.mModelo.senialIRExtendida);
            else
                samdir_gui_VerIRCallback(this.mModelo.senialIRVentaneada);
            end
       end
       function verDirectividadLupa(this)
           [theta rho] = this.vectoresDirectividad();
         
           switch (this.mModelo.octavas)
                case 1
                    if(this.ventanaDirectividad == 1)
                        this.graficarDiagrama(1, 4,  theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad);
                    elseif (this.ventanaDirectividad == 2)
                        this.graficarDiagrama(5, 7,  theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad);
                    elseif (this.ventanaDirectividad == 3)
                        this.graficarDiagrama(8, 10, theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad);   
                    end
               case 3
                   if(this.ventanaDirectividad == 1)
                        this.graficarDiagrama(1, 6,  theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad);
                   elseif (this.ventanaDirectividad == 2)
                        this.graficarDiagrama(7, 12,  theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad);
                   elseif (this.ventanaDirectividad == 3)
                        this.graficarDiagrama(13, 18, theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad); 
                   elseif (this.ventanaDirectividad == 4)
                        this.graficarDiagrama(19, 24, theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad);
                   elseif (this.ventanaDirectividad == 5)
                        this.graficarDiagrama(25, 30, theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad);
                    end
           end
           
             drawnow;
       end
      
       function graficarDiagrama(this,inicio, fin, theta, rho, parameters,leyenda, ventana)
         
            switch (this.mModelo.octavas)
                case 1
                   vectorColor = ['k', 'r', 'b', 'g', 'k', 'r', 'b', 'k', 'r', 'b'];
               case 3
                    vectorColor = ['k', 'r', 'b', 'g','m', 'c', 'k', 'r', 'b', 'g','m', 'c','k', 'r', 'b', 'g','m', 'c', 'k', 'r', 'b', 'g','m', 'c', 'k', 'r', 'b', 'g','m', 'c'];
            end
               
             figure;
             hold off
             for i=inicio:fin,
               
                 dirplot(theta',rho(:,i), vectorColor(i), parameters);
                 hold on
             end
            switch (this.mModelo.octavas)
                case 1
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
                case 3
                    switch ventana
                        case 1
                                legend(leyenda{1},leyenda{2},leyenda{3}, leyenda{4}, leyenda{5}, leyenda{6} -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Muy Bajas';
                        case 2
                                legend(leyenda{7},leyenda{8},leyenda{9},leyenda{10},leyenda{11}, leyenda{12}, -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Bajas';
                        case 3
                                legend(leyenda{13},leyenda{14},leyenda{15},leyenda{16},leyenda{17}, leyenda{18}, -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Medias';
                        case 4
                                legend(leyenda{19},leyenda{20},leyenda{21},leyenda{22},leyenda{23}, leyenda{24}, -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Altas';
                        case 5
                                legend(leyenda{25},leyenda{26},leyenda{27},leyenda{28},leyenda{29}, leyenda{30}, -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Muy Altas';
                    end
            end
            title(titulo);

       end
       
       function graficarDirectividad(this, inicio, fin)
           [theta rho] = this.vectoresDirectividad();
           this.graficarDirplot(inicio, fin, theta, rho, this.mModelo.parametros, this.leyenda, this.ventanaDirectividad, this.mVista.mGui.axBajas4);
       end
       
       function graficarDirplot(this, inicio, fin, theta, rho, parametrs, leyenda, ventana, axes)
            hold off
           
            switch (this.mModelo.octavas)
                case 1
                   vectorColor = ['k', 'r', 'b', 'g', 'k', 'r', 'b', 'k', 'r', 'b'];
               case 3
                    vectorColor = ['k', 'r', 'b', 'g','m', 'c', 'k', 'r', 'b', 'g','m', 'c','k', 'r', 'b', 'g','m', 'c', 'k', 'r', 'b', 'g','m', 'c', 'k', 'r', 'b', 'g','m', 'c'];
            end
           
           for i=inicio:fin,
                 dirplot(theta',rho(:,i), vectorColor(i), parametrs, axes);
                 hold(axes,'on')
           end
            switch (this.mModelo.octavas)
                case 1
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
                case 3
                    switch ventana
                        case 1
                                legend(leyenda{1},leyenda{2},leyenda{3}, leyenda{4}, leyenda{5}, leyenda{6} -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Muy Bajas';
                        case 2
                                legend(leyenda{7},leyenda{8},leyenda{9},leyenda{10},leyenda{11}, leyenda{12}, -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Bajas';
                        case 3
                                legend(leyenda{13},leyenda{14},leyenda{15},leyenda{16},leyenda{17}, leyenda{18}, -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Medias';
                        case 4
                                legend(leyenda{19},leyenda{20},leyenda{21},leyenda{22},leyenda{23}, leyenda{24}, -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Altas';
                        case 5
                                legend(leyenda{25},leyenda{26},leyenda{27},leyenda{28},leyenda{29}, leyenda{30}, -1);
                                titulo = 'Diagrama de Directividad - Frecuencias Muy Altas';
                    end
            end
            title(titulo);
            drawnow;
       end
       
       function graficarDirplotPersonalizada(this, index, color)
           [theta rho] = this.vectoresDirectividad();
           dirplot(theta',rho(:,index), color, this.mModelo.parametros);
           legend(this.leyenda{index}, -1);    
       end
       
       function graficarDirectividadPersonalizada(this, index, color)
           [theta rho] = this.vectoresDirectividad();
           dirplot(theta',rho(:,index), color, this.mModelo.parametros);
           if(ishold)
              agregarLeyenda =get(legend(gca),'String');
              if(length(agregarLeyenda)> 1)
                    legend(agregarLeyenda{1},agregarLeyenda{2},this.leyenda{index}, -1);
              else
                    legend(agregarLeyenda{1},this.leyenda{index}, -1);
              end
            else
                legend(this.leyenda{index}, -1);  
            end
               
       end
     
       function mostrarParametrosDirectividad(this, indice)
           set(this.mVista.mGui.anguloCobertura, 'String', num2str(this.mModelo.anguloCobertura(indice)));
           set(this.mVista.mGui.factorQ,         'String', num2str(this.mModelo.factorQ(1,indice)));
           set(this.mVista.mGui.indiceD,         'String', num2str(this.mModelo.indiceDirectividad(1,indice)));
       end
       
       function aplicarInterpolacion(this, tipoInterpolacion, index_selected) 
            this.mModelo.interpolacionDirectividad(tipoInterpolacion, index_selected);
       end
       
       function [theta rho] = vectoresDirectividad(this)
           if(this.aplicoInterpolacion && this.interpolacionDirectividad)
               
               theta = this.mModelo.thetaInterp;
               rho   = this.mModelo.potenciadBInterp;
           else
               theta = this.mModelo.theta;
               rho   = this.mModelo.potenciadB;
           end
       end
       
       function resetDirectividad(this)
            cla(this.mVista.mGui.axBajas4, 'reset');
            this.ventanaDirectividad = 1;
            set(this.mVista.mGui.anteriorBoton, 'Enable', 'off');
            set(this.mVista.mGui.siguienteBoton, 'Enable', 'on');
            octavas = this.mModelo.octavas;
            if(octavas == 1)
                set(this.mVista.mGui.nVentana, 'String','  1/3  ');
            else
                set(this.mVista.mGui.nVentana, 'String','  1/5  ');
            end  
            bandera =3
       end
       function graficarIndiceDirectividad(this, frecuencia)
            this.mModelo.graficarIndiceDirectividad(frecuencia);
       end
       function graficarFactorDirectividad(this, frecuencia)
            this.mModelo.graficarFactorDirectividad(frecuencia);
       end
       
       function graficarDirectividadFreq(this)
            this.mModelo.graficarDirectividadFreq();
       end
       
       function respuestaFrecuenciaBoton(this)
           if(strcmp(this.mModelo.TipoSenial(), 'sweep'))
                this.mModelo.respuestaFrecuenciaSweepBoton();
           else
               this.mModelo.respuestaFrecuenciaTonoBoton();
           end
       end
       function energiaBoton(this)
           this.mModelo.energiaBoton();
       end
       function crearObjetoPic(this)
           this.pic = samdir_usb();
           if(this.pic == 0)
                samdir_logMensajes(this.mVista.mGui.jLogPanel, 'No se pudo establecer comunicacion', 'w');
           else
               samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Conectando...');
               set(this.mVista.mGui.conexionMotor, 'String', '');
               set(this.mVista.mGui.conexionMotor,'ForegroundColor', 'g');
               set(this.mVista.mGui.conexionMotor, 'String', 'Conectado');
               samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Conexión establecida');
           end
       end
       function verificarObjetoPic(this)
           enviarObjetoPic(this, 'id',  0)
       end
       function pruebaObjetoPic(this)
           enviarObjetoPic(this, 'id',  0)
       end
       function resetObjetoPic(this)
           enviarObjetoPic(this, 'id',  0)
       end
       function enviarObjetoPic(this, comando, dato0)
           estado = samdir_comunicacion(this.pic, comando, dato0);
           if(estado)
               samdir_logMensajes(this.mVista.mGui.jLogPanel, 'Comando enviado');
           else
               samdir_logMensajes(this.mVista.mGui.jLogPanel, 'No se pudo establecer comunicacion', 'w');
           end
       end
       function cerrarObjetoPic(this)
           % cerrando el puerto
           set(this.mVista.mGui.conexionMotor, 'String', '');
           set(this.mVista.mGui.conexionMotor,'ForegroundColor', 'r');
           set(this.mVista.mGui.conexionMotor, 'String', 'desconectado');
            fclose(this.pic);
            % borrando el objeto de memoria
            delete(this.pic)
            clear this.pic
       end
       function movimientoMotor(this, angulo)
           samdir_logMensajes(this.mVista.mGui.jLogPanel, strcat('La posicion es ', num2str(this.posicion)));
           [this.posicion estado] = samdir_mov_angular(this.pic, angulo, this.posicion);
           if(estado)
               samdir_logMensajes(this.mVista.mGui.jLogPanel, 'El dispositivo está ubicado en el ángulo indicado');
           else
               samdir_logMensajes(this.mVista.mGui.jLogPanel, 'No se pudo establecer comunicacion', 'w');
           end
           samdir_logMensajes(this.mVista.mGui.jLogPanel, strcat('La posicion es ', num2str(this.posicion)));
       end
    end
    methods (Static = true)
        
         
    end
end