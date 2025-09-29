function [bp_diams ma_row cor_row col_row] = ...
	branch_point_diameters(cell,method)
% Give branch point diameters for cell in one matrix. 'cell' can be cell
% name (string) or loaded axon (struct)
% bp_diam has 6 columns:
% parent child1 child2 dist_from_soma dist_from_core parent_diam child1_diam child2_diam
% only parent compartments with children are listed
% diams listed are transitional diameters: last diameter of parent
% and first held diameter of child (1st diameter is always the same as last 
% diameter of parent)

if isstruct(cell)
	axon = cell;
else
	axon = load_axon(cell);
end
[maxon core rank] = find_main_axon(axon,method);
ma_row = [];
cor_row = [];
col_row = [];

child_ind = find(axon.nchild > 0); % compartments with children
bp_diams = zeros(length(child_ind),8);

for i=1:length(child_ind)
	parent = child_ind(i);
	children = axon.children{parent};
	bp_diams(i,4) = axon.dist(parent)+axon.L(parent);
	if any(parent==core)
		bp_diams(i,5) = 0;
		cor_row = [cor_row i];
		if any(parent==maxon)
			ma_row = [ma_row i];
		end
	else
		gp = parent;
		while ~any(gp==core)
			gp = axon.parent(gp);
		end
		bp_diams(i,5) = axon.dist(parent)+axon.L(parent)-axon.dist(gp)-axon.L(gp);
		col_row = [col_row i];
	end
	
	% figure out which child is more primary vs secondary
	level = 1;
	sr = size(rank);
	while level <= sr(2);
		if rank(children(1),level)>=rank(children(2),level)
			cind(1) = children(1);
			cind(2) = children(2);
			break
		elseif rank(children(1),level)<rank(children(2),level)
			cind(1) = children(2);
			cind(2) = children(1);
			break
		elseif level==sr(2)
			cind(1) = children(1);
			cind(2) = children(2);
			break
		end
		level = level + 1;
	end

	bp_diams(i,1:3) = [parent cind];
	if axon.holdL{parent}==0
		% skip transitional diameter in parent
		bp_diams(i,6) = axon.diams{parent}(end-1);
	else
		bp_diams(i,6) = axon.diams{parent}(end);
	end
	for j=1:2
		if axon.holdL{cind(j)}(1) > 0 || length(axon.diams{cind(j)})<2 
			bp_diams(i,6+j) = axon.diams{cind(j)}(1);
		else 
			% skip transitional diameter in child
			bp_diams(i,6+j) = axon.diams{cind(j)}(2);
		end
	end
	if any(parent==maxon) && bp_diams(i,6)==bp_diams(i,8)
		fprintf('%s: %d %d\n',cell,parent,cind(2))
	end
end