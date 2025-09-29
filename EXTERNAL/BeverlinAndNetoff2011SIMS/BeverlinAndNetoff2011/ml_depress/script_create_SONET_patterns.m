%%script_create_SONET_patterns
clear
Nneurons=3000;
neuronsXY = (100*rand(Nneurons,2));
Nconnections=Nneurons*Nneurons;

%---------------------------------------------------------
%produce RANDOM connectivity pattern

%limit connectivity probability
SYN = zeros(Nneurons,Nneurons);
pPair =0.02;
keepPairs = [];

for i=1:Nneurons
  keepSYNAPTIC = unique(ceil(Nneurons*rand(round(Nneurons*pPair),1)));
  keepSYNAPTIC = keepSYNAPTIC + (i-1)*Nneurons;
  keepPairs =[keepPairs keepSYNAPTIC'];
end

  SYN(keepPairs)=1;

  save('D:\MYSOFTWAREBASE\SIMULATIONS\BeverlinAndNetoff2011SIMS\BeverlinAndNetoff2011\ml_depress\ber_Fully_Rand.mat','SYN');

  synProbSTD = 0.2;
  synProbMean = 0.8;
  synNorm = synProbSTD*randn(length(keepPairs),1)+synProbMean;

  SYN(keepPairs)=synNorm;
  save('D:\MYSOFTWAREBASE\SIMULATIONS\BeverlinAndNetoff2011SIMS\BeverlinAndNetoff2011\ml_depress\ber_Fully_Rand_Gauss0.8.mat','SYN');
 
  synProbSTD = 0.3;
  synProbMean = 0.5;
  synNorm = synProbSTD*randn(length(keepPairs),1)+synProbMean;

  SYN(keepPairs)=synNorm;
  save('D:\MYSOFTWAREBASE\SIMULATIONS\BeverlinAndNetoff2011SIMS\BeverlinAndNetoff2011\ml_depress\ber_Fully_Rand_Gauss0.5.mat','SYN');
 
  
  %---------------------------------------------------------

randSEL = ceil(3000*rand(50));

figure
%hist(sum(SYN,2),'*');


% % pause
% % figure
% % for i=1:length(randSEL)
% %   
% %   plot(neuronsXY(randSEL(i),1),neuronsXY(randSEL(i),2),'*r'); hold on;
% %   whichTO = find(SYN(i,:));
% %   for j=1:length(whichTO)
% %     plot(neuronsXY(whichTO(j),1),neuronsXY(whichTO(j),2),'*b');hold on;
% %   end
% %   pause
% %   clf
% % end

Ndivergent=0;  %1 to 2
Nconvergent=0; % 2 to 1
Nchain=0;      %1 to 1 to 1
Nbidirectional=0; %1<->1

% % for i=1:Nneurons
% %   whichTO = SYN(i,1:i);
% %   whichTO = whichTO.*(whichTO>0);
% %   
% % end
  

