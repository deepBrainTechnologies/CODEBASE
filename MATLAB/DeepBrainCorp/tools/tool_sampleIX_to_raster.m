%__________________________________________________________________________
%
%   function raster = tool_sampleIX_to_raster(samplesIDX,nSimSteps)
%
%     samplesIDX: [nTrials x nLines x maxNumSpksPerTrial]  
%                   nLines correspond to different configurations
%                   (nan) when no more spks on that trial
%                   faster than using {nTrials}[variable length]
%__________________________________________________________________________
function [raster, rasterAmp] = tool_sampleIX_to_raster(samplesIDX,ampIDXs, nSimSteps)

  nTrials = size(samplesIDX,1);
  nLines = size(samplesIDX,2);
  %assert((nSimSteps > (max(samplesIDX(:))+1)),'samplesIDX is step index, not time');
  raster = zeros(nSimSteps,nTrials,nLines);
  rasterAmp = zeros(nSimSteps,nTrials,nLines);
  %nSpks = size(samplesIDX,2);

  %samplesIDX = samplesIDX + repmat((0:nSimSteps:nSimSteps*(nTrials-1)),nSpks,1)';
  
  for trial =1:1:nTrials
    for lineIX=1:1:nLines
      idxs = samplesIDX(trial,lineIX,:);
      idxs = idxs(~isnan(idxs));  %different length on each trial %alternative 
      raster(cast(idxs,'uint32'),trial,lineIX) = 1;
      rasterAmp(cast(idxs,'uint32'),trial,lineIX) = ampIDXs(trial,lineIX,:); %amplitude of each sample, set on "raster"
    end
  end
  
  raster = permute(raster,[2 3 1]);
  rasterAmp = permute(rasterAmp,[2 3 1]);
  
end