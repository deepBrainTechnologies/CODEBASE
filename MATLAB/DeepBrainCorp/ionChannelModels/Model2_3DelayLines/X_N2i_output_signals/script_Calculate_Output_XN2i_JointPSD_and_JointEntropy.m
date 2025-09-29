%script_Calculate_Output_XN2i_JointPSD_and_JointEntropy

%NOT USING THIS SCRIPT. 

OUTFOLDER = 'd:/SIMULATIONS_OUTPUT/PAPERS/Model2_3DelayLines_ionChans/';

X11FOLDERS = {'/X11_UNIFORM/', '/X11_EXPONENTIAL/', '/X11_GAUSSIAN/'};

SAVESYSFOLDER = [OUTFOLDER '/SYSDEFFOLDER/'];%folder with systems delays/gains

SAVESYSOUTPUTFOLDER = [OUTFOLDER '/SYSOUTFOLDER/']; %folder with system output
mkdir(SAVESYSOUTPUTFOLDER)


filename = [SAVESYSFOLDER '/simulationParameters_withPDFs.mat'];
load(filename,'nDelayComb','nGainComb','delay_param','delay_comb','gain_params',...
                      'delComb','gainComb','nStepsToSimPerCase','dtSimX11','dtSim');
                    
PSD_ALL=[]; Entropy_ALL=[];
                    
%for each PDF type of on X11FOLDERS  

for x11_type=2:1:length(X11FOLDERS)
  
  mkdir([SAVESYSOUTPUTFOLDER X11FOLDERS{x11_type}]); %mkdir outfolder XN2i
  
  IN_X11DIR = [OUTFOLDER X11FOLDERS{x11_type}]; %input X11 folders
  cd(IN_X11DIR);
  subfolders = dir;
  nFolders = length(subfolders);

  figIentropyUNIFdelays = figure('Visible','off');
  figIentropyEXPONdelays = figure('Visible','off');
  figIentropyGAUSSdelays = figure('Visible','off');

  PSD_ALL=[]; Entropy_ALL_Unif=[];Entropy_X11_ALL =[];Entropy_ALL_Expon=[];
  Entropy_ALL_Gauss=[];
  
  for folder = 3:1:nFolders  %X11_INPUT SUBFOLDERS
    subfoldername = subfolders(folder).name;
    cd(subfoldername);
    this_OUT_FOLDER = [SAVESYSOUTPUTFOLDER X11FOLDERS{x11_type} '/' subfoldername '/'];
    mkdir(this_OUT_FOLDER);
    this_ANALYSIS_OUT = sprintf('%s/ANALYSIS/',this_OUT_FOLDER);
    mkdir(this_ANALYSIS_OUT);
  
    X11data = load('X11_RSsignal_jitter_of_PDF.mat',...
    'pulsesJitteredTimes','X11_signalJitter_binary');
    X11_spks = round(X11data.pulsesJitteredTimes*(dtSimX11/dtSim)); %timestamp

    %for each file of combinations of delay/gains
    for delComb=1:1:nDelayComb   %parfor delComb=1:nDelayComb
      for gainComb=1:1:nGainComb
        filename = sprintf('%s/output_XN2i_delComb_%d_gainComb_%d.mat',...
                          this_OUT_FOLDER,...
                          delComb, gainComb);
        
        load(filename, 'outSpksSampIX_UNIF', 'outSpks_Amp_UNIF', ...
          'outSpksSampIX_EXPON', 'outSpks_Amp_EXPON',...
          'outSpksSampIX_GAUSS', 'outSpks_Amp_GAUSS','nStepsToSimPerCase');
        
        %outSpksSampIX_UNIF is [nTrials x "nSpks"] 
        [raster, rasterSamples] = tool_sampleIX_to_raster(outSpksSampIX_UNIF,outSpks_Amp_UNIF,nStepsToSimPerCase);
        [PSD_Xn2i_Unif, Entropy_Xn2i_Unif, Fvector] =classCalculatePSDbasedEntropy.H_ofJointBinarySignals(rasterSamples,1/dtSim);
        

        [raster, rasterSamples] = tool_sampleIX_to_raster(outSpksSampIX_EXPON,outSpks_Amp_EXPON,nStepsToSimPerCase);
        [PSD_Xn2i_Expon, Entropy_Xn2i_Expon, Fvector] =classCalculatePSDbasedEntropy.H_ofJointBinarySignals(rasterSamples,1/dtSim);
        
        [raster, rasterSamples] = tool_sampleIX_to_raster(outSpksSampIX_GAUSS,outSpks_Amp_GAUSS,nStepsToSimPerCase);
        [PSD_Xn2i_Gauss, Entropy_Xn2i_Gauss, Fvector] =classCalculatePSDbasedEntropy.H_ofJointBinarySignals(rasterSamples,1/dtSim);
       
        
        
        %PSD: [nTrials x nLines x nFreqs]  Entropy: [nTrials x nLines]  Fvector: [nFreqs x 1]
        filename = sprintf('%s/output_XN2i_PSD_AND_ENTROPY_delComb_%d_gainComb_%d.mat',...
                          this_ANALYSIS_OUT,...
                          delComb, gainComb);
        
        save(filename,'PSD_Xn2i_Unif','Entropy_Xn2i_Unif','Fvector', ...  
        'PSD_Xn2i_Expon','Entropy_Xn2i_Expon','PSD_Xn2i_Gauss','Entropy_Xn2i_Gauss');  
        
        X11_analisis_file = [OUTFOLDER '/' X11FOLDERS{x11_type} ...
                                    '/' subfoldername '/X11_PSD_Entropy_Results.mat'];
        X11_results = load(X11_analisis_file,'Entropy_x11','PSD_x11','Fvector');
        
      
        Entropy_ALL_Unif = cat(1,Entropy_ALL_Unif,Entropy_Xn2i_Unif);
        Entropy_ALL_Expon = cat(1,Entropy_ALL_Expon,Entropy_Xn2i_Expon);
        Entropy_ALL_Gauss = cat(1,Entropy_ALL_Gauss,Entropy_Xn2i_Gauss);
        Entropy_X11_ALL = cat(1,Entropy_X11_ALL,repmat(X11_results.Entropy_x11(:),[3 1]));
        %%%PSD_ALL = cat(4,PSD_ALL,PSD);
      end
       delComb
    end
    
    
    cd('..');
    folder
  end%subfolder
  
  Xn2iFIGFOLDER = [OUTFOLDER '/FIGURES' '/OUT_XN2i/'];
  mkdir(Xn2iFIGFOLDER);
  Xn2iFIGFOLDER = [Xn2iFIGFOLDER '/' X11FOLDERS{x11_type}];
  mkdir(Xn2iFIGFOLDER);
  
  figure(figIentropyUNIFdelays);
  scatter(Entropy_X11_ALL,Entropy_ALL_Unif(:),'*k'); hold all;
  %saveas(figIentropyUNIFdelays, [Xn2iFIGFOLDER '/figure_X11UNIFjitter_vs_XN2i_Entropy_3lines.png']);

  figure(figIentropyEXPONdelays);
  scatter(Entropy_X11_ALL,Entropy_ALL_Expon(:),'*k'); hold all;
  %saveas(figIentropyEXPONdelays, [Xn2iFIGFOLDER '/figure_X11EXPONjitter_vs_XN2i_Entropy_3lines.png']);

  figure(figIentropyGAUSSdelays);
  scatter(Entropy_X11_ALL,Entropy_ALL_Gauss(:),'*k'); hold all;
  %saveas(figIentropyGAUSSdelays, [Xn2iFIGFOLDER '/figure_X11GAUSSjitter_vs_XN2i_Entropy_3lines.png']);

end
    