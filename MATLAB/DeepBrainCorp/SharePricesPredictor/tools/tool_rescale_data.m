%___________________________________________________________________
%
%   function dataRescaled= tool_rescale_data(data, minVal, maxVal)
%         rescaling for example between [0,1]
%___________________________________________________________________
function dataRescaled= tool_rescale_data(data)

  minData=min(data(:));
  maxData = max(data(:));

  dataRescaled = (data-minData)/(maxData-minData);
end