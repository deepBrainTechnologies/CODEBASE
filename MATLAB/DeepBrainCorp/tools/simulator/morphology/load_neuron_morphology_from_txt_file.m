%______________________________________________________
%  function load_neuron_morphology_from_txt_file(textfile)
%
%   xi yi zi   xf yf zf    d   // coordinates and diameter for each segment
%
%   on the same mat file later other parameters per segment have to be
%   added: for example fixed parameters that wont change over the entire
%   simulation. and parameters that will be updated such us those affected
%   by neuromodulation or affected by interaction or the same activation
%   (ion channels change their g,c,i throughout their cycle, so ALL models
%   are a gross oversimplification that DOES MATTER for doing ANALOGUE 
%   NCMUs.
%
%   CODE_Req_2
%______________________________________________________
function load_neuron_morphology_from_txt_file(textfile, OUTDIR)

fID = fopen(textfile,'r');
storedFormat = '%d %d %d %d %d %d %d'; %[XYZi XYZf d] in [nm] 

sizeM = [7 Inf];
morphology = fscanf(fID, storedFormat, sizeM);
fclose(fID);
morphology = morphology';

lenSeg = sqrt(((morphology(:,4)-morphology(:,1)).^2)+
          ((morphology(:,5)-morphology(:,2)).^2)+
          ((morphology(:,6)-morphology(:,1)).^2));
lenSeg = lenSeg(:)';
morphology = cat((1:1:size(morphology,1))',morphology); %id XYZi XYZf diam
morphology = cat(morphology,lenSeg,2);  %id XYZi XYZf diam len


neuronMatFile = [OUTDIR '/' textfile(1:end-4) '.mat'];
save(neuronMatFile, 'morphology');
generate_morphology_tree_from_morphology(neuronMatFile);
end