%____________________________________________________________
%    classCalculatePDFbasedEntropy   (Static Methods)
%
%   [PDF, Entropy] = ...
%         classCalculatePDFbasedEntropy.H_ofJointBinarySignal_1BitLongWord(in_signal)
%
%
% [PDF, Entropy] = ...
%   classCalculatePDFbasedEntropy.H_ofJointBinarySignal_nBitLongWord(in_signal,Nbits)%
%____________________________________________________________
classdef classCalculatePDFbasedEntropy
  
  methods (Static)
    
    function [PDF, Entropy] = H_ofJointBinarySignal_1BitLongWord(	in_signal)
      nTrials = size(in_signal,1); %in_signal [nTrials x nLines x nSimSteps]
      nLines = size(in_signal,2);
      nSimSteps = size(in_signal,3);
      
      maxVal = (2^nLines-1); %(JointValue: 010 100 110 ... = 2 4 6 ... etc )
      PDF = zeros(nTrials,maxVal); %P.D.F. of binary word of 1 bit long
                                   %0 not included. no spiking activity
      
      %the histogram is calculated in base 10 word values, but is just for
      % simplicity of calculation. The Entropy is based on binary word.
      signalBase10 = zeros(nTrials,nSimSteps);
      for ii=1:1:(nLines)
          signalBase10 = signalBase10 + 2^(ii-1)*squeeze(in_signal(:,ii,:));
      end 
      
      limitsHist = 1:1:maxVal; 
      limitsInit = limitsHist'-0.5; limitsEnd = limitsHist'+0.5;
      limitsHist = [limitsInit limitsEnd];
      
      for trial=1:1:nTrials
        [thisPDF, centHist]= ...
          classHistogram.doHist1DBounded(signalBase10(trial,:),limitsHist);
        thisPDF= thisPDF/sum(thisPDF);
        PDF(trial,:) = thisPDF;
        Entropy(trial) = sum(thisPDF.*log(1./thisPDF))/log(2);
      end
      
      %PDF = mean(PDF,1);
      
      
      
    end
    
    
    function [PDF, Entropy] = H_ofJointBinarySignal_nBitLongWord(in_signal,Nbits)
      nTrials = size(in_signal,1); %in_signal [nTrials x nLines x nSimSteps]
      nLines = size(in_signal,2);
      maxVal = (2^(nLines*nBits)-1); 
      nSimSteps = size(in_signal,3);
      nWords = floor(nSimSteps/Nbits);
      %(JointValue2Bitslong: 010|000 100|101 110|100 ... = 16 29 ... etc )
      PDF = zeros(trials,maxVal+1); %P.D.F. of binary word of 1 bit long

      limitsHist = 0:1:maxVal; 
      limitsInit = limitsHist'-0.5; limitsEnd = limitsHist'+0.5;
      limitsHist = [limitsInit limitsEnd];
      
      for trial=1:1:nTrials
        
        thisTrial = squeeze(in_signal(trial,:,1:(Nbits*nWords))); %[nLines x nSimSteps]
        thisTrial = reshape(thisTrial,[nLines*Nbits nWords]);
      %the histogram is calculated in base 10 word values, but is just for
      % simplicity of calculation. The Entropy is based on binary word.
        signalBase10 = zeros(1,nWords);
        for ii=1:1:(nLines*Nbits)
          signalBase10 = signalBase10 + 2^(ii-1)*thisTrial(ii,:);
        end         
        
        [thisPDF, centHist]= ...
          classHistogram.doHist1DBounded(signalBase10,limitsHist);
        PDF(trial,:) = thisPDF;
      end
      
      PDF = mean(PDF,1);
      Entropy = sum(PDF*log(1./PDF))/log(2);
      
      
    end
    
    
    
    
  end %methods
  
end