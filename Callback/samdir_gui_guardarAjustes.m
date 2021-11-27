function samdir_gui_guardarAjustes(ventanaAjuste)

 hashMap = ventanaAjuste.ReadObject();
 data = Hash2Struct(hashMap);
 set_preferencias(data);

end