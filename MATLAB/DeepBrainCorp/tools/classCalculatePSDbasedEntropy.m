%____________________________________________________________
%    classCalculatePSDbasedEntropy   (Static Methods)
%
%       [PSD, Entropy] = H_ofBinarySignal(in_signal, Fs)
%
%____________________________________________________________
classdef classCalculatePSDbasedEntropy
  
  methods (Static)
    
    function [PSD, Entropy, Fvector] = H_ofBinarySignal(in_signal, Fs)
      nTrials = size(in_signal,1);
      nLines = size(in_signal,2);
      nFreqs = 129; winSize=(nFreqs-1)*2;
      Fvector = (0:1:(nFreqs-1))*((Fs/2)/nFreqs);
      
      PSD = zeros(nTrials,nFreqs,nLines);
      Entropy = zeros(nTrials,nLines);
      
      for trial=1:1:nTrials
        for lineIX=1:1:nLines
          thisPSD = pwelch(squeeze(in_signal(trial,lineIX,:))',winSize);
          thisPSD = thisPSD/max(thisPSD); %normalize just if plotting here
          thisPSD = thisPSD/sum(thisPSD); %PSD as valid PDF.
        
          %calculating H(P_X11) from PSD
          Entropy(trial,lineIX) = sum(thisPSD.*log(1./thisPSD))/log(2);
          PSD(trial,:,lineIX) = thisPSD;
        end
      end
    end
    
    
    function [PSD, Entropy, Fvector] = H_ofJointBinarySignals(in_signals, Fs)
      nTrials = size(in_signals,1); %[nTrials x nLines x nSimSteps]
      nLines = size(in_signals,2);
      nFreqs = 129; winSize=(nFreqs-1)*2;
      Fvector = (0:1:(nFreqs-1))*((Fs/2)/nFreqs);
      
      %PSD = zeros(nTrials,nFreqs,nLines);
      Entropy = zeros(nTrials,1);
      
      for trial=1:1:nTrials
        
        L = length(in_signals);
        nFreqs = 129; winSize=nFreqs;%(nFreqs-1)*2;
        Fvector = (0:1:(nFreqs-1))*((Fs/2)/nFreqs);
        
        nWindows = floor(L/winSize);
        
        thisTrial = squeeze(in_signals(trial,:,:)); %to calculate PSD of joint X
        
        for winIX=1:1:nWindows
          thisWindow = thisTrial(:,(1+(winIX-1)*winSize):(winIX*winSize)); %[nLines x winSize]
          thisWindow = cat(1,thisWindow,zeros(nFreqs-nLines,winSize)); 
          autoCorr2D = xcorr2(thisWindow,thisWindow); %R_xx -> F{R_xx} = S_x
        
          Fourier2D_Rxx = fft2(autoCorr2D);

          PSD_2D_ofX = abs(fftshift(Fourier2D_Rxx)); 
           PSD_2D_ofX = 2*(PSD_2D_ofX(1:nLines,(nFreqs+1):end));
         
         PSD_2D_ofX = PSD_2D_ofX/sum(PSD_2D_ofX(:)); %PSD as valid P.D.F.
        
          PSD_trial(trial,:,:) = PSD_2D_ofX;
          
        end
        
        PSD(trial,:,:) = mean(PSD_trial,1);
        Entropy(trial) = sum(sum(squeeze(PSD(trial,:,:)).*log(1./squeeze(PSD(trial,:,:)))))/log(2);
        
       
      end %for each trial
    end
    
  end
  
end