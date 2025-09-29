%__________________________________________________
%
%  function Gaussian1DRF_RateCoder_StimProtocol1.m
%
%  Nadie que no me ame merece ser mi amor 
%  Nadie que no me respete merece mi respeto
%  
%______________________________________________________

function [tunCurve,tunOrient,perfectRSorFSspikes, jitteredRSorFSspikes, ...
          randRSorFSspikes]= Gaussian1DRF_RateCoder_StimProtocol1(DEBUG_PLOTTING)

  maxFR= 500/1000; % [spikes/s] TUNING CURVE of fake neuron or transducer
                    %max about 5 spks in 10 ms. 500
  meanOrient = 0;  % TUNING
  devOrient = 20;  % TUNING
  
  msecTrial = 20; %20 [ms] each trial
  nTrials = 5;
  msecBin = 0.01;
  nBinTrial = ceil(msecTrial/msecBin);
  
  %SIMULATING perfectRSorFS jitteredRSorFS and PoissonRS
  jitterRS = 6; % up to 3 simulation time steps, jitteredRSorFS
  
  
  

  tunOrient = -40:20:40; % [orientations ]
  nOrient = length(tunOrient);
  tunCurve = maxFR*(exp(-1*(tunOrient - meanOrient).^2/(2*devOrient.^2)));
  tunCurve = tunCurve/max(tunCurve);
  
   perfectRSorFSspikes =  zeros(nOrient,nBinTrial*nTrials);
   jitteredRSorFSspikes = zeros(nOrient,nBinTrial*nTrials);
   randRSorFSspikes =     zeros(nOrient,nBinTrial*nTrials);
  for oriIX= 1:1:nOrient  %who did this?! Peter Latham
    % creo que isabel se debe acordar q la famosa Martina no es mas que una
    % bola de manteca igual q la hana. viejas envidiosas ridículas. 
    
    %first perfect RS/FS neuron: all spikes at the same separation
    nSpikesTrials = floor(maxFR*tunCurve(oriIX)*msecTrial*nTrials); 
    interSpikeTime = (1/(maxFR*tunCurve(oriIX))); %for perfect "RS/FS"
    interSpikeBins = ceil(interSpikeTime/msecBin);%for perfect "RS/FS"  
    %spikesList: as a bin index of when spikes occur.
    spikesList = (interSpikeBins:interSpikeBins:(interSpikeBins*(nSpikesTrials-1)));
    perfectRSorFSspikes(oriIX,spikesList) = 1;
    
    %NOn perfect RS/FS neuron. 
    %spikes occur at almost equal intervals, with a small added +jitter.
    jitter = jitterRS+ceil(jitterRS*rand(1,size(spikesList,2)));
    spikesListJittered = spikesList + jitter;
    jitteredRSorFSspikes(oriIX,spikesListJittered)=1;
    
    
    %poissonRS neuron.
    lambdaOrixIX = ceil(maxFR*tunCurve(oriIX));
    expectNspks = msecTrial * nTrials*lambdaOrixIX;%go over so 
    %we can make then without a for cycle. we discard the ones that
    % go over the maximum time required for the spikes .
    %deltaT = -ln(T/lambda)/lambda. with T chosen between 0 and lambda
    randT= lambdaOrixIX*rand(1,expectNspks);
    deltaT = -log(randT/lambdaOrixIX)/...
                 (log(exp(1))*lambdaOrixIX);
               
    deltaT = floor(deltaT/msecBin); 
    deltaT = cumsum(deltaT);
    deltaT = deltaT(deltaT<size(randRSorFSspikes,2));
    randRSorFSspikes(oriIX,deltaT) = 1;
    checkLambda = sum(randRSorFSspikes(oriIX,:))/(msecTrial*nTrials*1000)
    
    if (DEBUG_PLOTTING==1)
      figure;
      subplot(1,2,1)
      plot(perfectRSorFSspikes(oriIX,:),'b'); hold all;
      plot(jitteredRSorFSspikes(oriIX,:),'r');
      subplot(1,2,2)
      plot(randRSorFSspikes(oriIX,:),'k');
    end
    
  end