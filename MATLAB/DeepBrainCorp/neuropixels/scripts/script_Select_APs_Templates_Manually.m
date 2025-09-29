%_____________________________________________
%
%  script_Select_APs_Templates_Manually
%
%_____________________________________________

%retrieval of Neuropixels data from Harris Lab.
%The raw data (".bin" files) are binary files of type int16 
%and with 385 data rows (see params.py). 

load('D:\NEUROSCIENCEWORK\Recordings\Neuropixels\forPRBimecP3opt3.mat');
[xInterp,yInterp] = meshgrid(5:5:65,15:5:3845);%[60x3840] um probe
nChan=284;

fileName = 'D:\NEUROSCIENCEWORK\Recordings\Neuropixels\filtDataSample.bin';
fID = fopen(fileName,'r');
shiftVolt = 120;


APtemplates = [];
  
   while(1)
    subRecLen = 1000;
    theseSamples = fread(fID,[384 subRecLen],'*int16');
    
    if(~isempty(theseSamples))
      nSamp = size(theseSamples,2);
      t=(1:1:nSamp)/30; %30KHz sampling rate

      chINIT=50;
      for ch=chINIT:1:(chINIT+10)
        shiftVolt = (ch-chINIT)*140;
        samples =  double(theseSamples(ch,:));  
        noiseTh = std((samples)); %Noise is calculated as noise of the noise
        noiseTh = std(samples(abs(samples)<(noiseTh*2)));
        belowTh = [0 samples 0]<(noiseTh*-2); %[0 1 1 1 0 0 1 1 0 0]
        initThCross = find(diff( belowTh)==1); %sample Idx (+1) of uprise
        endThCross = find(diff( belowTh)==-1); %sample Idx (+1) of downrise
        lengthThCross = (endThCross-initThCross); %length of crossing ("pulse")
        
        %find peak within each threshold crossing
        nCross=length(lengthThCross);
        allPeaks=[];
        for thX=1:nCross
          [Maxval, idxPeak] = min((samples(initThCross(thX):endThCross(thX))));
          allPeaks = [allPeaks  (initThCross(thX)+idxPeak-1)]; %sample Idx
        end
        
        %group those within 0.5 ms (this is a first run)
        % at ~30KHz neuronal noise (at 1 sample resolution)
        minSep = 20; %0.8 ms at 30 KHz.
        nSampBetwPEAKS = diff([0 (allPeaks(:)')]);
        idxIsolatedAP = find(nSampBetwPEAKS > minSep);
        keepPeaks = allPeaks(idxIsolatedAP);
        keepPeaks = keepPeaks(keepPeaks<(subRecLen-100)); % avoid pointing out
        keepPeaks = keepPeaks(keepPeaks>(100)); % avoid pointing out
        
                
        %PLOT SAMPLES 
        plot(t,samples+shiftVolt,'-k'); hold all;
        plot(t(allPeaks),samples(allPeaks)+shiftVolt,'*k');
        plot(t(belowTh(2:end-1)),samples(belowTh(2:end-1))+shiftVolt,'.r');
        plot(t(keepPeaks),samples(keepPeaks)+shiftVolt,'db');

        
      end
      hold off; figure;
    end
    
   end %for each chunk of samples read
    
 
  