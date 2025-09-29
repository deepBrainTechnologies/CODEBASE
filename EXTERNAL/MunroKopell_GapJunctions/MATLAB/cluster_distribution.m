function n = cluster_distribution(cluster)
% give histogram of clusters in cell array cluster

cluster_count = [length(cluster{1}) 1];
for i = 2:length(cluster)
	j = find(length(cluster{i})==cluster_count(:,1),1);
	if isempty(j)
		new_row = [length(cluster{i}) 1];
		cluster_count = [cluster_count; new_row];
	else
		cluster_count(j,2) = cluster_count(j,2)+1;
	end
end

n = sortrows(cluster_count);