%________________________________________________________________
%
%       script_System_make_3Delay_Lines_With_DelayPDFs
%________________________________________________________________
%------------- make Delay and Gains with PDFS ----------------
pWidth = (dtSimX11/dtSim);
%0: uniform 1: exponential and 3: gaussian
%DO FOR EACH delay distribution

  delay_param = ...
      ([pWidth/100 pWidth/9; pWidth/9 pWidth/6; pWidth/6 pWidth/3 ]);
    
  delay_comb = [1 1 1; 1 2 3; 1 3 3; 3 3 3; 2 2 2; 1 1 3];%from which to pick
  %from the group [di1 di2 di3] which gain do we assign:
  gain_params = [1 1 1; 1 0.9 0.8; 1 0.8 0.5]; %=gain, linear gain, exp gain
  gain_params_label = [0 1 2]; %0: =gain 1:linear gain and 2:exponential gain
  
  
  nDelayComb= size(delay_comb,1);
  nGainComb= size(gain_params,1); % =size(gain_param_label,2)
  
  filename = [SAVEFOLDER '/simulationParameters_withPDFs.mat'];
  description= {{' delay_param: holds min and max of delay for delays PDFs \n'}
                {'delay_comb: holds the posible combinations of delays: |||  |  ||  ||  | \n'}
                {'gain_params: holds the gains defined as : same gain, linear decay and exponential decay on gain '}};
      
  save(filename,'nDelayComb','nGainComb','description',...
                      'delay_param','delay_comb','gain_params',...
                      'delComb','gainComb','nStepsToSimPerCase','dtSimX11','dtSim');
  
  for delComb=1:1:nDelayComb
    
    %random delays drawn for each step of simulation
    thisDELAYS = zeros(3, nStepsToSimPerCase);
    
    
    %  maxDelays: lambda/3 or sigma/3
    minDelays=delay_param(delay_comb(delComb,:),1); %minDel_x21  minDel_x22 mindel_x23
    maxDelays=delay_param(delay_comb(delComb,:),2); %maxDel_x21  maxDel_x22 maxDel_x23
    
    %uniform delays  ---
    thisDELAYSunifPDF(1,:)= classRandomNumbersGenerator.uniform(false,nStepsToSimPerCase,...
                                        minDelays(1),maxDelays(1)*3); %Xn21
    thisDELAYSunifPDF(2,:)= classRandomNumbersGenerator.uniform(false,nStepsToSimPerCase,...
                                        minDelays(2),maxDelays(2)*3); %Xn22
    thisDELAYSunifPDF(3,:)= classRandomNumbersGenerator.uniform(false,nStepsToSimPerCase,...
                                        minDelays(3),maxDelays(3)*3);  %Xn23                                 
    
    %exponeential delays   ---                                
    thisDELAYSexponPDF(1,:)= classRandomNumbersGenerator.exponential(false,nStepsToSimPerCase,...
                                        maxDelays(1)); %Xn21
    thisDELAYSexponPDf(2,:)= classRandomNumbersGenerator.exponential(false,nStepsToSimPerCase,...
                                        maxDelays(2)); %Xn22
    thisDELAYSexponPDF(3,:)= classRandomNumbersGenerator.exponential(false,nStepsToSimPerCase,...
                                        maxDelays(3));  %Xn23                                 
    
    %gaussian delays ---------------------------                                  
    thisDELAYSgausPDF(1,:)= classRandomNumbersGenerator.gaussian(false,nStepsToSimPerCase,...
                                        maxDelays(1),max([0.399 maxDelays(1)/3])); %Xn21
    thisDELAYSgausPDF(2,:)= classRandomNumbersGenerator.gaussian(false,nStepsToSimPerCase,...
                                        maxDelays(2),max([0.399 maxDelays(2)/3])); %Xn22
    thisDELAYSgausPDF(3,:)= classRandomNumbersGenerator.gaussian(false,nStepsToSimPerCase,...
                                        maxDelays(3),max([0.399 maxDelays(3)/3]));  %Xn23                                 
    
    for gainComb=1:1:nGainComb
      %same thisDELAYS  for each gainComb 
      %gain_params = (gains) [nComb x 3(X_N2i)]
      thisGAINS = gain_params(gainComb,:);  %[1 x 3(X_N2i)]
      thisGAINS = repmat(thisGAINS,nStepsToSimPerCase,1);
      thisGAINS = permute(thisGAINS,[2 1]); %[3 x nStepsSim]
     
      
      filename = sprintf('%s/system_withPDFs_combination_%d_%d.mat',...
                          SAVEFOLDER,delComb, gainComb);
                        
      save(filename,'thisDELAYSunifPDF','thisDELAYSexponPDF','thisDELAYSgausPDF',...
                      'thisGAINS','delComb','gainComb');               
    end
    
                                      
                                      
  end