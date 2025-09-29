%__________________________________________________________________________
%
%  function data = load_weather_from_TXT_file_USA(filename)
%
%     ANTHONY BULL said i might be his baby ... honestly
%                  so i must try hard this job.
%                  because we really really do need this
%                  and leave :) together i said! i mean it!
%
%   data = zeros(nDates,7); %DATEasNUM OpenVal HighVal LowVal - - Volume
%__________________________________________________________________________
function [data, thisDate]= load_weather_from_TXT_file_USA(filename)

      fileID = fopen(filename,'r');
      C = textscan(fileID,'%s'); %date + 6 rows data

      %C = removeEmptyRowsText_1Column_String(C);

      nRows=10;
      nDates = floor(length(C{1})/nRows);
      C=C{1};

      data = zeros(nDates,7); %DATEasNUM OpenVal HighVal LowVal - - Volume

      for count=1:1:nDates
          thisDate{count} = C{(count-1)*nRows+1}
          data(count,1) = datenum(thisDate{count});
          for ii=2:9
            data(count,ii) = str2double(strrep(C{(count-1)*nRows+ii},',','.'));
          end
      end    



end