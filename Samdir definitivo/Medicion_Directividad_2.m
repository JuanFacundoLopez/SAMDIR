%***************************************************************************************
%*   SISTEMA AUTOMÁTICO DE MEDICIÓN DE DIRECTIVIDAD DE TRANSDUCTORES ELECTROACÚSTICOS  * 
%***************************************************************************************
%* Nombre del Archivo:  Medicion_Directividad_2.m                                      *
%* Autores:             Morales, Juan Ignacio - Moreno, Ana María                      *
%*                      Proyecto Final de Grado                                        *
%*                      Ingeniería Electrónica - UTN-FRC - Argentina                   *
%* Entidad:             Centro de Investigación y Transferencia en Acústica (CINTRA)   *
%***************************************************************************************/
%% Ejemplo Medicion Directividad con tonos simples

% Variables para ser obtenidas de la GUI
frec_oct    = [31.5,63,125,250,500,1000,2000,4000,8000,16000];
frec_ter    = [20,25,31.5,40,50,63,80,100,125,160,200,250,315,400,500,630,...
800,1000,1250,1600,2000,2500,3150,4000,5000,6300,8000,10000,12500,16000,20000];
label_oct   = {'31.5','63','125','250','500','1k','2k','4k','8k','16k'};
label_ter   = {'25','31.5','40','50','63','80','100','125','160','200',...
'250','315','400','500','630','800','1k','1.25k','1.6k','2k',... 
'2.5k','3.15k','4k','5k','6.3k','8k','10k','12.5k','16k','20k'};

fs          = 48000;
fft_d       = 15;
nivel       = 0;
oct         = 1;

% Generación
amp = samdir_nivel(nivel);
if (oct==1)
    excitacion(10)    = samdirAudio;
    for i=1:10,
        excitacion(i)  = samdir_generate('sine',amp,frec_oct(i),fs,fft_d);
    end
else
    excitacion(31)    = samdirAudio;
    for i=1:31,
        excitacion(i)  = samdir_generate('sine',amp,frec_ter(i),fs,fft_d);
    end
end

[irs,pot_db]    = samdir_directividad(excitacion,0,360,90);

