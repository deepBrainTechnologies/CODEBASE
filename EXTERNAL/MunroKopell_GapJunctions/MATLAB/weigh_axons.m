function weights = weigh_axons(axon_list)

if iscellstr(axon_list)
	cell_names = axon_list;
else
	fid = fopen(axon_list,'r');
	cell_name = fgetl(fid);
	i = 1;
	while cell_name ~= -1
		cell_names{i} = cell_name;
		cell_name = fgetl(fid);
		i = i + 1;
	end
	fclose(fid);
end

weights = zeros(length(cell_names),1);

for i=1:length(cell_names)
	axon = load_axon(cell_names{i});
	roots = find(axon.parent==0);
	for j=1:length(roots)
		weights(i) = weights(i) + weigh_tree(axon,roots(j));
	end
end
