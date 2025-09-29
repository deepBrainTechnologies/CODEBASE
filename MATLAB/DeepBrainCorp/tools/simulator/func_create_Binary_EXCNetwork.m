%_____________________________________________________________________
%   ARTIFITIAL INTELLIGENCE .... "TOY MODELS"
%_____________________________________________________________________
%
%       %create_Binary_EXCNetwork 
%   %an EXC network of neurons is inherently stable if the neurons have
%   a realistic biophysical or electrophysiological model: filter (TUN-RF)
%
%_____________________________________________________________________
classdef func_create_Binary_EXCNetwork
  properties
    settings;
    nwNeuronType;   %integer type of neuron (int) [N]
    nwLocations;    %(x y z) [N x 1]
    nwDelays;    %calculated based on location (double)[N x N]
    
    nwConnectivity; %binary conectivity (1/0)[N x N]
    connectivityDynamics; % 1: fully random 2:fully random adding edges to
                         % meet minimum connectivity (also randomly)
                         % 3: gaussian decay of connection probability
                         % 4: exponential decay of connection probability
                         
    weightsMatrix; %positive double (+rational)[NxN]                    
    weightDynamics; %1:fully random 2:?? 3:??
    
  end
    
  methods
    %-----------------------   CONSTRUCTOR -------------------------
    function Obj = func_create_Binary_EXCNetwork()
    end
    function setSetting(Obj,settings)
      Obj.settings = settings;
      %------NW physiology/morphology info is provided by other part.
      Obj.nwNeuronType = settings.nwNeuronType;
      Obj.nwLocations = settings.nwLocations;
      Obj.nwDelays = settings.nwDelays;    
      % this class defines NW: network connectivity and W: weights
      Obj.nwConnectivity = settings.nwConnectivity;
      Obj.connectivityDynamics = settings.connectivityDynamics; %1,2,3 types                
      Obj.weightDynamics = settings.weightDynamics;          %1,2,3... types
    
    end
    
    function [NW, W] = createNW(Obj)
      
      
    end
    
    function 
  
  
  end  %methods
    