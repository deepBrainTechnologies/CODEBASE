function analyze_network_clusters_only(filename)
% Analyze clusters of generated network from generate_networks.
% Calculate the degree distribution.
% Calculate clusters with and without main axon connections.
% Find the cluster distribution.
% Find the cycle distribution.

  p = pwd
  f = filename
  load(filename,'p_curr','conn','deg_dist','cluster','clust_dist')
  p_curr
  
  lcn = length(conn);
  
  if exist('clust_dist') && length(clust_dist)==lcn
    fprintf(1,'clust_dist already computed\n');
    return
  elseif exist('clust_dist') 
    start_ind = length(clust_dist)+1
  else
    start_ind = 1
  end  
  
  for k=start_ind:lcn
    if ~isempty(conn{k})
      deg_dist{k} = degree_distribution(conn{k});
      
      cluster{k} = conn_clusters(conn{k});
      
      clust_dist{k} = cluster_distribution(cluster{k});
      
      save(filename,'-append','deg_dist','cluster','clust_dist')
    end
  end
  

