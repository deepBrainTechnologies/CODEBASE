%________________________________________________________________
%  script_System_make_3Delay_Lines
%
%
%________________________________________________________________
OUTFOLDER = 'd:/SIMULATIONS_OUTPUT/PAPERS/Model2_3DelayLines_ionChans/';
SYSDEFFOLDER = 'SYSDEFFOLDER/';
SAVEFOLDER = [OUTFOLDER SYSDEFFOLDER];
mkdir(SAVEFOLDER);

dtSimX11     = 0.05; %us
upSample= 10;
dtSim = dtSimX11/upSample;
nStepsToSimPerCase = 2000*upSample;  %GET FROM SIMULATED X11. AND SETTINGS


%run each simulation to generate Delay Lines ... 
%fixed delays 
script_System_make_3Delay_Lines_With_fixedDelays;
%3 delay lines, each with the same Delay Distribution (PDF)
script_System_make_3Delay_Lines_With_DelayPDFs;



    
    
    
   
    
  
  
  
  

