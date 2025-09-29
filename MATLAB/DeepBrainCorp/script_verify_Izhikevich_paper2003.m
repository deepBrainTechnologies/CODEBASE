%script_verify_Izhikevich_paper2003.m

Imax=10;
tStep = 0.01; %ms
lenPulse = 100; %ms
Iinput = [zeros(1,500) Imax*ones(1,round(lenPulse/tStep)) zeros(1,500)];
lenSim = length(Iinput);
timeSim = [1:1:lenSim]*tStep;

neurons_Type =1; %RS -------
[allV, allU, fire] = ...
                run_izhikevich_withStdPars_on_NW(1,neurons_Type, Iinput);
              
  figure;
  plot(timeSim, allV(1:1:end-1), '-b'); hold all;
  plot(timeSim, allU(1:1:end-1), '-r'); hold all;
  xlabel('Regular Spiking')
  firingRateRS = sum(fire)/(lenPulse/1000)
  
neurons_Type =2; %IB -------
[allV, allU, fire] = ...
                run_izhikevich_withStdPars_on_NW(1,neurons_Type, Iinput);
              
  figure;
  plot(timeSim, allV(1:1:end-1), '-b'); hold all;
  plot(timeSim, allU(1:1:end-1), '-r'); hold all;
  xlabel('Intrinsically Bursting')
  firingRateIB = sum(fire)/(lenPulse/1000)
  
neurons_Type =3; %CH -------
[allV, allU, fire] = ...
                run_izhikevich_withStdPars_on_NW(1,neurons_Type, Iinput);
              
  figure;
  plot(timeSim, allV(1:1:end-1), '-b'); hold all;
  plot(timeSim, allU(1:1:end-1), '-r'); hold all;
  xlabel('Chattering')
  firingRateCH = sum(fire)/(lenPulse/1000)
 
  
neurons_Type =4; %FS -------
[allV, allU, fire] = ...
                run_izhikevich_withStdPars_on_NW(1,neurons_Type, Iinput);
              
  figure;
  plot(timeSim, allV(1:1:end-1), '-b'); hold all;
  plot(timeSim, allU(1:1:end-1), '-r'); hold all;
  xlabel('Fast Spiking')
  firingRateFS = sum(fire)/(lenPulse/1000)
 
              