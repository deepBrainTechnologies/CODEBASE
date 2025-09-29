%_________________________________________________________________________
%           classMatrixTools  (Static methods)
%
%   ColorMatIX = classMatrixTools.buildByType(combIX,ColorMat)
%           combIX = [nElements x 1]
%           ColorMat = [nMaxColors x 3]  example to fill RGB color index
%_________________________________________________________________________
classdef classMatrixTools
  
  
  methods (Static)
    
    function ColorMatIX = buildByType(combIX,ColorMat)
      assert(max(combIX) < size(ColorMat,1),'index greater than number of combinations/types');
      ColorMatIX = ColorMat(combIX,:); 
    end
  end
end
