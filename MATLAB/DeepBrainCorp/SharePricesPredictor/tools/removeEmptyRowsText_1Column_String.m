  function D = removeEmptyRowsText_1Column_String(C)
  
  
  nRows = length(C);
    index=1;
    for ii=1:1:nRows
      if(~strcmp(C{ii},''))
        D{index} = C{ii};
        index=index+1;
      end
    end
    
  
  
  
  
  end
  
  
  