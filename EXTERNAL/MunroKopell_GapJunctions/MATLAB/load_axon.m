function axon = load_axon(cell_name)
% load data files for cell_name into struct axon
% axon is a struct with fields:
% dist = array with distance of top of comps from soma
% L = array of compartment lengths (same as NEURON)
% diam = array of average diameters (same as NEURON)
% pos = for each comp: x3d(0) y3d(0) z3d(0) x3d(1) y3d(1) z3d(1) (same as NEURON)
% parent = array of parents (same as NEURON + 1)
% nchild = number of children for each compartment
% children = cell array of axonal children (children of form "axon[i]") + 1
% diams = cell array of diameters within compartment (3d diameters in NEURON)
% holdL = cell array of hold lengths for diams (arc3d length for 3d sections
% with same diameter on both ends)
% transL = cell array of transition lengths for diams (arc3d length for 3d
% sections with different diameters on both ends)

cell_file = sprintf('BP_%s.out',cell_name);
BP_data = load(cell_file);
cell_file = sprintf('D3D_%s.out',cell_name);
D3D_data = load(cell_file);
cell_file = sprintf('CO_%s.out',cell_name);
file = dir(cell_file);
if ~isempty(file)
	CO_data = load(cell_file); %should be only one file!
else
	CO_data = [];
	%fprintf(1,'no collateral file\n');
end

% BP_data:
% 1:section 2:distance 3:length 4:diameter 5:x3d(0) 6:y3d(0) 7:z3d(0)
% 8:x3d(1) 9:y3d(1) 10:z3d(1) 11:parent 12:nchild 13:child1 14:child2
% D3D_data:
% 1:section 2:diam3d 3:hold 4:trans ... diam3d hold trans -1 -1 -1 ... -1 -1 -1

sD3D = size(D3D_data);
axon = struct('dist',BP_data(:,2),'L',BP_data(:,3),'diam',...
	BP_data(:,4),'pos',BP_data(:,5:10),'parent',BP_data(:,11)+1,'nchild',...
	BP_data(:,12),'children',[],'diams',[],...
	'holdL',[],'transL',[],'collaterals',CO_data);
	
for i=1:sD3D(1)
	%children = BP_data(i,13:(12+BP_data(i,12)))
	axon.children{i} = BP_data(i,13:(12+BP_data(i,12))) + 1;
	term = find(D3D_data(i,:)==-1,1);
	if isempty(term)
		term = sD3D(2);
	else
		term = term - 1;
	end
	axon.diams{i} = D3D_data(i,2:3:term);
	axon.holdL{i} = D3D_data(i,3:3:term);
	axon.transL{i} = D3D_data(i,4:3:term);
end
