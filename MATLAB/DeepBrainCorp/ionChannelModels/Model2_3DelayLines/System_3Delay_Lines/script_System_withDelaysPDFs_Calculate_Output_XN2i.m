%script_System_withDelaysPDFs_Calculate_Output_XN2i

OUTFOLDER = 'd:/SIMULATIONS_OUTPUT/PAPERS/Model2_3DelayLines_ionChans/';

X11FOLDERS = {'/X11_UNIFORM/', '/X11_EXPONENTIAL/', '/X11_GAUSSIAN/'};

SAVESYSFOLDER = [OUTFOLDER '/SYSDEFFOLDER/'];%folder with systems delays/gains

SAVESYSOUTPUTFOLDER = [OUTFOLDER '/SYSOUTFOLDER/']; %folder with system output
mkdir(SAVESYSOUTPUTFOLDER)


filename = [SAVESYSFOLDER '/simulationParameters_withPDFs.mat'];
load(filename,'nDelayComb','nGainComb','delay_param','delay_comb','gain_params',...
                      'delComb','gainComb','nStepsToSimPerCase','dtSimX11','dtSim');
                    
                    
                    
%for each PDF type of on X11FOLDERS  

for x11_type=1:1:length(X11FOLDERS)
  
  mkdir([SAVESYSOUTPUTFOLDER X11FOLDERS{x11_type}]); %mkdir outfolder XN2i
  
  IN_X11DIR = [OUTFOLDER X11FOLDERS{x11_type}]; %input X11 folders
  cd(IN_X11DIR);
  subfolders = dir;
  nFolders = length(subfolders);

  for folder = 3:1:nFolders  %X11_INPUT SUBFOLDERS
    subfoldername = subfolders(folder).name;
    cd(subfoldername);
    this_OUT_FOLDER = [SAVESYSOUTPUTFOLDER X11FOLDERS{x11_type} '/' subfoldername '/'];
    mkdir(this_OUT_FOLDER);
  
    X11data = load('X11_RSsignal_jitter_of_PDF.mat',...
    'pulsesJitteredTimes','X11_signalJitter_binary');
    X11_spks = round(X11data.pulsesJitteredTimes*(dtSimX11/dtSim)); %timestamp

    load([SAVESYSFOLDER '/simulationParameters_withPDFs.mat']);
    %for each file of combinations of delay/gains
    for delComb=1:1:nDelayComb   %parfor delComb=1:nDelayComb
      for gainComb=1:1:nGainComb
        filename = sprintf('%s/system_withPDFs_combination_%d_%d.mat',...
                          SAVESYSFOLDER,delComb, gainComb);
                        %for now replicating code for each PDF
        dataset=load(filename,'thisDELAYSunifPDF','thisDELAYSexponPDF','thisDELAYSgausPDF',...
                      'thisGAINS');
        
        nTrials = size(X11_spks,1); nSpks = size(X11_spks,2);
        X11_amp = ones(nTrials,nSpks);
        [outSpksSampIX_UNIF, outSpks_Amp_UNIF] = ...
                    classDelayLines.dynamicSys_inoutFunc(X11_spks,X11_amp,...
                                                  dataset.thisDELAYSunifPDF,dataset.thisGAINS);
                                                
        [outSpksSampIX_EXPON, outSpks_Amp_EXPON] = ...
                    classDelayLines.dynamicSys_inoutFunc(X11_spks,X11_amp,...
                                                  dataset.thisDELAYSexponPDF,dataset.thisGAINS);  
                                                
        [outSpksSampIX_GAUSS, outSpks_Amp_GAUSS]= ...
                    classDelayLines.dynamicSys_inoutFunc(X11_spks,X11_amp,...
                                                  dataset.thisDELAYSgausPDF,dataset.thisGAINS);
              
        filename = sprintf('%s/output_XN2i_delComb_%d_gainComb_%d.mat',...
                          this_OUT_FOLDER,...
                          delComb, gainComb);
        
        save(filename, 'outSpksSampIX_UNIF', 'outSpks_Amp_UNIF', ...
          'outSpksSampIX_EXPON', 'outSpks_Amp_EXPON',...
          'outSpksSampIX_GAUSS', 'outSpks_Amp_GAUSS','nStepsToSimPerCase',...
          'delComb','gainComb'); %[nTrials x nLines x nSimSteps] all variables
        
      end
    end
    
    cd('..');
  end%subfolder
    
end
    