%________________________________________________________________
%
%       script_System_make_3Delay_Lines_With_fixedDelays
%________________________________________________________________

%just exploratory combinations to see the results
%three fixed delay/gain combinations:    ||   |     |||     |  ||   |  |  |
Fixed_Delays = round(dtSimX11*[0 0.05 0.1; 0 0.05 0.06; 0 0.11 0.12; 0 0.1 0.2]/dtSim);
%three types: 3 linear , 1 same, 3 powerlaw/exponential
Fixed_Gains = [1 0.5 0.45; 1 0.5 0.1; 1 0.95 0.9 ; 1 1 1; 1 0.9 0.5; 1 0.8 0.3; 1 0.8 0.1];

nDelComb = size(Fixed_Delays,1);
nGainComb = size(Fixed_Gains,1);

filename = [SAVEFOLDER '/simulationParameters_fixedLines.mat'];
  description= {{'Fixed_Delays: ||   |     |||     |  ||   |  |  |'} ...
                {'Fixed_Gains:  three types: 3 linear , 1 same, 3 powerlaw/exponential'}};
              
  save(filename,'nDelComb','nGainComb','description',...
                      'Fixed_Gains','Fixed_Delays',...
                      'nStepsToSimPerCase','dtSimX11','dtSim');



for delComb=1:1:nDelComb
  thisDELAYS = (Fixed_Delays(delComb,:))'; %[3(lines) x 1]
  thisDELAYS = repmat(thisDELAYS,1, nStepsToSimPerCase); %[3(lines) x nStepsSim]
  
  for gainComb=1:1:nGainComb
    thisGAINS = (Fixed_Gains(gainComb,:))';%[3(lines) x 1]
    thisGAINS = repmat(thisGAINS,1,nStepsToSimPerCase); %[3(lines) x nStepsSim]

    filename = sprintf('%s/system_fixed_combination_%d_%d.mat',...
                          SAVEFOLDER,delComb, gainComb);
                        
    save(filename,'thisDELAYS','thisGAINS','delComb','gainComb'); 
                    
  end
end
                    
                    
                    