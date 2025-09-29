function plot_geometric_ratios(gr_group,ma_group,col_group,ma)
% Plot the antidromic geometric ratios. 
% "gr_group", "ma_group", "col_group" are output from the function
% geometric_ratios_group.
% "layer" indicates the layer the cells are from
% "ma" indicates whether antidromic ratios into the main axon are
% to be plotted versus antidromic ratios within collaterals

%[bpdiam_group ma_group cor_group col_group ...
%	gr_group n_cells] = geometric_ratios_group(cell_file_list);

if ma
	gr = gr_group(ma_group,3);
else
	gr = [gr_group(col_group,2); gr_group(col_group,3)];
end
total = length(gr);

alpha = 1:10;
dist = 2*alpha.^1.5;

n = hist(gr,dist);
bar(dist,n/total)