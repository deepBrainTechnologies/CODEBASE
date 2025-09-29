function gr = geometric_ratios(bp_diams)
% Give the geometric ratios of cell 'cell_name'.
% 'gr' is a matrix where each row contains:
% [(GR from soma) (GR from main child) (GR from second child)]
% Main axon is chosen according to 'method' as described in the function
% find_main_axon.

sbp = size(bp_diams);
gr = zeros(sbp(1),3);

gr(:,1) = (bp_diams(:,7).^(1.5) + bp_diams(:,8).^(1.5))./...
	bp_diams(:,6).^(1.5);
gr(:,2) = (bp_diams(:,6).^(1.5) + bp_diams(:,8).^(1.5))./...
	bp_diams(:,7).^(1.5);
gr(:,3) = (bp_diams(:,6).^(1.5) + bp_diams(:,7).^(1.5))./...
	bp_diams(:,8).^(1.5);
