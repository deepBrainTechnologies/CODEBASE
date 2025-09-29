%script_RUN_ionChan_Model2_Simulation

DO_X11_LAYER = false;
PLOT_X11_LAYER = false;

DO_SYSTEM_LAYER = false;
DO_XN2i_LAYER = false;

ANAL_XN2i_LAYER = true;

%____________________________________________________________________
%________________INPUT Xn11__________________________________________
if(DO_X11_LAYER)
  script_make_Xn11_input_signals_Paper2_Model2
  
end

if(PLOT_X11_LAYER)
  script_X11_analyse_simulations_Paper2_Model2
  script_X11_plot_results_analysis_Paper2_Model2
  script_PLOT___X11rasters_x11PDF_X11PSD_and_X11Entropy
end

%____________________________________________________________________
%_______________ SYSTEM DEFINITIONS _________________________________
if(DO_SYSTEM_LAYER)
  script_System_make_3Delay_Lines   
  %defines system with 3 lines (PDF delays and also fixed delays)
end

%____________________________________________________________________
%__________  calculate output from X11_input   ______________________
%_________ and System Definitions (Delay Lines) _____________________
if(DO_XN2i_LAYER)
  script_System_withDelaysPDFs_Calculate_Output_XN2i
end

if(ANAL_XN2i_LAYER)
    script_Calculate_Output_XN2i_PSD_and_Entropy
    %script_Calculate_Output_XN2i_JointPDF_and_JointEntropy
end

