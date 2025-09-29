%________________________________________________________________________
%     function func_DEEPBRAINIMAGING_CORE_start(settingsCORE)
%________________________________________________________________________
%
%   settingsCORE must be defined on the calling script
%   as a variable (the equivalent to a global variable in c/c++)
%         settingsCORE.baseSettingsDIR = 'full path to settings files'
%         settingsCORE.Nthreads = 7;   %number of threads in parallel
%
%________________________________________________________________________
function func_DEEPBRAINIMAGING_CORE_start(settingsCORE)
%THREADS
  % Rate1: 1s-5s, Rate2: Rate1*3, Rate3: Rate2*5, Rate4: Rate2*5 , etc
  % 
  % 1: online refresh at Rate1:  raw signal on electrodes, and filtered
  % 2: online refresh at Rate2:  timestamp APs, EAPheatmap, EAP-movie
  % 3: online refresh at Rate3:  neurons locations 2D, AP Clusters, raster
  % 4: online refresh at Rate4:  ACG, CCG (aimed at weak synaptic conn)
  % 5: online refresh at Rate5:  

  %add settings.baseSettingsDIR to path;
  path(path,settingsCORE.confSettingsDIR);
  
  % load settings for each thread (tasks or windows at different Refresh
  % Rate) and make func_CORE_RUN_Functions_Thread_i.m 
  %  to be executed per each thread (each thread has its own functions)
  for threadID=1:1:settingsCORE.Nthreads
    func_DEEPBRAINIMAGING_CORE_load_settings_Thread(threadID);
  end
  
  %start each thread foreeeveeer until ... stop.
  parfor threadID=1:1:settingsCORE.Nthreads
    func_DEEPBRAIN_IMAGING_CORE_Run_Thread(threadID)
  end
  
end %function


