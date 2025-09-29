This folder contains all of the code necessary to generate the data
for the network model shown in figure 12.

generate_sep_networks.m was used to generate networks for values of p
that were expected to yield an average of 0-1 connections per cell.
generate_extra_networks.m was used to generate networks for values of
p that were expected to yield an average of 1-4 connections per cell.
The code for generating a network with given parameters is in
connections_cortcolsimple2.m

All networks are automatically saved to a matlab ".mat" file, so they
can subsequentially be loaded to analyze. For each network, we
analyzed the connected clusters with analyze_network_clusters_only.m.
We then analyzed the number of cycles in the network with
analyze_network_cycles_only.m. The code for analyzing the clusters in
a single network is in conn_clusters.m. The code for analyzing cycles
in a single network in is find_cycles.m.

plot_geometric_ratios.m was used to generate bar graphs of the
antidromic geometric ratios.

See comments in individual files for more information.
