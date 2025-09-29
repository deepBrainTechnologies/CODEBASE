%____________________________________________________________________
%
% function generate_morphology_tree_from_morphology(neuronMatFile)
%
%   generate connectivity tree from morphology %id XYZi XYZf diam len
%
%____________________________________________________________________
function generate_morphology_tree_from_morphology(neuronMatFile)

  load(neuronMatFile,'morphology');

  nSegments = size(morphology,1);
  
  sortedXYZ = morphology;
  sortedXYZ = sortrows(sortedXYZ,[5 6 7]); %id xi yi zi xf yf zf d l
  %find unique combinations of XYZf (end points on each segment, JOINTS)
  uniqueXYZf = abs(diff(sortedXYZ(:,[5 6 7]),1,1));
  uniqueXYZf = uniqueXYZf>0;
  uniqueXYZf = squeeze(sum(abs(uniqueXYZf),2))'>0; %change on any cord
  uniqueXYZf = cat(0 , uniqueXYZf); %nonzero on changes of XYZf
  changeXYZf = find(uniqueXYZf);    %index of all unique XYZf from sortedXYZ

  %find unique XYZi (init points of each segment)
  sortedXYZinits = sortrows(sortedXYZ,[2 3 4]);
  uniqueXYZi = abs(diff(sortrows(sortXYZinits(:,[2 3 4]),1,1));
  uniqueXYZi = uniqueXYZi>0;
  uniqueXYZi = squeeze(sum(abs(uniqueXYZi),2))'>0; %change on any cord
  uniqueXYZi = cat(0 , uniqueXYZi); %nonzero on changes of XYZf
  changeXYZi = find(uniqueXYZi);    %index of all unique XYZi from sortedXYZ
  InitPoints = sortedXYZinits(changeXYZi,[1 2 3 4]); %INDEXING
  
  
  %make CONNECTIVITY  TREE --------------
  lastFirstEqualCord = 1;
  for i=1:length(changeXYZf)
    changeCord = changeXYZf(i)-1;
    thisJointPreSegments{i} = sortedXYZ(lastFirstEqualCord:changeCord,:); %INDEXING 
    thisJoint{i} = sortedXYZ(changeCord,[5 6 7]);%INDEXING
    JointsIndex{i} = i;
    
    lastFirstEqualCord = changeCord+1;
  end
  JointsXYZMap = containers.Map(JointsIndex,ThisJoint);
  JointsPreMap = containers.Map(JointsIndex,thisJointPreSegments);
  %------------
    
  
end