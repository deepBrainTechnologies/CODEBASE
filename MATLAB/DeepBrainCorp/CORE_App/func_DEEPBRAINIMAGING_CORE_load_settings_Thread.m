%______________________________________________________
%
%         function load_settings_Thread(threadID)
%
%______________________________________________________
function func_DEEPBRAINIMAGING_CORE_load_settings_Thread(threadID)


  % write functions calls to func_CORE_RUN_Functions_Thread_i.m
  Filename = [settingsCORE.confSettingsDIR '/' ...
                     'func_CORE_RUN_FunctionsList_Thread_' threadID '.m'];
                      
   %settingsCORE.Thread_i.displayHDEA. params                  
   %                     .EAP.         params
   %                     .SandC.       params
   %                     .classify.    params
  
   fileID = fopen(Filename,'w');
   thisline = '%______________________________________________ \n';
   fprintf(fileID,thisline);
   thisline = '%__________________  START ____________________ \n';
   fprintf(fileID,thisline);
   thisline = '                                               \n ';
   fprintf(fileID,thisline);
   
   varName = ['settingsCORE.Thread_' threadID];
      eval(['if(isfield(varName,''displayHDEA'')) ' ...
       ' thisline = ''func_DEEPBRAIN_IMAGING_MODULE_runTimeDisplayHDEA();''; ' ...
        ' fprintf(fileID,thisline); end' ]);
      
   varName = ['settingsCORE.Thread_' threadID];
      eval(['if(isfield(varName,''EAP'')) ' ...
       ' thisline = ''func_DEEPBRAIN_IMAGING_MODULE_runCalculateEAP();''; ' ...
        ' fprintf(fileID,thisline); end' ]);
      
    varName = ['settingsCORE.Thread_' threadID];
      eval(['if(isfield(varName,''SandC'')) ' ...
       ' thisline = ''func_DEEPBRAIN_IMAGING_MODULE_runCalculateSandC();''; ' ...
        ' fprintf(fileID,thisline); end' ]);  
      
    varName = ['settingsCORE.Thread_' threadID];
      eval(['if(isfield(varName,''classify'')) ' ...
       ' thisline = ''func_DEEPBRAIN_IMAGING_MODULE_runCalculateClassify();''; ' ...
        ' fprintf(fileID,thisline); end' ]);   
  
  
  
end