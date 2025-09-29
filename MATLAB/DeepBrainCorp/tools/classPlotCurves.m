%
%   classPlotCurves: intended to compare signals/curves
%         under different combinations of conditions (combIX is = var or params)
%         and plot all together color coded according to combIX
%
%      classPlotCurves.plotTrials(outFileName,signals,xvect,combIX)
%             signals : [nTrials x nPoints]
%             xvect:     [nTrials x nPoints]   (xaxis might change on each trial)
%             comIX:       [nTrials x 1] or [1 x nTrials]
%
classdef classPlotCurves
  
  methods (Static)
    function figI = plotTrials(outFileName,signals,xvect,combIX, grayScale)
      nTrials = size(signals,1);
      upSamp = 100;
      combIX = repmat(combIX,1,size(signals,2)*upSamp);%[nTrials x nTotalSamples]
      combIX = combIX'; combIX = combIX(:);
      
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
      
      if(size(xvect,1)==1)
        xvect = repmat(xvect,nTrials,1);
      end
      
        %xaxis might change with trial (histograms, func evaluation, fitting)
        %signals [nTrials x nPoints]   xvect[nTrials x nPoints]
        for ii=1:1:size(signals,1)
          signalsLONG(ii,:) = interp(signals(ii,:),upSamp);
          xvectLONG(ii,:) = interp(xvect(ii,:),upSamp);
        end
        xvectLONG = xvectLONG'; signalsLONG = signalsLONG';
        
        scatter(xvectLONG(:),signalsLONG(:),50*ones(1,length(ColorMatIX)),ColorMatIX,'.','LineWidth',2); hold all;
              
        set(gca, 'LineWidth', 2);
        set(gca, 'FontSize', 12);
        
        axis auto;
%
      saveas(figI,outFileName);
      
    end
  
  end
  
end