%__________________________________________________________________________
%
% function trigger_list =
%                   generate_stim_trigger_list_NCMU_Req_1_a(Ntriggers,rate)
%
%   Ntriggers: number of triggers (signals) to generate
%   rate: in Hz
%   trigger_list :   ms [1xNtriggers] 
%
%   NCMU_Req_1:  for First Stage Input a list of triggers is to be 
%                used and on this first approach they ought to dont overlap. 
%                Later requirements to consider naturalistic design for
%                 ion channels, should include overlap. (Paul).
%
%     
%__________________________________________________________________________
function trigger_list = ...
                  generate_stim_trigger_list_NCMU_Req_1_a(Ntriggers,rate)

  dT_triggers = return_skewed_narrow_MaxValue(Ntriggers);
  
  deltaT = 1/rate*1000;
  assert(deltaT>5,'using on NCMU_Re1_1 non overlapping triggers timestamps');
  meanDelta = mean(dT_triggers); %10 by design. to scale/shift
  %not scaling time between triggers distribution. just shifting
  shiftT= meanDelta-deltaT;

  dT_triggers = dT_triggers-shiftT;
  
  trigger_list = cumsum(dT_triggers(:))';
  
  %plot(trigger_list,'.')
end