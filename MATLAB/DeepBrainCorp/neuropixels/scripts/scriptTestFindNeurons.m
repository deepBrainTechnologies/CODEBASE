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
    subRecLen = 3000;
    theseSamples = fread(fID,[384 subRecLen],'*int16');
    
    if(~isempty(theseSamples))
      nSamp = size(theseSamples,2);
      t=(1:1:nSamp)/30; %30KHz sampling rate

      chINIT=150;
      for ch=chINIT:1:284
        shiftVolt = (ch-chINIT)*140;
        samples =  double(theseSamples(ch,:));  
        noiseTh = std((samples)); %Noise is calculated as noise of the noise
        noiseTh = std(samples(abs(samples)<(noiseTh*3)));
        belowTh = [0 samples 0]<(noiseTh*-3); %[0 1 1 1 0 0 1 1 0 0]
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
        
        pause;        
        %PLOT SAMPLES 
        plot(t,samples+shiftVolt,'-k'); hold all;
        plot(t(allPeaks),samples(allPeaks)+shiftVolt,'*k');
        plot(t(belowTh(2:end-1)),samples(belowTh(2:end-1))+shiftVolt,'.r');
        plot(t(keepPeaks),samples(keepPeaks)+shiftVolt,'db');

        %1 ms before and after = 30 samples
        nPeaks = size(keepPeaks,2);
        sampTW = 30;
        nSampAP=sampTW*2+1;
        APs_Indexes_y = repmat(keepPeaks(:)',nSampAP,1); % [nSampAP x nPeaks]
        sampIDX = repmat((-1*sampTW:1:sampTW)',1,nPeaks); %[nSampAP x nPeaks]
        APs_Indexes_y = APs_Indexes_y+sampIDX;%[nSampAP x nPeaks] sample index
        APs_Indexes_y = repmat(APs_Indexes_y,1,1,nChan); 
                                               %[nSampAP x nPeaks x nChan]
        APs_Indexes_y = permute(APs_Indexes_y, [1 3 2]); 
                                               %[nSampAP x nChan x nPeaks]
        
        APs_Indexes_x = repmat(1:1:nChan,nSampAP,1,nPeaks);%nSampAP x nChan x nPeaks
        %APs_Indexes_x = permute(APs_Indexes_x,[2 1 3]);
                                                  %nChan x nSampAP x NPeaks
        APsIndexes = sub2ind([subRecLen nChan], ...
                                        APs_Indexes_y(:),APs_Indexes_x(:));
        theseSamples = theseSamples';
        %verifying APsIndexes pointing to theseSamples([nChan x lengthRec])
        %plot(theseSamples(22, 
        % APsIndexes(nSampAP+56*nChan*nSampAP+(1:nChan:nChan*nSampAP))),'-')
        % TODO: Add Y LENGTH (LenChunkRecord) TO INDEX TheseSAmples 
        
        theseAPs = theseSamples(APsIndexes); 
        theseAPs = reshape(theseAPs,nSampAP,nChan,nPeaks);
        APtemplates = cat(3, APtemplates, theseAPs); 
        
        %for chI=1:1:nChan
        %  theseAPs(chI,:,:  ; %theseAPs=[nChan x nSampAP x nPeaks]
        
%         for chI=1:10:280
%           figure;
%           plot(squeeze(theseAPs(chI,:,:)),'-k');
%         end
        
      end
    else
      break;
    end
    
  end

  fclose(fID);
  fclose(fIDout);
  
  
  %end SCRIPT