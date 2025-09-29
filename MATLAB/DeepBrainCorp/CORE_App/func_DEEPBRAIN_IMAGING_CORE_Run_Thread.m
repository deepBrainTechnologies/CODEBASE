%______________________________________________________________________
%
% function func_DEEPBRAIN_IMAGING_CORE_Run_Thread(threadID)
%______________________________________________________________________
%
%     %each Thread runs this same code.
%         while(settingsCORE.RUN)
%            - execute functions added to threadID on settings conf
%            - put threadID to sleep as set on settings (update rate)
%
%______________________________________________________________________
function func_DEEPBRAIN_IMAGING_CORE_Run_Thread(threadID)
 
    func_DEEPBRAIN_IMAGING_CORE_Configure_Thread(threadID);
    
    while(settingsCORE.RUN)
      %run each of the functions added to the execution
      %list of thread threadID
      eval(['func_CORE_RUN_FunctionsList_Thread_' threadID]);
      %put threadID to sleep according to period of update
      eval(['pause(settingsCORE.Thread_' threadID '.SleepT']);   
    end
    
end