classdef configClassDBTtraffic
  
  properties (Access=public)
    video;
    detect;
    classif;

  end
  
  methods
    function Obj =  configClassDBTtraffic()
      %videos fed to application are homogenized
      Obj.video.rate =30; %fps for traffic should be 120 fps
      Obj.video.resol=6159; %bps
      
      %detection of vehicles
      Obj.detect.win = 0.5; %seconds
      Obj.detect.winFrames = 15; %frames
      Obj.detect.minXlen = 10; %pixels . size vehicle
      Obj.detect.minYlen = 10;
    
      %classification of vehicles
      Obj.classif.minNtypes = 3;
      Obj.classif.ratiosSize = [1 2 4 6]; %car suv truck lorry
    
    end
  
  end
end
    
    
    