function indexes = tool_ReturnFoundElements(thisList, findThese)

  indexes = zeros(size(thisList));
  
  for ii=1:1:length(findThese)
    found = (thisList==findThese(ii));
    indexes(found) = 1;
  end

end