%__________________________________________________________________________
%
%  function data = load_share_prices_from_TXT_file_yahooFormat(filename)
%
%     ANTHONY BULL said i might be his baby ... honestly
%                  so i must try hard this job.
%                  because we really really do need this
%                  and leave :) together i said! i mean it!
%
%   data = zeros(nDates,7); %DATEasNUM OpenVal HighVal LowVal - - Volume
%__________________________________________________________________________
function [data, thisDate]= load_share_prices_from_TXT_file_yahooFormat(filename)

      fileID = fopen(filename,'r');
      C = textscan(fileID,'%s'); %date + 6 rows data

      %C = removeEmptyRowsText_1Column_String(C);

      nRows=9;
      nDates = floor(length(C{1})/nRows);
      C=C{1};

      data = zeros(nDates,7); %DATEasNUM OpenVal HighVal LowVal - - Volume

      for count=1:1:nDates
          thisDate{count} = sprintf('%s%s%s',C{(count-1)*nRows+1},C{(count-1)*nRows+2},C{(count-1)*nRows+3});
          data(count,1) = datenum(thisDate{count});
          for ii=4:8  %share prices sometimes a , comes by mistake instead of .
            data(count,ii) = str2double(strrep(C{(count-1)*nRows+ii},',','')); %eliminate the thousands separator
          end
          for ii=9:9  %contador de acciones en miles
            data(count,ii) = str2double(strrep(C{(count-1)*nRows+ii},',','')); %eliminate the thousands separator
          end
      end    



end