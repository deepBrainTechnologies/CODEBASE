%__________________________________________________________________________
%
% function create_3dneuronsignal_from_template
%                   (templates,xyz,nSegments,angNeurons,lenNeuron,lambdaD)
% templates: [nNeurons x nSamples]  use long template
% xyz:       [nNeurons 3] indicate start point of the "soma"
% nSegments: 
% angNeurons: [nNeurons x 1]
% lambdaD:    [nNeurons x 1]     
%
%__________________________________________________________________________
function create_3dneuronsignal_from_template ...
          (templates,xyz,angNeurons,lenNeuron,lambdaD)
  %-- for each neuron determine xyzl and template for each segment
  for i=1:1:nNeurons
    thisTemplate=templates(i,:);
    nSamples = size(templates,2);
    nSegments=0;
    %-- building xyz for each segment on the neuron i --
    for s=0:2:ceil(lenNeuron(i)/2) %using 2 um segment
      segXYZL = [(xyz(i,1:2) + [s*sin(angNeurons) ...
                               s*cos(angNeurons)]) xyz(i,3) s+2];
      nSegments=nSegments+1;
    end    %segXYZL = [ (nSegments*nNeurons) x 4] [X Y Z L]
    
    
    
    %-- atenuate and shift in time the AP template on each segment
      thisTemp = repmat(thisTemplate,nSegments,1); %[nSegments x nSamples]
                                              %thisTemplate:[1 x nSamples]
      
      %calculate and apply exponential decay along branch (segments)
      decayS = exp(-1*(2:2:nSegments*2)/lambdaD)'; %ref: 20 -30 1/um
      decayS = repmat(decayS,1,nSamples); %[nSegments x nSamples]
      
      thisTemp = thisTemp.*decayS; %attenuate the signal on each segment
      
      %shift delay propagation AP.
      % use a long template, just discard the tail of the A.P. 
      for iSegm =1:1:nSegments
        shiftSeg = ceil( 2*iSegm/speedAP/ (1/sampRate)); % speedAP um/s sampRate samp/s
        shiftSeg = min([shiftSeg nSamples-1]); %to avoid going over mSamples
        
        thisTemp(iSegm,end:end-shiftSeg) = ...
                                thisTemp(iSegm,thisTemp(iSegm,1:shiftSeg));
        thisTemp(iSegm,1:shiftSeg) = 0;   %[  nSegments x nSamples]                                             
      end 
        
      
      allTemplates = [allTemplates ; thisTemp]; %[nSeg*nNeurons x nSamples]
      
    
    
  end
    
  
