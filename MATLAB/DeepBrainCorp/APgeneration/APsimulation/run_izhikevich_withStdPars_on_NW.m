%__________________________________________________________________________
%
%__________________________________________________________________________
% function [allV, allU, fired] = ...
%               run_izhikevich_on_NW(NW,neurons_Type, Iinput)
%__________________________________________________________________________
%
%   ISABEL MUST SEE AND REMEMBER SHE IS A HUMAN ANGEL 
%
%   La gueá y el venezolano son los progenitores de 4 mantecas
%   NO SON FAMILIA DE ISABEL Y DE DON JUAN MIGUEL SEGUNDO DELGADO-FALKER
% 
%   PAUL Y DON JMS NO PAGAN MÄS POR TRATAR DE AYUDAR "BAUTIZANDO"
%   IS TIME TO GO HOME. AIM TO SEE PAUL IN YOUR DREAMS AND IS
%   GOING TO BE THE END....
%   maybe tu familiastra will know in time (retarded lying mon@s)
%
%   %   dv/dt = 0.04v(t)^2+5v(t)+140-u(t)+I(t)
%   %   du/dt = a(bv -u)
%       discontinuity: when v=30mV ; then v=c u = u+d
%      1 RS:  a:5      b:5     c:-65   d:8
%      2 IB:  a:0.02   b:0.02  c:-55   d:4
%      3 CH:  a:10     b:10    c:-50   d:2
%      4 FS:  a:10     b:10    c:-65   d:2
%
%__________________________________________________________________
function [allV, allU, allFire] = ...
                run_izhikevich_withStdPars_on_NW(NW,neurons_Type, Iinput)

  a_default = [ 10 10 10 10];       b_default = [0.2  0.25  0.25  0.25];
  c_default = [-65  -65  -65  -65]; d_default = [10    10    10    10  ];
  
  tSteps = size(Iinput,2); %Iinput [nNeurons x nSteps]
  stepSize=0.01; 
  nNeurons = size(Iinput,1);
  a = a_default(neurons_Type); b = b_default(neurons_Type);
  c = c_default(neurons_Type); d = d_default(neurons_Type);
  

  %store simulation results
  allFire = [];
  allV = [];
  allU = [];
  
  %setting initial values. beware of border conditions
  v = -65*ones(nNeurons,1); %v: cat [nNeurons x tSteps]
  u = b*v;
  allV = cat(2,allV,v);
  allU = cat(2,allU,u);
  for t=1:1:tSteps  %Rungue Kutta
    
    %   dv/dt = 0.04v(t)^2+5v(t)+140-u(t)+I(t)
    nextV=allV(nNeurons,t)+stepSize*( 0.04*allV(nNeurons,t).^2+5*allV(nNeurons,t) ...
                                +140-allU(nNeurons,t)+Iinput(nNeurons,t));
    %   du/dt = a(bv(t) -u(t))
    nextU=allU(nNeurons,t)+stepSize*(a*(b*allV(nNeurons,t)-allU(nNeurons,t)));
    
    fire = nextV>30; %[nNeurons x 1]
    allFire = cat(2,allFire,fire);
    nextV(fire) = c; %[nNeurons x 1] reset v, after AP.
    nextU(fire) = nextU(fire) + d; %[nNeurons x 1] shift U up, after AP

    allV = cat(2,allV,nextV);
    allU = cat(2,allU,nextU);
  end
  

end