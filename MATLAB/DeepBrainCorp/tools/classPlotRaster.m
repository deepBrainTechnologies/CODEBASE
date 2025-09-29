%
%      classPlotRaster.plotTrials(outFileName,binarydata,combIX)
%             binarydata : [nTrials x nSteps]
%             comIX:       [nTrials x 1] or [1 x nTrials]
%
classdef classPlotRaster
  
  methods (Static)
    function figI = plotTrials(outFileName,binarydata,combIX,grayScale)
      nSteps = size(binarydata,2);
      combIX = repmat(combIX',nSteps,1);
      combIX=combIX(:);
      
      if(grayScale)
        ColorMat = [0 0 0; 51 51 51 ; 65 65 65; 86 86 86; 107 107 107; 129 129 129; ...
                   153 153 153; 180 180 180; 210 210 210]/255; %grayscale RGB
      else
         ColorMat = [255 102 0; 255 0 0; 0 255 0; 0 0 255; 0 204 255; ... &orange red green blue cyan
                     51 153 102; 0 0 128; 153 153 255; 255 0 255; ... %mint  navy lilac magenta
                     255 255 0; 0 0 0]/255; %yellow black
      end
      
      ColorMatIX = classMatrixTools.buildByType(combIX,ColorMat); %make combIX matrix of colours
      
      figI=figure('Visible','Off');
      nTrials = size(binarydata,1);
      timeStamp = 1:1:size(binarydata,2);
      binarydata = binarydata.* repmat((1:1:nTrials)',1,nSteps);
   
        %%ixSet = 1+mod(combIX(trial),7);%choose color
        timeStamp = repmat(timeStamp',1,nTrials); %[nSteps x nTrials]
        binarydata = binarydata'; % [nSteps x nTrials]
        
        scatter(timeStamp(:),binarydata(:),...
            50*ones(1,length(ColorMatIX)),ColorMatIX,'|','LineWidth',1); hold all;
        
        
      figure(figI)
      set(gca, 'LineWidth', 2);
        set(gca, 'FontSize', 12);
        hold all;
        axis([0 max(timeStamp(:)) 0 (nTrials+1)]); grid on;
        yticks(0:1:(nTrials+1))
        yticklabels([])
        xticklabels([])
      saveas(figI,outFileName);
      
    end
  
  end
  
end