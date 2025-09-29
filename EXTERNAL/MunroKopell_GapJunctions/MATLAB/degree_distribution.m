function n = degree_distribution(conn)
% give the distribution of degrees in the network

degree_count = [length(conn{1}) 1];
for i=2:length(conn)
	j = find(length(conn{i})==degree_count(:,1),1);
	if isempty(j)
		new_row = [length(conn{i}) 1];
		degree_count = [degree_count; new_row];
	else
		degree_count(j,2) = degree_count(j,2)+1;
	end
end

n = sortrows(degree_count);