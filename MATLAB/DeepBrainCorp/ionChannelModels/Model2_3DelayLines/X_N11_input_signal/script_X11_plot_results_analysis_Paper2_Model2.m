% __________________________________________________________________
%   script_X11_plot_results_analysis_Paper2_Model2
%___________________________________________________________________

PLOT_DEBUG = true;

INFOLDER = 'd:/SIMULATIONS_OUTPUT/PAPERS/Model2_3DelayLines_ionChans/';
SUBFOLDERS = {'/X11_UNIFORM/','/X11_EXPONENTIAL/','/X11_GAUSSIAN/'};

Entropy_ALL = [];RT_period_ALL=[]; maxJitter_ALL=[];

for pdf_folder=1:1:length(SUBFOLDERS)
  
  SIMFOLDER = [INFOLDER '/' SUBFOLDERS{pdf_folder}];
  cd(SIMFOLDER);
  subfolders = ls; % from 3erd to end
  nFolders = size(subfolders,1);

  for folder = 3:1:nFolders
    cd(subfolders(folder,:));
  
    load('X11_RSsignal_jitter_of_PDF.mat');
   
    %plot(Fvector,PSD_x11(trial,:)); hold all;
      
    load('X11_PSD_Entropy_Results.mat','Entropy_x11','PSD_x11','Fvector');  
    Entropy_ALL = [Entropy_ALL Entropy_x11'];
    RT_period_ALL = [RT_period_ALL RT_period*ones(1,nTrials)];
    maxJitter_ALL = [maxJitter_ALL maxJitter*ones(1,nTrials)];
    
    cd('..')
  end %for each parameter combination folder
  
  cd('..')
end %for each PDF folder



fig1 = figure;
plot3(Entropy_ALL, maxJitter_ALL, RT_period_ALL,'.k','markersize',10); 
grid on;xlabel('entropy'); ylabel('maxJitter [steps]'); ...
zlabel('RT period [us]');
        set(gca, 'LineWidth', 2);
        set(gca, 'FontSize', 12);

saveas(fig1,[INFOLDER '/figure_paper_X11_Entropy_vs_RTperiod_MaxJitter_ALLsims.png']);

close all;
fig1 = figure;
plot(Entropy_ALL, maxJitter_ALL,'.k','markersize',10); 
grid on;xlabel('Entropy'); ylabel('maxJitter [steps]'); 
        set(gca, 'LineWidth', 2);
        set(gca, 'FontSize', 12);

saveas(fig1,[INFOLDER '/figure_paper_X11_Entropy_vs_MaxJitter_ALLsims.png']);


close all;
fig1 = figure;
plot(Entropy_ALL, RT_period_ALL,'.k','markersize',10); 
grid on;xlabel('Entropy'); ylabel('RT period [us]'); 
        set(gca, 'LineWidth', 2);
        set(gca, 'FontSize', 12);

saveas(fig1,[INFOLDER '/figure_paper_X11_Entropy_vs_RTperiod_ALLsims.png']);

