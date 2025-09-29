%__________________________________________________________________________
% function  mixGauss_signals , tVect]
%                     = generate_each_signal_mixgauss_NCMU_Req_1(Ntriggers)
%
%   returns:
%       mixGauss_signals = [Ntrigers x Nsamples]  1 for each trigger
%       tVect            = [Nsamples]
%
%  generates for a list of triggers a mixgauss predefined
%  to satisfy NCMU_Req_1 (see refs) for the FIRST STAGE of the system
%
%  next versions including realistic ion channel models/aproximations
%  would modify these templates for system/model for each "trigger" or
%  signal generated (that would make the entire machinery to respond)
%   %this part to be defined by Paul.
%__________________________________________________________________________
function [mixGauss_signals, tVect] = ...
                       generate_each_signal_mixgauss_NCMU_Req_1(Ntriggers)

  % 5 common stereotypical mixgauss signals seen at this level:
  % =mu ~s  , =mu =!s , ~mu =s , ~mu ~s , =mu =s
  MUs = [ 1   1   1   1    1;    1    1   1.2  0.8   1];  
  stds =[0.1 0.1 0.1 0.1  0.1; 0.15  0.3  0.1  0.15  0.1];
  dT=0.005;
  tVect = 0:dT:(3-dT); %ms
  mixGauss_signals = zeros(Ntriggers,length(tVect));
  for i=1:1:Ntriggers
    j=1+floor(rand()*5); %choose for each signal one of the "templates"
    
     [mixGauss_signals(i,:),xVect] =  ...
                      generate_sum_of_gaussians_1D(MUs(1,j), MUs(2,j), ...
                               stds(1,j), stds(2,j), 1, 1,...
                               tVect(1),tVect(end),tVect(2));
     
     mixGauss_signals(i,:) = mixGauss_signals(i,:)/max(max( mixGauss_signals(i,:)));                       
  end
end