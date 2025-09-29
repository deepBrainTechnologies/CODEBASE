%retrieval of Neuropixels data from Harris Lab.
%The raw data (".bin" files) are binary files of type int16 
%and with 385 data rows (see params.py). 

PLOT_MOVIE=1;
PLOT_SAMPLES =0;
PLOT_FILTERED =0;


fileName = 'D:\NEUROSCIENCEWORK\Recordings\Neuropixels\rawDataSample.bin';
fID = fopen(fileName,'r');

chunkData = fread(fID,[385 30000],'*int16');
%plot(chunkData(1:10,:)');


load('D:\NEUROSCIENCEWORK\Recordings\Neuropixels\forPRBimecP3opt3.mat');
%yInterp = repmat(15:5:3845,[1 13]);yInterp = yInterp(:);
%xInterp = repmat(5:5:65,[767 1]); xInterp = xInterp(:);
[xInterp,yInterp] = meshgrid(5:5:65,15:5:3845);

figID = figure;

nSamp = size(chunkData,2);
chunkData(chunkData<-50)=-50; chunkData(chunkData>50)=50;
chunkData = chunkData+50;

FramesMovie(nSamp) = struct('cdata',[],'colormap',[]);

if(PLOT_MOVIE)
  for ts=1:nSamp
    samples = chunkData(1:end-1,ts);
    frameInterp = griddata(xcoords,ycoords,double(samples),xInterp,yInterp,'cubic');
    imagesc(frameInterp);
    FramesMovie(ts) = getframe(gcf);
    %clf;
  end
end



if(PLOT_SAMPLES)
  minSamp =1; maxSamp=30000;
  t = (minSamp:1:maxSamp)/30; %in [ms]
  noiseTh=-1*std(double(chunkData(:)))*3;
  noiseTh = repmat(noiseTh,[1 length(t)])+mean(double(chunkData(:)));
  for ch=1:30
    shiftVolt=(ch-1)*120;
    samples = chunkData(ch,minSamp:maxSamp) + shiftVolt;    
    plot(t,samples,'-k'); hold all;
    plot(t,noiseTh+shiftVolt,'-r'); hold all;
  end
end


if(PLOT_FILTERED)
  minSamp =1; maxSamp=30000;
  t = (minSamp:1:maxSamp)/30; %in [ms]
  bhi = fir1(128,0.01,'high',chebwin(129,30));
  freqz(bhi,1);
  
  
  for ch=1:30
    shiftVolt=(ch-1)*120
    samples = chunkData(ch,minSamp:maxSamp);  
    filtSamples = filter(bhi,1,samples) + shiftVolt;

    noiseTh=-1*std(double(filtSamples(:)))*3;
    plot(t,filtSamples,'-k'); hold all;
  end

  
end

  
  
