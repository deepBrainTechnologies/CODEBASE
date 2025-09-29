%__________________________________________________________________________
%function backAP = propagateIntraAPtemplate
%                                     (template,morphology, electroPhys)
%
% template: [1 x nSamples]  samples corresponding to AP at soma
%
% morphology: format for a simplified morphology near the soma only
%             to model bAP and AP strength and shape. middle point 
%             of each segment.  [x y z len dia parent]
%   .Soma = [Ncomp x 6]
%   .Dends = [Ncomp x 6]        %axon and dend list include a tiny mock
%                                segment "part of the soma"
%   .Axons = [Ncomp x 6]
%
% electroPhys: as above. relevant parameters used for simulations
%               value of exp decay constant
%   .expDecayDends = [Ncomp x 1]   
%   .expDecayAxons = [Ncomp x 1] 
%   
% OUTPUT:
%  APpropagated.soma = [nComp x nSamples]
%
function APpropagated = propagateIntraAPtemplate(template,morphology, electroPhys)

  APpropagated.soma = repmat(template,[nComp 1]);
  nDend = size(morphology.Dends,3);
  nAxons = size(morphology.Axons,3);

  APparent = template;
  APpropagated.Dends(1,:) = APparent; %tiny mock compartment just to
  %simplify programing of algorithms
  APpropagated.Axons(1,:) = APparent;
  
  for s=1:nDend
    

end