%retrieval of Neuropixels data from Harris Lab.
%The raw data (".bin" files) are binary files of type int16 
%and with 385 data rows (see params.py). 

PLOT_MOVIE=0;
PLOT_SAMPLES =0;
PLOT_FILTERED =1;


fileName = 'D:\NEUROSCIENCEWORK\Recordings\Neuropixels\rawDataSample.bin';
fID = fopen(fileName,'r');

chunkData = fread(fID,[385 120000],'*int16');
minSamp =1; maxSamp=5000;
chunkData = chunkData(:,end-maxSamp:end);
%plot(chunkData(1:10,:)');


load('D:\NEUROSCIENCEWORK\Recordings\Neuropixels\forPRBimecP3opt3.mat');
%yInterp = repmat(15:5:3845,[1 13]);yInterp = yInterp(:);
%xInterp = repmat(5:5:65,[767 1]); xInterp = xInterp(:);
[xInterp,yInterp] = meshgrid(10:5:60,20:5:3840);

figID = figure;

nSamp = size(chunkData,2);
chunkData(chunkData<-50)=-50; chunkData(chunkData>50)=50;
chunkData = chunkData+50;

FramesMovie(nSamp) = struct('cdata',[],'colormap',[]);


if(PLOT_FILTERED)
  
  t = (minSamp:1:maxSamp)/30; %in [ms]
  bhi = fir1(128,0.01,'high',chebwin(129,30));
  freqz(bhi,1);
  
  
  for ch=1:30
    shiftVolt=(ch-1)*120
    samples = chunkData(ch,minSamp:maxSamp);  
    filtSamples = filter(bhi,1,samples);

    noiseTh=-2*std(double(filtSamples(:)));
    thCrossed = (filtSamples<noiseTh);
    if (ch==1)
       thCrossedAll=thCrossed;
    else
       thCrossedAll =thCrossed + thCrossedAll;
    end
    plot(t,filtSamples+shiftVolt,'-k'); hold all;
    plot(t(thCrossedAll>0),filtSamples(thCrossedAll>0)+shiftVolt,'.r');
    
    
    
  end
  
  
    figure
    sampIxAPs = find(thCrossedAll);

    for spkID=1:length(sampIxAPs)
      
      thisSample = chunkData(1:end-1,sampIxAPs(spkID));
      thisSample = thisSample-mean(thisSample(:));
      frameInterp = griddata(xcoords,ycoords,double(thisSample),xInterp,yInterp,'cubic');
      
      frameInterp(isnan(frameInterp))=0;
      subplot(1,4,1);
      imagesc(frameInterp);
      
      subplot(1,4,2);
      pixAboveTh = (frameInterp)<-2*std(frameInterp(:));
      imagesc(pixAboveTh);
      
      subplot(1,4,3);
      imagesc(pixAboveTh.*frameInterp);
      pause;
      
      subplot(1,4,4)
      
    end

  
end