%script_find_SONET_patterns
clear
SYN = load('ber_3000_0.010_4.0_1.4_1.3_1.2.dat');
SYNcopy=SYN;
Nneurons=size(SYN,1);
neuronsXY = (100*rand(Nneurons,2));

randSEL = ceil(3000*rand(50));
for i=1:length(randSEL)
  keepNeuron=zeros(Nneurons,Nneurons);
  keepNeuron(i,:)=1;
  gplot(SYN,neuronsXY,'--*b');
  pause
  clf;
end

