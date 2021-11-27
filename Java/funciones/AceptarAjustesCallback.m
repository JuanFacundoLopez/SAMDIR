function AceptarAjustesCallback(src, evt,hObject, handles)
   
 ventanaAjuste = handles.ventanaAjustes;
 hashMap = ventanaAjuste.ReadObject();
 data = Hash2Struct(hashMap);
 set_preferencias(data);
 ventanaAjuste.setVisible(0);

end