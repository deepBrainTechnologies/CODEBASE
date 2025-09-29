%script_make_Xn11_input_signals_Paper2_Model2
%  saved to OUTFOLDER/(UNIFORM/EXPONENTIAL/GAUSSIAN)/
%   subfolder for each set of parameters relevant to PSD/PDF
%      subfolder: '/PARAMETERS_RT_period_%dus__maxJitter_%dsimsteps/'
%
% outfile on each subfolder
% X11_RSsignal_jitter_of_PDF.mat 
%                                file saved with simulation parameters
%                                and jitter times and RS pulses times.
%     
%________________________________________________________________________


%generate input signals  for Model 2 
%                       Model 2 Case 1:(3 lines of fixed delays)
%                       Model 2 Case 2:(3 lines of delays with PDF)
maxJittersFactors_List = [0.25 0.3 0.35 0.4];
RT_times_List = [0.8 1 1.2 1.4 1.6 2 2.2];

OUTFOLDER = 'd:/SIMULATIONS_OUTPUT/PAPERS/Model2_3DelayLines_ionChans/';
mkdir(OUTFOLDER);

for jittIX= 1:1:length(maxJittersFactors_List)
jittFact = maxJittersFactors_List(jittIX);
for rttimeIX = 1:1:length(RT_times_List)
rttimeThis = RT_times_List(rttimeIX);

StepsSim  = 2000;
nTrials   = 10;
dtSim     = 0.05; %us

% to feed Simulink (doing on simulink, to reinforce to Nature and
% other publishers that this is cant be meassured invivo, or invitro even)
signals = zeros(nTrials,StepsSim);

%----  define base times of Regular Delta times  ----
RT_period   = rttimeThis;               %us  time between pulses, regularly spaced
RT_steps    = RT_period/dtSim; %sim steps between pulses

%---  define (deltas) times  ---
nPulses       = floor(StepsSim/RT_steps)-2;
pulsesTimes    = RT_steps:RT_steps:(nPulses*RT_steps);
pulsesTimes    = repmat(pulsesTimes,nTrials,1);
nPulses       = size(pulsesTimes,2);                   %nPulses per trial
nPulsesTotal  = nPulses*nTrials;

%---  define Jitter Limits  ---
minJitter = 1;
maxJitter = floor(RT_steps*jittFact);

%-- generate Jitter for each nPulses ... jitter PDF: Uniform Distribution

%--------------------------------------------------------------------------
SUBFOLDER = '/X11_UNIFORM/';         
jitterValues = classRandomNumbersGenerator.uniform(false,...
                                      nPulsesTotal, minJitter, maxJitter);
jitterValues = round(jitterValues);

jitterValues = reshape(jitterValues,[nTrials nPulses]);
pulsesJitteredTimes = pulsesTimes + jitterValues;

X11_signalJitter_binary = signals;
for i=1:1:size(signals,1)
  X11_signalJitter_binary(i,cast(pulsesJitteredTimes(i,:),'uint32'))=1;
end

PDFtype = 'uniform';
DESTDIR = [OUTFOLDER '/' SUBFOLDER ];
mkdir(DESTDIR);
DESTDIR = sprintf('%s/PARAMETERS_RT_period_%1.1fus__maxJitter_%dsimsteps/',...
                  DESTDIR,RT_period,maxJitter);
                
mkdir(DESTDIR);
save([DESTDIR 'X11_RSsignal_jitter_of_PDF.mat' ],...
    'jitterValues','pulsesJitteredTimes','X11_signalJitter_binary',...
    'StepsSim', 'nTrials', 'dtSim','pulsesTimes','nPulses','RT_period',...
    'maxJitter','minJitter','PDFtype');
  
%for simulink.... to plot on our prototyping scenario  
simulink_X11_timeseries = [dtSim:dtSim:dtSim*size(X11_signalJitter_binary,2); X11_signalJitter_binary(1,:)];  
save(  [DESTDIR 'X11_simulink_signal.mat'],'simulink_X11_timeseries');

%--------------------------------------------------------------------------
SUBFOLDER = '/X11_EXPONENTIAL/';                                    
jitterValues = classRandomNumbersGenerator.exponential(false,...
                                      nPulsesTotal,maxJitter/3);
jitterValues = round(jitterValues);

jitterValues = reshape(jitterValues,[nTrials nPulses]);
pulsesJitteredTimes = pulsesTimes + jitterValues;

X11_signalJitter_binary = signals;
for i=1:1:nTrials
  X11_signalJitter_binary(i,cast(pulsesJitteredTimes(i,:),'uint32'))=1;
end

PDFtype = 'exponential';
DESTDIR = [OUTFOLDER '/' SUBFOLDER ];
mkdir(DESTDIR);
DESTDIR = sprintf('%s/PARAMETERS_RT_period_%1.1fus__maxJitter_%dsimsteps/',...
                  DESTDIR,RT_period,maxJitter);
mkdir(DESTDIR);
save([DESTDIR 'X11_RSsignal_jitter_of_PDF.mat' ],...
    'jitterValues','pulsesJitteredTimes','X11_signalJitter_binary',...
    'StepsSim', 'nTrials', 'dtSim','pulsesTimes','nPulses','RT_period',...
    'maxJitter','minJitter','PDFtype');

%--------------------------------------------------------------------------
SUBFOLDER = '/X11_GAUSSIAN/';        
mu_Jitter = 0;
sigma_Jitter = (maxJitter);
jitterValues = classRandomNumbersGenerator.gaussian(false,nPulsesTotal, ...
                                                mu_Jitter,sigma_Jitter);
jitterValues = round(jitterValues);

jitterValues = reshape(jitterValues,[nTrials nPulses]);
pulsesJitteredTimes = pulsesTimes + jitterValues;

%pulsesJitteredTimes = reshape(pulsesJitteredTimes,nTrials,nPulses);
X11_signalJitter_binary = signals;
for i=1:1:nTrials
  X11_signalJitter_binary(i,cast(pulsesJitteredTimes(i,:),'uint32'))=1;
end

PDFtype = 'gaussian';
DESTDIR = [OUTFOLDER '/' SUBFOLDER ];
mkdir(DESTDIR);
DESTDIR = sprintf('%s/PARAMETERS_RT_period_%1.1fus__maxJitter_%dsimsteps/',...
                  DESTDIR,RT_period,maxJitter);
mkdir(DESTDIR);
save([DESTDIR 'X11_RSsignal_jitter_of_PDF.mat' ],...
    'jitterValues','pulsesJitteredTimes','X11_signalJitter_binary',...
    'StepsSim', 'nTrials', 'dtSim','pulsesTimes','nPulses','RT_period',...
    'maxJitter','minJitter','PDFtype');


end
end

