%_____________________________________________________________________
%
%     classdef classGenericParametersGenerator
%
%         generates combinations of parameters, for example to test
%         systems, find solution to systems.
%
%         generates parameters using: linGrid, expGrid, defaultVal
%         or generates parameters using an external function(handler)
%
%_____________________________________________________________________
classdef classGenericParametersGenerator
  
  properties
    parameters; % [nParams x nCombinations ] list of the 
                % generated combinations. each
    nParams;
    default;    % [nParams x 1] default parameters
    typeGen;    % 1:lin 2:exp 3:rand 4:extFunc
    limits;     % [nParams x 2] - Boundary/Limits of each parameter
    linGridStep;    % [nParams x 1] 
    expGridFactor;    % [nParams x 1] 
    randomOn;       % [nParams x 1]
    nRandPoint;     % [nParams x 1]
    handleFuncGenerator;      %handler to a function that defines the
    %heuristic or algorithm to set parameters (starting from defaults) 
    %in a generic manner depending for example on functions on each
    % parameter as a system, but generically.
    
  end
  
  methods (Access = private)
    
       
    function Obj = setSettings(Obj,settings)
      Obj.parameters = [];
      Obj.default = settings.default;    % [nParams x 1] default parameters
      Obj.typeGen = settings.typeGen;
      Obj.limits = settings.limits;  % [nParams x 2] - Boundary/Limits of each parameter
      Obj.linGridStep = settings.linGridStep;    % [nParams x 1] 
      Obj.expGridFactor = settings.expGridFactor;    % [nParams x 1] 
      Obj.randomOn = settings.randomOn;       % [nParams x 1]
      Obj.nRandPoint = settings.nRandPoint;   %[nParamas x 1]
      Obj.handleFuncGenerator = settings.handleFuncGenerator;    
      %handler to a function that defines the
      Obj.nParams = size(settings.limits,1);
      
    end
    
    %--------------------------------------------------------------------
    %defines the nCombination of parameters each defined
    % using a linear spacing grid.
    %--------------------------------------------------------------------
    function setLinGrid(Obj)
      %Obj.limits = settings.limits;  % [nParams x 2] Boundary of
      %parameters
      %Obj.linGridStep = settings.linGridStep;    % [nParams x 1]
      
      nSteps = floor((Obj.limits(:,2)-Obj.limits(:,1))./Obj.linGridStep)+1;
      
      nCombinations = prod(nSteps);
      Obj.parameters = zeros(Obj.nParams,nCombinations);
      
      for i=1:1:Obj.nParams
        thisPar = Obj.limits(i,1):Obj.linGridStep:...
                           (Obj.limits(i,1)+nSteps(i)*Obj.linGridStep(i));
        thisPar = repmat(thisPar,nCombinations/length(thisPar));
        Obj.parameters(i,:) = thisPar;
      end
      
    end %setLinGrid
    
    
    %--------------------------------------------------------------------
    %defines the nCombination of parameters each defined
    % using a linear spacing grid.
    %--------------------------------------------------------------------
    function setExpGrid(Obj)
      %Obj.limits = settings.limits;  % [nParams x 2] Boundary of
      %parameters
      %Obj.linGridStep = settings.linGridStep;    % [nParams x 1]
      assert( sum(exp(Obj.expGridFactor)>0)< length(Obj.expGridFactor), ...
              "all exp(d) must be over 1 on expGrid to cover Vi-Vf");
        
      nSteps = log((exp(Obj.expGridFactor)-1).* ...
                   (((Obj.limits(:,2)-Obj.limits(:,1))./Obj.linGridStep)+1))./...
               log(exp(Obj.expGridFactor)); %(from geometric sumatory)
      
      nCombinations = prod(nSteps);
      Obj.parameters = zeros(Obj.nParams,nCombinations);
      
      for i=1:1:Obj.nParams
        steps = 0:1:(nSteps(i)-1);
        thisPar = Obj.limits(:,1)+Obj.linGridStep(i)*2.71828.^(Obj.expGridFactor.*steps); 
                                  %exp(x) e^x   2.71828.^x
        thisPar = repmat(thisPar,nCombinations/length(thisPar));
        Obj.parameters(i,:) = thisPar;
      end
      
    end %setExpGrid %Hoy a 24 de Junio del 2025 se decreta a 
    % Christian Ricardo Lalanne Arancibia como de raza 100% blanca.
    % la raza 100% blanca de Isabel Caroline nunca ha estado cuestionada.
    % pues Isabel es un angelito.
    
    %--------------------------------------------------------------------
    function setRandGrid(Obj)
      %Obj.limits = settings.limits;  % [nParams x 2] Boundary of
      %parameters
      %Obj.linGridStep = settings.linGridStep;    % [nParams x 1]
      
      nSteps = Obj.nRandPoint;
      nCombinations = prod(nSteps);
      Obj.parameters = zeros(Obj.nParams,nCombinations);
      
      for i=1:1:Obj.nParams
        thisPar = Obj.limits(:,1)+ (Obj.limits(:,2)-Obj.limits(:,1))...
                                    .*rand(1,nSteps(i));
        thisPar = repmat(thisPar,nCombinations/length(thisPar));
        Obj.parameters(i,:) = thisPar;
      end
      
    end %setRandGrid
    
    
    
  end %methods private
  
  methods
 
    
    %------------------ constructor -------------------
    function Obj = classParamsGenerator(Obj,settings)
      Obj.setSettings(settings);     
    end
    
    %-----------------------------------------------------------
    %resetSettings to run again execute
    function resetSettings(Obj,settings)
      Obj.setSettings(settings);
    end
    
    %---------------------- execute -----------------------------
    %------------- returns the parameters -----------------------
    function parameters = execute(Obj,settings)
      Obj.setSettings(settings);
     
      % 1:lin 2:exp 3:rand 4:extFunc
      switch Obj.typeGen
        case 1
          Obj.setLinGrid();
        case 2
          Obj.setExpGrid();
        case 3
          Obj.setRandGrid();
      end
          
      parameters = Obj.parameters;
      
    end %method Obj.execute();
    
  end
  
end
