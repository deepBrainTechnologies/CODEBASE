function cycle_count = cycle_distribution(conn,cluster)
% give histogram of smallest cycles in network

cycle_count = zeros(10,1);

for i=1:length(cluster)
  if length(cluster{i})>2
    % find first cell with more than one neighbor
    for j=1:length(cluster{i})
      if length(conn{cluster{i}(j)})>1
        node = cluster{i}(j);
        break;
      end
    end
    
    % use that cell to find cycles in this cluster
    cycles = find_cycles(conn,node,0);
    lc = length(cycles);
    for j=1:lc
      if ~isempty(cycles{j})
        sc = size(cycles{j});
        for k=1:sc(1)
          cycle_length = cycles{j}(k,1);
          if length(cycle_count)<cycle_length
            cycle_count(cycle_length) = 1;
          else
            cycle_count(cycle_length) = cycle_count(cycle_length) ...
                + cycles{j}(k,2); 
          end
        end
      end
    end %j=1:lc
    
  end %length(cluster{i})>2
end %i=1:length(cluster)

cycle_count = cycle_count/2;