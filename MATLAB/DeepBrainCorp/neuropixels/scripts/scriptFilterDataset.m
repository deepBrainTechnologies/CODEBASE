%retrieval of Neuropixels data from Harris Lab.
%The raw data (".bin" files) are binary files of type int16 
%and with 385 data rows (see params.py). 

load('D:\NEUROSCIENCEWORK\Recordings\Neuropixels\forPRBimecP3opt3.mat');
[xInterp,yInterp] = meshgrid(5:5:65,15:5:3845);
nChan=384;


fileName = 'D:\NEUROSCIENCEWORK\Recordings\Neuropixels\rawDataSample.bin';
fileOut = 'D:\NEUROSCIENCEWORK\Recordings\Neuropixels\filtDataSample.bin';
fID = fopen(fileName,'r');
fIDout = fopen(fileOut,'w');


  
  while(1)
    chunkData = fread(fID,[384 30000],'*int16');
    
    if(~isempty(chunkData))
      nSamp = size(chunkData,2);
      t=(1:1:nSamp)/30; %30KHz sampling rate

      chunkData(chunkData<-50)=-50; chunkData(chunkData>50)=50;
      chunkData = chunkData+50;

      filtSamples= zeros(nChan,nSamp);
      for ch=1:nChan
        shiftVolt=(ch-1)*120;
        samples = chunkData(ch,:);  
        filteredSamp = filter(bhi,1,samples);
        filteredSamp = filteredSamp - mean(filteredSamp);
        %%plot(t,filteredSamp+shiftVolt,'.k'); hold all;
        %%noiseTh = std(filteredSamp);
        %%noiseTh = std(filteredSamp(abs(filteredSamp)<(noiseTh*2)));
        %%belowTh = filteredSamp<(noiseTh*-2); %1/0
        %%plot(t(belowTh),filteredSamp(belowTh)+shiftVolt,'.r');
        filtSamples(ch,:)=filteredSamp;
      end
    else
      break;
    end
    
      fwrite(fIDout,filtSamples,'int16');

  end

  fclose(fID);
  fclose(fIDout);
  
  
  %end SCRIPT
  