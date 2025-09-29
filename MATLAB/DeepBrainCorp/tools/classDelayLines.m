%__________________________________________________________________________
%     classDelayLines   STATIC METHODS
%
%      %the delay/gain can change at each simulation step.
%     [outSpksTime,outSpkAmp] = ...
%         classDelayLines.dynamicSys_inoutFunc(inTimeStamps, ampIn, Delays, Gains)
%
%        input variables :   timeStamps and ampIn:[nTrials x nSpks]  
%                            gain and Delays: [nLines x nSimSteps]
%        output:             outSpksTime,outSpkAmp: [nTrials x nLines x nSimSteps]
%__________________________________________________________________________
classdef classDelayLines
  
  methods (Static)
    
    %
    %   delayWithPDF_inoutFunc(inTimeStamps, Delays, Gains)
    %
    %       inTimeStamps:  sample index of each delta(t) input
    %
    function [outSpksTime,outSpkAmp] = dynamicSys_inoutFunc(inTimeStamps, ampIn, Delays, Gains)
      %using parfor in case inTimeStamps is used as [nTrials x nSpks]
      
      nSpks = size(inTimeStamps,2);
      nTrials = size(inTimeStamps,1);
      nLines =size(Delays,1);
      outSpksTime = zeros(nTrials,nLines,nSpks);
      outSpkAmp = zeros(nTrials,nLines,nSpks);
      
      
      assert((max(inTimeStamps(:))<size(Delays,2)),'SpksTimes exceeds number of simulated samples on Delay/Gain');
      assert((size(Delays,2)==size(Gains,2)),'Delays and Gains must be [nTrials x nSimTimeSteps]');
      
      for trial=1:1:nTrials  %move to linear indexing to remove forloop
        for lineIX=1:1:nLines
            outSpksTime(trial,lineIX,:)= inTimeStamps(trial,:)+Delays(lineIX,inTimeStamps(trial,:));
            outSpkAmp(trial,lineIX,:) = ampIn(trial,:).*Gains(lineIX,inTimeStamps(trial,:));
        end
      end
      
    end
    
  end
  
  
end