%______________________________________________________
%
%   NAMEObj =  readVideoFile_Class(filename);
%   frames = NAMEObj.readFrames(readNFrames);
%______________________________________________________
classdef readVideoFile_Class
  properties
    filename
    vidH;
    frameCount;
    fps;
    Xpix;
    Ypix;
    
  end
  
  methods
    
    function [Obj, nFrames] = readVideoFile_Class(filename)
      Obj.vidH = VideoReader(filename);
      Obj.fps = Obj.vidH.FrameRate;
      Obj.Ypix = Obj.vidH.Width;
      Obj.Xpix = Obj.vidH.Height;
      Obj.frameCount=Obj.vidH.NumFrames;
      nFrames = Obj.vidH.NumFrames;
    end

    function thisframe = readFrames(Obj,readNFrames)
      frameIX = 1;
      thisframe = zeros(Obj.Xpix,Obj.Ypix,3,readNFrames);
      
      %this could be if nFrames changes dynamically (otherwise read())
      while ( hasFrame(Obj.vidH) && (frameIX< readNFrames) )
        thisframe(:,:,:,frameIX) = readFrame(Obj.vidH);
        frameIX = frameIX+1;
        Obj.frameCount = Obj.frameCount+1;
      end
    end
    
  end %methods
  
end
