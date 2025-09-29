function analyze_network_cycles_only(filename)
% Analyze clusters of generated network from generate_networks.
% Calculate the degree distribution.
% Calculate clusters with and without main axon connections.
% Find the cluster distribution.
% Find the cycle distribution.

  load(filename,'p_curr','conn','cluster','cycle_dist')
  p_curr
  
  lcn = length(conn);

  if exist('cycle_dist') && length(cycle_dist)==lcn
    fprintf(1,'already computed cycles\n')
    return
  elseif exist('cycle_dist')
    start_ind = length(cycle_dist)+1
  else
    start_ind = 1
  end
  

  for k=start_ind:lcn
    if ~isempty(conn{k})
      cycle_dist{k} = cycle_distribution(conn{k},cluster{k});
      save(filename,'-append','cycle_dist')
    end
  end
  
end

