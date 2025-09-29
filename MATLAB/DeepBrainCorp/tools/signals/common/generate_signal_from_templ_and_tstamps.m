%
% function Signal = ...
%    generate_signal_from_templ_and_tstamps(signals,trigger_list, SampRate)
% 
%   trigger_list = ms [1 x nTriggers] 
%   SampRate : en KHz.
%__________________________________________________________________________
function Signal = ...
    generate_signal_from_templ_and_tstamps(signals,trigger_list, SampRate)
  
  tMax = max(trigger_list); %ms
  nSampTempl = size(signals,2);
  nTriggers = size(trigger_list,2);
  dTsamp = 1/SampRate;  %ms
  lenSignal = ceil(tMax/dTsamp)+nSampTempl;
  Signal = zeros(1,lenSignal);
  for i=1:nTriggers
    index = ceil(trigger_list(i)/dTsamp);
    Signal(1,index:(index+nSampTempl-1)) = signals(i,:);
  end
  
  
end
