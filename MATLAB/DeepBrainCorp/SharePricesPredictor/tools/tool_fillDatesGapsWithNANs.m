%______________________________________________________________________________ 
%
% function dataSetFull = tool_fillDatesGapsWithNANs(dataSet, minDate,maxDate)
%
%   fills rows with nan on dates where no data is available.
%   dates in number format
%______________________________________________________________________________
function dataSetFull = tool_fillDatesGapsWithNANs(dataSet, minDate,maxDate)
  nRows = maxDate-minDate+1;
  nCols = size(dataSet,2);

  dataSetFull = zeros(nRows,nCols);
  for ii=1:1:nRows
    whichIX = find(dataSet(:,1)==(minDate+ii-1));
    if(whichIX>0)
      dataSetFull(ii,:) = dataSet(whichIX,:);
    else
      dataSetFull(ii,2:end) = nan*ones(1,nCols-1);
      dataSetFull(ii,1) = (minDate+ii-1);
    end
  end
  
  
end


