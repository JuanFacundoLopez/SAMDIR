function TriggerCallback(src, evt, app)
   
%%% Get action command string  
   % actionCommand = src.getActionCommand();
%%% Read in serialized hashmap
    hashMap = app.ReadObject();
    
%%% Convert hashmap to MATLAB structure     
    data = Hash2Struct(hashMap);    
    
    set_preferencias(data);
        
end