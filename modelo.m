classdef modelo < handle    
    %Creo que es para que se actualice lo que esta en la vista
    properties (SetObservable)
        density
        volume
        units
        mass
    end
    
    properties(Constant, Hidden = true)
       label_oct   = {'31.5Hz','63Hz','125Hz','250Hz','500Hz','1kHz','2kHz','4kHz','8kHz','16kHz'};
       label_ter   = {'25Hz','31.5Hz','40Hz','50Hz','63Hz','80Hz','100Hz','125Hz','160Hz','200Hz',...
        '250Hz','315Hz','400Hz','500Hz','630Hz','800Hz','1kHz','1.25kHz','1.6kHz','2kHz',... 
        '2.5kHz','3.15kHz','4kHz','5kHz','6.3kHz','8kHz','10kHz','12.5kHz','16kHz','20kHz'};
    end
    
    properties(Access = private, Hidden = true)
      
       mSamplingRate         = 44100;
       mGradoFft             = 16;
       mSenialExcitacion     = samdirAudio;
       mSenialExcitacionTono = struct(samdirAudio);
       mSenialGrabada        = samdirAudio;
       mSenialGrabadaDirect  = struct(samdirAudio);
       mSenialTonGrabadaDir  = [[];[];];
       mSenialIRVentanDirect = struct(samdirAudio);
       mSenialTonVentDirect  = [[];[];];
       mSenialIRDirect       = struct(samdirAudio);
       mPotenciadB           = [[];[];];
       mPotenciaTonoDirdB    = [[];[];];
       mPotenciadBInterp     = [[];[];];
       mSenialGrabadaTono    = struct(samdirAudio);
       mSenialIR             = samdirAudio;
       mSenialIRModificada   = samdirAudio;
       mSenialIRVentaneada   = samdirAudio;
       mSenialIRExtendida    = samdirAudio;
       mPotenciaTonodB       = [[];[];];
       mDatos                = [];
       mTipoExcitacion       = 'Barrido Senoidal Logarítmico';
       mTipoVentana          = 'Hann';
       mVentana              = samdirAudio;
       mInicioVentana        = 0.1;
       mFinVentana           = 0.1;
       mVectorFrecuencias    = [31.5,63,125,250,500,1000,2000,4000,8000,16000];
       mBandasOctava         = 1;
       mAmplitud             = 0;
       mResolucionDirectiv   = 30;
       mAnguloInicial        = 0;
       mAnguloFinal          = 360;
       mOrdenFiltro          = 2;
       mTheta                = [];
       mThetaInterp          = [];
       mRho                  = [[];[];];
       mFrec                 = 0;
       mNumeroEnsayosDirect  = 0;
       mGiroCompleto         = 0;
       mParametros           = [5 -25 6];
       mAnguloCobertura      = [];
       mFactorQ              = [[];[];];
       mIndiceDirectividad   = [];
       mInput                = 0;
       mOutput               = 0;
       mGuardaIR             = 0;
       mDirectorioGuardar    = '';
       mNBits                = 16;
    end
    
    properties(Dependent = true, Hidden = true)
		amplitud
        samplingRate
        senialExcitacion
        senialExcitacionTono
        senialGrabada
        senialGrabadaDirect
        senialTonGrabadaDir
        senialGrabadaTono
        senialTonVentDirect
        senialIRDirect
        senialIRVentanDirect
        senialIR
        senialIRModificada
        senialIRVentaneada
        senialIRExtendida
        potenciadB
        potenciaTonoDirdB
        potenciadBInterp
        potenciaTonodB
        datos
        tipoExcitacion
        tipoVentana
        ventana
        inicioVentana
        finVentana
        vectorFrecuencias
        octavas
        gradoFft
        rangoFrecuencias
        resolucionDirectividad
        anguloInicial
        anguloFinal  
        ordenFiltro
        theta
        thetaInterp
        rho
        frec
        numeroEnsayosDirect  
        giroCompleto
        parametros
        anguloCobertura   
        factorQ           
        indiceDirectividad
        input
        output
        guardaIR
        directorioGuardar
        nBits
    end
    
    methods
        function obj = modelo()
            obj.reset();
        end
                
        function reset(obj)
            obj.density = 0;
            obj.volume = 0;
            obj.units = 'english';
            obj.mass = 0;
        end
        
        function setDensity(obj,density)
            obj.density = density;
        end
        
        function setVolume(obj,volume)
            obj.volume = volume;
        end
        
        function setUnits(obj,units)
            obj.units = units;
        end
        
        function result = get.samplingRate(this)
            result = this.mSamplingRate;
        end
        
        function set.samplingRate(this,value)
            if isscalar(value)
                this.mSamplingRate = value;
            else
                error('%s.set.samplingRate  samplingRate must be a scalar value',mfilename);
            end
        end
        
        function result = get.gradoFft(this)
            result = this.mGradoFft;
        end
        
        function set.gradoFft(this,value)
                this.mGradoFft =value;
        end
        
        function result = get.inicioVentana(this)
            result = this.mInicioVentana;
        end
        
        function set.inicioVentana(this,value)
                this.mInicioVentana =value;
        end
        
        function result = get.finVentana(this)
            result = this.mFinVentana;
        end
        
        function set.finVentana(this,value)
                this.mFinVentana =value;
        end
        
        function result = get.senialExcitacion(this)
            result = this.mSenialExcitacion;
        end
        
        function set.senialExcitacion(this,value)
           % if isa(value,'samdirAudio')
          
                this.mSenialExcitacion = value;
        %    else
        %        error('%s.set.senialExcitacion La señal de excitacion debe ser del tipo samdirAudio',mfilename);
         %   end
        end
        
        function result = get.senialGrabada(this)
            result = this.mSenialGrabada;
        end
        
        function set.senialGrabada(this,value)
           % if isa(value,'samdirAudio')
          
                this.mSenialGrabada = value;
        %    else
        %        error('%s.set.senialExcitacion La señal de excitacion debe ser del tipo samdirAudio',mfilename);
         %   end
        end
        function result = get.senialGrabadaDirect(this)
            result = this.mSenialGrabadaDirect;
        end
        
        function set.senialGrabadaDirect(this,value)
              this.mSenialGrabadaDirect = value;
        end
        
        function result = get.senialTonGrabadaDir(this)
            result = this.mSenialTonGrabadaDir;
        end
        
        function set.senialTonGrabadaDir(this,value)
              this.mSenialTonGrabadaDir = value;
        end
        
        function result = get.senialIRDirect(this)
            result = this.mSenialIRDirect;
        end
        
        function set.senialIRDirect(this,value)
              this.mSenialIRDirect = value;
        end
        function result = get.senialTonVentDirect(this)
            result = this.mSenialTonVentDirect;
        end
        
        function set.senialTonVentDirect(this,value)
              this.mSenialTonVentDirect = value;
        end
        
        function result = get.senialGrabadaTono(this)
            result = this.mSenialGrabadaTono;
        end
        
        function set.senialGrabadaTono(this,value)
           % if isa(value,'samdirAudio')
          
                this.mSenialGrabadaTono = value;
        %    else
        %        error('%s.set.senialExcitacion La señal de excitacion debe ser del tipo samdirAudio',mfilename);
         %   end
        end
        
        function result = get.senialExcitacionTono(this)
            result = this.mSenialExcitacionTono;
        end
        
        function set.senialExcitacionTono(this,value)
               this.mSenialExcitacionTono = value;
        end
        
        function result = get.senialIR(this)
            result = this.mSenialIR;
        end
        
        function set.senialIR(this,value)
               this.mSenialIR = value;
        end
        
        function result = get.senialIRModificada(this)
            result = this.mSenialIRModificada;
        end
        
        function set.senialIRModificada(this,value)
               this.mSenialIRModificada = value;
        end
        
        function result = get.senialIRVentaneada(this)
            result = this.mSenialIRVentaneada;
        end
        
        function set.senialIRVentaneada(this,value)
               this.mSenialIRVentaneada = value;
        end
        
        function result = get.senialIRExtendida(this)
            result = this.mSenialIRExtendida;
        end
        
        function set.senialIRExtendida(this,value)
               this.mSenialIRExtendida = value;
        end
        
        function result = get.ventana(this)
            result = this.mVentana;
        end
        
        function set.ventana(this,value)
               this.mVentana = value;
        end
        
        function result = get.datos(this)
            result = this.mDatos;
        end
        
        function set.datos(this,value)
               this.mDatos = value;
        end        
        
        function result = get.potenciaTonodB(this)
            result = this.mPotenciaTonodB;
        end
        
        function set.potenciaTonodB(this, value)
            this.mPotenciaTonodB = value;
        end
        
        function result = get.potenciaTonoDirdB(this)
            result = this.mPotenciaTonoDirdB;
        end
        
        function set.potenciaTonoDirdB(this, value)
            this.mPotenciaTonoDirdB = value;
        end
        
        function result = get.input(this)
            result = this.mInput;
        end
        
        function set.input(this, value)
            this.mInput = value;
        end
        
        function result = get.output(this)
            result = this.mOutput;
        end
        
        function set.output(this, value)
            this.mOutput = value;
        end
        
        function result = get.tipoExcitacion(this)
            
            switch (this.mTipoExcitacion)
             case {'Barrido Senoidal Lineal'}
                    tipoExcitacion = 'linsweep';
             case {'Barrido Senoidal Logarítmico'}
                    tipoExcitacion = 'expsweep';
             case {'Tono Senoidal'}
                    tipoExcitacion = 'sine';
             case {'Tono Cosenoidal'}
                    tipoExcitacion = 'cosine';
            end
         result = tipoExcitacion;
        end
        
        function set.tipoExcitacion(this,value)
                this.mTipoExcitacion =value;
        end
        
        function escucharExcitacionSweep(this)
            this.mSenialExcitacion.play;
        end
        
        function escucharExcitacionTono(this)
            this.mSenialExcitacionTono(6).play;
        end
        
        function verExcitacionSweep(this)
            this.mSenialExcitacion.plot;
        end
        
        function verExcitacionTono(this)
            for i=1:length(this.vectorFrecuencias),
                this.mSenialExcitacionTono(i).plot;  
            end 
        end
        
        function verGrabacionSweep(this)
            this.mSenialGrabada.plot;
        end
        function escucharGrabacionSweep(this)
            this.mSenialGrabada.play;
        end
        
        function escucharGrabacionTono(this)
            this.mSenialGrabada.play;
        end
        
        function result = get.tipoVentana(this)
            result = this.mTipoVentana;
        end
        
        function set.tipoVentana(this,value)
                this.mTipoVentana =value;
        end
        
        function result = get.vectorFrecuencias(this)
            result = this.mVectorFrecuencias;
        end
        
        function result = get.octavas(this)
           
            result = this.mBandasOctava;
        end
        
        function set.octavas(this, value)
           
            if(strcmp(value, '1/1 Octava'))
               this.mBandasOctava = 1;
               this.mVectorFrecuencias = [31.5,63,125,250,500,1000,2000,4000,8000,16000];
            elseif (strcmp(value, '1/3 Octava'))
               this.mBandasOctava = 3;
               this.mVectorFrecuencias = [25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,...
                    800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000];
            else
                disp('Error')
            end
          
        end
        
       
        function result = get.amplitud(this)
            result = this.mAmplitud;
        end
        function set.amplitud(this, value)
            
                this.mAmplitud = value;
            
        end
        
        function result = get.resolucionDirectividad(this)
            result = this.mResolucionDirectiv;
        end
        function set.resolucionDirectividad(this, value)
            this.mResolucionDirectiv = value;
        end
        function result = get.senialIRVentanDirect(this)
            result = this.mSenialIRVentanDirect;
        end
        function set.senialIRVentanDirect(this, value)
            this.mSenialIRVentanDirect = value;
        end
        
        function result = get.anguloInicial(this)
            result = this.mAnguloInicial;
        end
        function set.anguloInicial(this, value)
            this.mAnguloInicial = value;
        end
        function result = get.anguloFinal(this)
            result = this.mAnguloFinal;
        end
        function set.anguloFinal  (this, value)
            this.mAnguloFinal = value;
        end
        function result = get.ordenFiltro(this)
            result = this.mOrdenFiltro;
        end
        function set.ordenFiltro  (this, value)
            this.mOrdenFiltro = value;
        end
        function result = get.theta(this)
            result = this.mTheta;
        end
        function set.theta  (this, value)
            this.mTheta = value;
        end
        function result = get.thetaInterp(this)
            result = this.mThetaInterp;
        end
        function set.thetaInterp  (this, value)
            this.mThetaInterp = value;
        end
        function result = get.rho(this)
            result = this.mRho;
        end
        function set.rho  (this, value)
            this.mRho = value;
        end
        function result = get.frec(this)
            result = this.mFrec;
        end
        function set.frec  (this, value)
            this.mFrec = value;
        end
        function result = get.numeroEnsayosDirect(this)
            result = this.mNumeroEnsayosDirect;
        end
        function set.numeroEnsayosDirect  (this, value)
            this.mNumeroEnsayosDirect = value;
        end
        function result = get.giroCompleto(this)
            result = this.mGiroCompleto;
        end
        function set.giroCompleto  (this, value)
            this.mGiroCompleto = value;
        end 
        
        function result = get.potenciadB(this)
            result = this.mPotenciadB;
        end
        
        function set.potenciadB(this, value)
            this.mPotenciadB = value;
        end
        
        function result = get.potenciadBInterp(this)
            result = this.mPotenciadBInterp;
        end
        
        function set.potenciadBInterp(this, value)
            this.mPotenciadBInterp = value;
        end
        
        function result = get.parametros(this)
            result = this.mParametros;
        end
        
        function set.parametros(this, value)
            this.mParametros = value;
        end
        
        function result = get.anguloCobertura(this)
            result = this.mAnguloCobertura;
        end
        
        function set.anguloCobertura(this, value)
            this.mAnguloCobertura = value;
        end
        
        function result = get.factorQ(this)
            result = this.mFactorQ;
        end
        
        function set.factorQ(this, value)
            this.mFactorQ = value;
        end
 
        function result = get.indiceDirectividad(this)
            result = this.mIndiceDirectividad;
        end
        
        function set.indiceDirectividad(this, value)
            this.mIndiceDirectividad = value;
        end                   
           
        function result = get.guardaIR(this)
            result = this.mGuardaIR;
        end
        
        function set.directorioGuardar(this, value)
            this.mDirectorioGuardar = value;
        end                   
           
        function result = get.directorioGuardar(this)
            result = this.mDirectorioGuardar;
        end
        
        function set.guardaIR(this, value)
            this.mGuardaIR = value;
        end 
        function result = get.nBits(this)
            result = this.mNBits;
        end
        
        function set.nBits(this, value)
            this.mNBits = value;
        end
        function senial = TipoSenial(this)
           switch (set_preferencias('tipo'))
               case {'Barrido Senoidal Lineal', 'Barrido Senoidal Logarítmico'}
                    senial = 'sweep';
               case {'Tono Senoidal', 'Tono Cosenoidal'}
                    senial = 'tonoPuro';
               otherwise
           end
           
        end
        
        function result = get.rangoFrecuencias(this)
            
            result = [set_preferencias('freqInicial') set_preferencias('freqFinal')];
        end
        
        function guardarConfiguracion(this )
            this.mAmplitud              = samdir_nivel(0);
            this.octavas                = set_preferencias('resolucionFiltro');
            this.samplingRate           = set_preferencias('samplingRate');
            this.gradoFft               = samdir_calculo_fftDegree(set_preferencias('samplingRate'), set_preferencias('duracion'));
            this.mTipoExcitacion        = set_preferencias('tipo');
            this.mTipoVentana           = set_preferencias('tipoVentana');
            this.mFinVentana            = set_preferencias('finVentana');
            this.mInicioVentana         = set_preferencias('inicioVentana');
            this.resolucionDirectividad = set_preferencias('resolucionDirectividad');
            this.anguloInicial          = set_preferencias('medicionInicial');
            this.anguloFinal            = set_preferencias('medicionFinal');
            this.ordenFiltro            = set_preferencias('ordenFiltro');
            this.input                  = set_preferencias('inputDeviceID');
            this.output                 = set_preferencias('outputDeviceID');
            this.guardaIR               = set_preferencias('guardarResultados');
            this.directorioGuardar      = set_preferencias('directorioResultados');
            this.nBits                  = set_preferencias('nBits');
        end
        function crearExcitacionSweep(this)
            
            a = samdir_generate(this.tipoExcitacion,this.rangoFrecuencias, this.samplingRate,this.gradoFft);
            this.senialExcitacion = samdir_ventaneo(this.tipoVentana, this.inicioVentana,this.finVentana,a);
            
        end
        function crearExcitacionTonoPuro(obj)
           
                tonos(length(obj.vectorFrecuencias)) = samdirAudio;
                for i=1:length(obj.vectorFrecuencias),
                    tonos(i)  = samdir_generate(obj.tipoExcitacion,obj.amplitud,obj.vectorFrecuencias(i),obj.samplingRate,obj.gradoFft);
                end 
                obj.senialExcitacionTono = tonos;
        end
        
        function medicionIR(this)
           switch (this.tipoExcitacion)
    
                case {'linsweep'} 
                    [this.senialIR this.senialGrabada] = samdir_medicion_ir_lineal(this.senialExcitacion, this.input, this.output);
                case {'expsweep'}
                    [this.senialIR this.senialGrabada] = samdir_medicion_ir_exponencial(this.senialExcitacion, this.input, this.output, this.rangoFrecuencias, this.samplingRate);                    
           end
        end
        
        function medicionIRTonos(this)

            this.senialGrabadaTono = samdir_medicion_ir_tonos(this.senialExcitacionTono, this.input, this.output);
            %pot(length(this.senialGrabadaTono)) = [];
            for i=1:length(this.senialGrabadaTono),
                pot(i)  = sum(this.senialGrabadaTono(i).timeData.^2)/length(this.senialGrabadaTono(i).timeData);
                this.potenciaTonodB(i) = db(pot(i),'power');
            end
            this.respuestaFrecuenciaTonoBoton();
        end
        function ventanaIR(this, tipo)
           if(strcmp(tipo, 'ir'))
               [this.senialIRModificada,this.ventana,this.datos]= samdir_ventaneo_ver(this.senialIR, 0.02,0.1,'hann',0.1,'hann',0.1, false);
           else
               if(strcmp(this.TipoSenial, 'sweep'))
                    [this.senialIRModificada,this.ventana,this.datos]= samdir_ventaneo_ver(this.senialIRDirect(1), 0.02,0.1,'hann',0.1,'hann',0.1, false);
               else
                    [this.senialIRModificada,this.ventana,this.datos]= samdir_ventaneo_ver(this.senialTonGrabadaDir(1,1), 0.02,0.1,'hann',0.1,'hann',0.1, false);
               end
           end
        end
        function ventanaIRVer(this, izq_rec,der_rec,tipo_1,izq,tipo_2,der, tipo)
            if(strcmp(tipo, 'ir'))
                [this.senialIRModificada,this.ventana,this.datos]= samdir_ventaneo_ver(this.senialIR,izq_rec,der_rec,tipo_1,izq,tipo_2,der, false);
            else
                if(strcmp(this.TipoSenial, 'sweep'))
                    [this.senialIRModificada,this.ventana,this.datos]= samdir_ventaneo_ver(this.this.senialIRDirect(1),izq_rec,der_rec,tipo_1,izq,tipo_2,der, false);
                else
                    [this.senialIRModificada,this.ventana,this.datos]= samdir_ventaneo_ver(this.this.senialTonGrabadaDir(1,1),izq_rec,der_rec,tipo_1,izq,tipo_2,der, false);
                end
            end
        end
        function ventanaIRLupa(this)
            samdir_gui_VerIRVentanaCallback(this.senialIRModificada, this.ventana)
        end
        function aplicarVentanaIR(this, tipo)
          
            if(strcmp(tipo, 'ir'))
            	this.senialIRVentaneada = samdir_ventaneo_aplicar(this.senialIRModificada,this.ventana,this.datos);
            else
                if(strcmp(this.TipoSenial, 'sweep'))
                    struct_ir_vent(this.numeroEnsayosDirect) = samdirAudio;
                    for i=1:this.numeroEnsayosDirect,
                        struct_ir_vent(i) = samdir_ventaneo_aplicar(this.senialIRDirect(i),this.ventana,this.datos);
                    end
                    this.senialIRVentanDirect = struct_ir_vent;
                else
                    struct_ir_vent(this.numeroEnsayosDirect,length(this.senialExcitacionTono)) = samdirAudio;
                    for i=1:this.numeroEnsayosDirect,
                        for j=1:length(this.senialExcitacionTono),
                            struct_ir_vent(i,j)    = samdir_ventaneo_aplicar(this.senialTonGrabadaDir(i,j),this.ventana,this.datos);
   
                        end
                    end
                    this.senialTonVentDirect = struct_ir_vent;
                end
            end
       
        end
        %Hacer que devuelva algun valor indicando que se pudo guardar bien
        function guardarIR(this)
            if(~isempty(this.senialIRExtendida))
                samdir_grabar_wav(this.senialIRExtendida, this.samplingRate, this.gradoFft);
            else
                samdir_grabar_wav(this.senialIRVentaneada, this.samplingRate, this.gradoFft);
            end
        end
        function verIR(this)
            if(~isempty(this.senialIRExtendida))
                this.senialIRExtendida.plot;
            else
                this.senialIRVentaneada.plot;
            end
        end
        function resolucion = resolucionFrecuencia(this, grado)
            resolucion = samdir_resol_frec(this.samplingRate,grado);
        end
        function resolucion = extenderIR(this, grado)

            if(~isempty(this.senialIRVentaneada))
               this.senialIRExtendida = samdir_extender(this.senialIRVentaneada,grado);
               resolucion = samdir_resol_frec(this.samplingRate,log2(this.senialIRExtendida.nSamples));
            else
               resolucion = 0;
            end
        end
        function respuestaFrecuenciaSweepBoton(this)
            if(~isempty(this.senialIRExtendida))
                samdir_plot_freq(this.senialIRExtendida);
            else
                samdir_plot_freq(this.senialIRVentaneada);
            end
        end
        function energiaBoton(this)
            if(~isempty(this.senialIRExtendida))
                samdir_energia(this.senialIRExtendida);
            else
                samdir_energia(this.senialIRVentaneada);
            end
        end
        function respuestaFrecuenciaTonoBoton(this)
            samdir_resp_frec_tonos(this.potenciaTonodB, this.octavas);
        end
        function numeroDeEnsayos(this)
            [this.numeroEnsayosDirect,this.giroCompleto] = samdir_ensayos(this.resolucionDirectividad,this.anguloInicial, this.anguloFinal);
        end
        function medicionDirectividadSweep(this, pic)
     
            resp = 0;
            this.numeroDeEnsayos();
      
            struct_grab(this.numeroEnsayosDirect)    = samdirAudio;
            struct_grab(1) = samdir_reproduce_graba(this.senialExcitacion, this.input, this.output, this.samplingRate);
  %          samdir_comunicacion(pic, 'sentido', 0);
            for i=2:this.numeroEnsayosDirect,
        
                bandera = 1;
  %              samdir_pap(pic,this.resolucionDirectividad);
%                     while(bandera)
%                         resp = fscanf(pic,'%d',1);
%     
%                         if (resp == 3)
%     
%                             bandera = 0;
%                             resp=0;
%                         end
%                     end
%                % pause (8);   %15°
                %pause (4);   %5°
                pause(1);
                struct_grab(i) = samdir_reproduce_graba(this.senialExcitacion, this.input, this.output, this.samplingRate);

            end

 %           samdir_pap(pic,this.resolucionDirectividad);
            this.senialGrabadaDirect = struct_grab;
           
            if(this.guardaIR)
                filename = 'IR_';
                for i=1:this.numeroEnsayosDirect
                    wavwrite(struct_grab(i).timeData,this.samplingRate,this.nBits, strcat( this.directorioGuardar, '\',strcat(filename, num2str(i),'.wav')));
                end
            end
            fprintf('\nProcesamiento de las señales obtenidas.\n');
  %          samdir_comunicacion(pic, 'sentido', 1);
  %          samdir_pap(pic,360);
            struct_ir(this.numeroEnsayosDirect)      = samdirAudio;
            switch (this.tipoExcitacion)
                 case {'linsweep'} 
                    % Deconvoluciones
                    for i=1:this.numeroEnsayosDirect,
                        struct_ir(i) = samdir_division_FFT(this.senialGrabadaDirect(i),this.senialExcitacion);
                    end
                 case {'expsweep'}
                    % Creación del filtro inverso
                    inv     = samdir_inverso(this.senialExcitacion,this.rangoFrecuencias);
                    % Deconvoluciones
                    for i=1:this.numeroEnsayosDirect,
                        struct_ir(i) = samdir_deconv_lineal_FFT(this.senialGrabadaDirect(i),inv);
                    end
                otherwise
                     fprintf('\nError.\n');
            end
            this.senialIRDirect = struct_ir;
            
        end
          

        function medicionDirectividadSweepPotenciaxBandas(this)
            % Cálculo de potencia por bandas
            fprintf('\nCreación de los filtros.\n');
            % Creación de los filtros
         
            [filtros, frec_central] = samdir_banco_filtros(this.octavas,this.ordenFiltro);
            % Matrices que contendran el valor de potencia/banda de frecuencia
            pot     = zeros (this.numeroEnsayosDirect,length(frec_central));
            pot_db  = zeros (this.numeroEnsayosDirect,length(frec_central));
            fprintf('\nAplicación de los filtros.\n');
            % Filtrado y calculo de potencia por bandas de las IR
            for i=1:this.numeroEnsayosDirect,
                [pot_db(i,:)]= samdir_potencia_bandas_2(filtros, this.senialIRVentanDirect(i));
            end
            %Normalización
            [this.potenciadB,pot_db_ref]= samdir_normalizacion_directividad(pot_db,this.numeroEnsayosDirect,this.giroCompleto);
            
        end
        
        function medicionDirectividadTonoPotenciaxBandas(this)
            pot     = zeros (this.numeroEnsayosDirect,length(this.senialExcitacionTono));
            for i=1:this.numeroEnsayosDirect,
                for j=1:length(this.senialExcitacionTono),
                    pot(i,j)    = sum(this.senialTonGrabadaDir(i,j).timeData.^2)/length(this.senialTonGrabadaDir(i,j).timeData);
                    pot_db(i,j) = db(pot(i,j),'power');
                end
            end
            this.potenciaTonoDirdB = pot_db;

            %Normalización
            [this.potenciadB,pot_db_ref]= samdir_normalizacion_directividad(pot_db,this.numeroEnsayosDirect,this.giroCompleto);
        end

        function medicionDirectividadParametros(this)
            %% Cálculo de los parámetros de directividad
            for i=1:length(this.potenciadB(1,:)),
                [ang_cob(i),q(:,i),id(:,i)] = samdir_directividad_parametros(this.potenciadB(:,i),this.resolucionDirectividad);
            end
            this.anguloCobertura    = ang_cob;
            this.factorQ            = q;
            this.indiceDirectividad = id;
        end
        function medicionDirectividadSweepPlot(this)
            if(this.octavas == 1)
                [this.theta, this.frec] = samdir_plot_directividad(this.potenciadB,this.label_oct);
            else
                 [this.theta, this.frec] = samdir_plot_directividad(this.potenciadB,this.label_ter);
            end

%             limsmax = 0;
%             limsmin = 0;
%             for i=1:10
%                 lims = this.findscale(this.potenciadB(:,i), 10);
%                 if lims(2) > limsmax
%                     limsmax = lims(2);
%                 end
%                 if lims(3) < limsmin
%                     limsmin = lims(3);
%                 end
%             end
%             this.parametros = [limsmax limsmin 10];
        end
         
        function interpolacionDirectividad(this, tipoInterpolacion, index_selected)

            for i=1:length(this.vectorFrecuencias)
                [pot_int(:,i),this.thetaInterp] = samdir_directividad_interpolacion(this.potenciadB(:,i),this.theta,index_selected,tipoInterpolacion);
            end
            this.potenciadBInterp = pot_int;
        end
        function graficarIndiceDirectividad(this, frecuencia)
            samdir_plot_indice_dir(this.indiceDirectividad(:,frecuencia),this.theta);
        end
        function graficarFactorDirectividad(this, frecuencia)
            
            samdir_plot_factor_q(this.factorQ(:,frecuencia),this.theta);
        end
        function graficarDirectividadFreq(this)
            if(this.octavas == 1)
                
                samdir_plot_indice_frecuencia(this.indiceDirectividad(1,:),this.label_oct);
            else
                 
                 samdir_plot_indice_frecuencia(this.indiceDirectividad(1,:),this.label_ter);
            end
            
        end
        
        function lims = findscale(this, rho, rticks)
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
        
        function medicionDirectividadTonoPuro(this, pic)
            this.numeroDeEnsayos();
            struct_grab(this.numeroEnsayosDirect)    = samdirAudio;
%            samdir_comunicacion(pic, 'sentido', 0);
            for j=1:length(this.senialExcitacionTono),
                        struct_grab(1,j) = samdir_reproduce_graba(this.senialExcitacionTono(j), this.input, this.output, this.samplingRate);
            end
            for i=2:this.numeroEnsayosDirect,
                bandera = 1;
 %              samdir_pap(pic,this.resolucionDirectividad);
%               while(bandera)
%                    resp = fscanf(pic,'%d',1);
%                    if (resp == 3)
%                       bandera = 0;
%                       resp=0;
%                    end
%               end
                pause (1);
                for j=1:length(this.senialExcitacionTono),
                        struct_grab(i,j) = samdir_reproduce_graba(this.senialExcitacionTono(j), this.input, this.output, this.samplingRate);
                end
            end
%          samdir_comunicacion(pic, 'sentido', 1);
%          samdir_pap(pic,360);
           
           this.senialTonGrabadaDir = struct_grab;
           if(this.guardaIR)
                filename = 'IR_';
                for i=1:this.numeroEnsayosDirect
              %      wavwrite(struct_grab(i).timeData,this.samplingRate,this.nBits, strcat( this.directorioGuardar, '\',strcat(filename, num2str(i),'.wav')));
                end
            end
 
         end
    end

    
    methods (Static = true)
        function calculate()
                    %obj.mass = obj.density * obj.volume;
        end
        
        
      end
end