%
%   classPlotScatter: intended to compare signals/curves
%         under different combinations of conditions (combIX is = var or params)
%         and plot all together color coded according to combIX
%
%      classPlotScatter.plotTrials(outFileName,signals,xvect,combIX)
%             signals : [nTrials x nPoints]
%             xvect:     [nTrials x nPoints]   (xaxis might change on each trial)
%             comIX:       [nTrials x 1] or [1 x nTrials]
%
classdef classPlotScatter
  
  methods (Static)
    function figI = plotTrials(outFileName,signals,xvect,combIX, grayScale,xxlabel,yylabel)
      %nPoints = size(signals,2);
      %combIX = repmat(combIX(:),1,nPoints);
      combIX = combIX'; combIX=combIX(:);
             % ixSet = 1+mod(combIX(:),7);%choose color instead of 'k'

      
      if(grayScale)
        ColorMat = [0 0 0; 51 51 51 ; 65 65 65; 86 86 86; 107 107 107; 129 129 129; ...
                   153 153 153; 180 180 180; 210 210 210]/255; %grayscale RGB
      else
         ColorMat = [255 102 0; 255 0 0; 0 255 0; 0 0 255; 0 204 255; ... &orange red green blue cyan
                     51 153 102; 0 0 128; 153 153 255; 255 0 255; ... %mint  navy lilac magenta
                     255 255 0; 0 0 0]/255; %yellow black
      end
      
      ColorMatIX = classMatrixTools.buildByType(combIX,ColorMat); %make combIX matrix of colours
      
      figI=figure('Visible','Off','WindowState','minimized');
      nRows = size(signals,1);
      minXX=min(xvect(:)); maxXX=max(xvect(:));
      minYY=min(signals(:)); maxYY=max(signals(:));
      
        xvect = xvect'; signals = signals';
        
        figure(figI);
        scatter(xvect(:),signals(:),...
            50*ones(1,length(ColorMatIX)),ColorMatIX,'o','LineWidth',1); hold all;
        
      
      figure(figI);
      set(gca, 'LineWidth', 2);
      set(gca, 'FontSize', 12);
%      axis([minXX maxXX minYY maxYY]);
      stepXX = (maxXX-minXX)/4; stepYY = (maxYY-minYY)/4;
%      xticks([minXX  minXX+stepXX*2 maxXX]); 
 %     yticks([minYY  minYY+stepYY*2 maxYY]);
        axis equal; axis square;
      xlabel(xxlabel); ylabel(yylabel);
%
      saveas(figI,outFileName);
    end
  
  end
  
end