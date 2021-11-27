function main()
addpath([pwd '\Configuracion']);
addpath([pwd '\Preferencias']);

samdir_configuracion();
mymodel = modelo();
mycontroller = controlador(mymodel);