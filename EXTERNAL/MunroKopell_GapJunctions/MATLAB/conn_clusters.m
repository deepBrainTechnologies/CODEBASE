function cluster = conn_clusters(conn)
% give clusters of conn in cell array clusters

sc = length(conn);

cells = 1:sc;
j = 1; % current cluster
while ~isempty(cells)
	cells_left = length(cells);
	cell = cells(1); % take first cell not dealt with
	cells = cells(2:length(cells)); %remove it from list
	cluster{j} = cell; % make a new cluster with it
	ends = conn{cell}; % get its connections
	while ~isempty(ends)
		cluster{j} = [cluster{j} ends]; %add cells to cluster
		% remove ends from cells one at a time
		for k = ends 
			%kend = k
			ki = find(cells == k,1);
			if ki > 1
				front = 1:(ki-1);
			else front = []; end
			if ki < length(cells)
				back = (ki+1):length(cells);
			else back = []; end
			cells = [cells(front) cells(back)];
			cells_left = length(cells);
		end
		%cell_list = cells
		old_ends = ends;
		ends = [];
		for k = old_ends % for all old ends
			% test each cell they're connected to
			for test = conn{k}
				% to see if they're in the cluster or ends
				inclus = find(test == cluster{j},1);
				inends = find(test == ends,1);
				for ci = 1:j-1
					if find(test == cluster{ci})
						error('end in other cluster')
					end
				end
				if isempty(inclus) && isempty(inends)
					ends = [ends test];
				end
			end
		end % k = old_ends
		%new_end = ends
	end % ~isempty(ends)
	% now that all cells in the cluster are added
	% move on to new cluster
	cells_left = length(cells);
	j = j + 1;
end % ~isempty(cells)
