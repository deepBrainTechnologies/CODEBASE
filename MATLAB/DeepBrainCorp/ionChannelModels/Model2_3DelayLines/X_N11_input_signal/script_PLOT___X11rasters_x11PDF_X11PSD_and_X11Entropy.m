% __________________________________________________________________
%   script_PLOT___X11rasters_x11PDF_X11PSD_and_X11Entropy
%___________________________________________________________________

PLOT_DEBUG = true;

INFOLDER = 'd:/SIMULATIONS_OUTPUT/PAPERS/Model2_3DelayLines_ionChans/';
SUBFOLDERS = {'/X11_UNIFORM/','/X11_EXPONENTIAL/','/X11_GAUSSIAN/'};
FIGURE_FOLDER = [INFOLDER '/FIGURES/'];
mkdir(FIGURE_FOLDER);

selected_combinations=[1 3 8 11 24 26];
nCombsToPlot = length(selected_combinations);

idPLOT=1;
for pdf_folder=1:1:length(SUBFOLDERS)
  %------------------------------------
  this_X11_PDF_FIGURE_FOLDER = [FIGURE_FOLDER '/' SUBFOLDERS{pdf_folder}];
  mkdir(this_X11_PDF_FIGURE_FOLDER);
  
  SIMFOLDER = [INFOLDER '/' SUBFOLDERS{pdf_folder}];
  cd(SIMFOLDER);
  subfolders = ls; % from 3erd to end
  nFolders = size(subfolders,1);
  exampID=0;
  for folderID = 1:1:nCombsToPlot
    exampID =exampID+1;
    %on each PDF distribution of jitter in the input signal
  combIX = [];
  X11_trials_examples_PLOT = []; %n trials per selected combination  
  PDF_jitters_PLOT = []; %n trials per selected combination
  PSD_trials_examples_PLOT = []; %n trials per selected combination
  Entropy_trials_examples_PLOT=[]; %n trials per selected combination
  
  
    folder = selected_combinations(folderID)+2;
    
    cd([SIMFOLDER '/' subfolders(folder,:)]);
  
    load('X11_RSsignal_jitter_of_PDF.mat');
    nFreqs = 129; Fs=1/dtSim; winSize=(nFreqs-1)*2;
    Fvector = (0:1:(nFreqs-1))*((Fs/2)/nFreqs);
    
    
    %trials for raster
    X11_trials = X11_signalJitter_binary;
    thisJitters = jitterValues;%reshape(jitterValues,[nTrials length(jitterValues)/nTrials]);

    X11_trials_examples_PLOT = cat(1,X11_trials_examples_PLOT,X11_trials);
    
    %PSD of rasters and Entropy from PSD
    jitter_For_Entropy_PLOT=[];Entropy_trials_examples_PLOT=[];
    PSD_trials_examples_PLOT=[]; PDF_jitters_PLOT=[];
    
    for trial=1:1:nTrials
      combIX = cat(1,combIX, folderID);
      
      [thisPSD, thisEntropy, Fvector] =classCalculatePSDbasedEntropy.H_ofBinarySignal(...
                                              permute(X11_trials(trial,:),[1 3 2]),1/dtSim);
      PSD_trials_examples_PLOT(trial,:) = thisPSD;

      Entropy_trials_examples_PLOT(trial,:) = thisEntropy;
      jitter_For_Entropy_PLOT(trial,:) = thisJitters(trial,:);
                        
                        
       [thisJitterPDF, jittXaxisPDF] = classHistogram.doHist1DLinSpaced(thisJitters(trial,:),20);
       thisJitterPDF(thisJitterPDF==0) = nan;
       PDF_jitters_PLOT(trial,:)= thisJitterPDF;
    end
    
    %mean PSD across trials
    PSD_trials_examples_PLOT = PSD_trials_examples_PLOT;
    %mean PDF across trials
    PDF_jitters_PLOT = max(abs(PDF_jitters_PLOT),1);
    
     outFile =sprintf('%s/X11_trials_raster_examples_PLOT%d.png',this_X11_PDF_FIGURE_FOLDER,exampID);
     figI = classPlotRaster.plotTrials(outFile,X11_trials,combIX,false);%combIX : color
     idPLOT=idPLOT+1;
    
    outFile = sprintf('%s/X11_trials_examples_PDF_of_jitters_PLOT%d.png',this_X11_PDF_FIGURE_FOLDER,exampID);
    classPlotCurves.plotTrials(outFile,PDF_jitters_PLOT,... %file, ydata
                                      repmat(jittXaxisPDF,size(PDF_jitters_PLOT,1),1),...%xdata
                                      combIX,false); %colorindex, grayscale)
    
    
     outFile = sprintf('%s/X11_trials_examples_PSDs_PLOT%d.png',this_X11_PDF_FIGURE_FOLDER,exampID);
     figI = classPlotCurves.plotTrials(outFile,PSD_trials_examples_PLOT,Fvector,combIX,false); %combIX: color
     idPLOT=idPLOT+1;
     
     outFile = sprintf('%s/X11_trials_examples_Entropy_vs_jitterX11_PLOT%d.png',this_X11_PDF_FIGURE_FOLDER,exampID);
     figI= classPlotScatter.plotTrials(outFile,Entropy_trials_examples_PLOT(:),max(jitter_For_Entropy_PLOT,[],2),combIX,false,'jitter X11','Entropy X11');%combIX     
     exampID = exampID+1;    
     idPLOT=idPLOT+1;
    
    cd('..')
  end %for each parameter combination folder, selected ones to plot FIG 1 & 2
  
close all;
% %   figI = figure;
% %   nPLOTS = length(idPLOT);
% %   plotted=1;
% %   
% %   for i=1:3:(nPLOTS/3)
% %     thisPLOT = imageread(outFile{i});
% %     suplot(nCombsToPlot,9,i);
% %     imagesc(thisPLOT);
% %     thisPLOT = imageread(outFile{i*2});
% %     suplot(nCombsToPlot,9,nCombsToPlot*3+i);
% %     imagesc(thisPLOT);
% %     thisPLOT = imageread(outFile{i*3});
% %     suplot(nCombsToPlot,9,nCombsToPlot*6+i);
% %     imagesc(thisPLOT);
% %   end

   
  
  
end %for each PDF folder


