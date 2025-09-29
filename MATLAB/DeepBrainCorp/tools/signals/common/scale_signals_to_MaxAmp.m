%__________________________________________________________________________
% 
% function scaledSignals = ...
%          scale_signals_to_MaxAmp(signals, MaxAmps)
%
%  signals: [nSignals x nSamps]  normalized signals
%  MaxAmps: [nSignals]
%__________________________________________________________________________
function scaledSignals = ...
                  scale_signals_to_MaxAmp(signals, MaxAmps)
     
   nSamps = size(signals,2);             
   %normalize in case they are not normalized
   maxAmpSignals = max(signals,[],2);
   maxAmpSignals = repmat(maxAmpSignals(:),1,nSamps);
   signals = signals ./ maxAmpSignals;
   %scale          
   MaxAmps = repmat(MaxAmps(:),1,nSamps); 
   scaledSignals = signals .*MaxAmps;
                
                
end
 