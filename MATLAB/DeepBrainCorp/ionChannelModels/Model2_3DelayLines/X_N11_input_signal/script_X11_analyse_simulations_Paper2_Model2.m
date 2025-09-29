% __________________________________________________________________
%   script_X11_analyse_simulations_Paper2_Model2
%
%   calculate Entropy on X11 (binary input signal)
%     Entropy is calculated with P.S.D. based entropy
%___________________________________________________________________

PLOT_DEBUG = false;

INFOLDER = 'd:/SIMULATIONS_OUTPUT/PAPERS/Model2_3DelayLines_ionChans/';
SUBFOLDERS = {'/X11_UNIFORM/','/X11_EXPONENTIAL/','/X11_GAUSSIAN/'};

for pdf_folder=1:1:length(SUBFOLDERS)
  
  SIMFOLDER = [INFOLDER '/' SUBFOLDERS{pdf_folder}];
  cd(SIMFOLDER);
  subfolders = ls; % from 3erd to end
  nFolders = size(subfolders,1);

  for folder = 3:1:nFolders
    cd(subfolders(folder,:));
  
    load('X11_RSsignal_jitter_of_PDF.mat');
   
  
    if(PLOT_DEBUG)
      figure;
    end
    
      Fs = 1/dtSim;
      in_signal = permute(X11_signalJitter_binary,[1 3 2]); %[nTrial x 1 x nSimSteps]
      [PSD, Entropy, Fvector] = ...
        classCalculatePSDbasedEntropy.H_ofBinarySignal(in_signal, Fs);
      PSD_x11= permute(PSD,[1 3 2]); %[nTrials x nFreqs]
      Entropy_x11= permute(Entropy,[1 3 2]); %[nTrials x 1]
      
  if(PLOT_DEBUG)
  figure;
  plot(1:1:nTrials,Entropy_x11);
  end
  save('X11_PSD_Entropy_Results.mat','X11_signalJitter_binary','RT_period','jitterValues',...
          'Entropy_x11','PSD_x11','Fvector');
  
  cd('..');
  
  
  end %for each parameter combination folder
  
end %for each PDF folder