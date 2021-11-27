function Data = Hash2Struct(hashMap)

% Set surface geometry
  Data = [];
  
  iterator = hashMap.keySet().iterator();
  while (iterator.hasNext())
     field = iterator.next();
     disp(field);
     if ~isempty(field)
        Data.(field) = hashMap.get(field);
     end
  end

  
  
