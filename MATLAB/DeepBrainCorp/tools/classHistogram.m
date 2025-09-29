classdef classHistogram
  
  methods (Static)
    
    function [histCount, histCent] = doHist1DLinSpaced(data,nBins)
      
      minV = min(data(:));   maxV = max(data(:));
      stepV = (maxV-minV)/(nBins);
      minV = minV+stepV/2;
      maxV = maxV-stepV/2;
      histCent = minV:stepV:maxV;
      for binIX=1:1:nBins
        histCount(binIX) = sum((data<(histCent(binIX)+stepV/2)) .* ...
                        (data>=(histCent(binIX)-stepV/2)));     
      end
      
    end %doHist1DLinSpaced
    
    %limits [init, end[   limist = [nBins x 2] matrix
    function [histCount, histCent] = doHist1DBounded(data,limits)
      nBins = length(limits);
      histCent = limits(:,1) + (limits(:,2)-limits(:,1))/2;
      histCount = zeros(nBins,1);
      
      for binIX=1:1:nBins
        histCount(binIX) = sum((data(:)<limits(binIX,2)) .* ...
                        (data(:)>=limits(binIX,1)));     
      end
    end
    
  end
  
  
end