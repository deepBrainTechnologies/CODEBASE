%_________________________________________________________________
%
% script_detect_and_follow_vehicles
%
%_________________________________________________________________

[VideoFeed, nFrames] = readVideoFile_Class(videoFileName);

nReads = floor(nFrames/config.detect.winFrames);
figure;
for win=1:1:nReads
  theseFrames = VideoFeed.readFrames(config.detect.winFrames);
  theseFrames = squeeze( 0.299*theseFrames(:,:,1,:)+ ...
                0.587*theseFrames(:,:,2,:) + ...
                0.114*theseFrames(:,:,3,:));
              
  for ii=1:1:config.detect.winFrames
     subplot(1,3,1)
     imagesc(theseFrames(:,:,ii));
     
     theseFrames(:,:,ii) = trafficPreProsClass.baselineTransform(theseFrames(:,:,ii));
     
     2dfilt = trafficPreProsClass.make2DMask(config.detect.minXlen,config.detect.minYlen);
     windowed = trafficPreProsClass.2Dmask(theseFrames(:,:,ii),2dfilt,dx,dy);
     
     subplot(1,3,2);
     imagesc(windowed);
    pause(1);
    clf;
  end
  
end


