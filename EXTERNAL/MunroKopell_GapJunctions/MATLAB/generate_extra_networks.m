function generate_extra_networks(cell_list,layer,p_intra,r_c,n_x,n_y,...
    n_colcell,seedl,seedu,add_to_old)
% generate connections_corcolsimple networks varying:
% p_inter, r_c
% above the threshold for a large cluster for seeds seedl:seedu.
% Print the networks into a file to be read and analyzed later.
% add_to_old indicates whether a previous file should be read in to be
% added to.
% cell_list is a text file listing the cells to use in generating
% the networks

addpath('/usr2/faculty/ecmun')
addpath('/usr2/faculty/ecmun/cortcol_networks')

%cd /Users/erinmunro/Documents/NEURON/neuromorph/collective_data
%cd /usr2/faculty/ecmun/cortcol_networks/collective_data
cd collective_data

weights = weigh_axons(cell_list);
%cd ~/cortcol_networks
cd ..

% how many cells do we need?
n_cols = n_x*n_y + floor(n_y/2);
n_cells = n_cols*n_colcell;

% adjust size of weights to fit n_cells
weights_ad = adjust_weights(weights,n_cells);

% estimate p thresholds
L = mean(weights_ad);
L_2 = sum(weights_ad.^2)/sum(weights_ad);
M = 3*r_c*(r_c+1)*n_colcell + n_colcell-1;
[p_thresh1 p_thresh2] = p_thresholds(p_intra,n_colcell,L,L_2,M)
p_thresh3 = 1/(L^2*M);
p_thresh4 = 3/(L^2*M);
width = p_thresh3-p_thresh2
width_step = width/10

% find rounded p
p_exp = floor(log10(p_thresh2))
w_exp = floor(log10(width_step))
exp_diff = p_exp-w_exp
%p_mant1 = p_thresh1/10^p_exp
p_mant2 = p_thresh2/10^p_exp
p_mant3 = p_thresh3/10^p_exp
p_mant4 = p_thresh4/10^p_exp
w_mant = width_step/10^w_exp

%p_r1 = floor(p_mant1*10^(exp_diff))
p_r2 = ceil(p_mant2*10^(exp_diff))
p_r3 = ceil(p_mant3*10^(exp_diff))
p_r4 = ceil(p_mant4*10^(exp_diff))
w_r = floor(w_mant)
%p = p_r2+w_r:w_r:p_r3+2*w_r
p = p_r3+w_r:w_r:p_r4
p = p*10^(p_exp-(exp_diff))

% generate graphs
for j=1:length(p)
  clear p_curr filename conn ma_conn
  p_curr = p(j)
  [filename, errmsg] = sprintf(...
      'cortcolsimple_L%d-rc%d-pa%g-pe%g-ncc%d-nx%d-ny%d.mat',...
      layer,r_c,p_intra,p_curr,n_colcell,n_x,n_y);
  if add_to_old
    load(filename)
  else
    conn = cell(seedu,1);
    ma_conn = cell(seedu,1);
  end
  
  for k=seedl:seedu
    [conn{k} ma_conn{k}] = connections_cortcolsimple...
        (weights_ad,...
         p_intra,p_curr,r_c,n_x,n_y,n_colcell,k);
  end
  save(filename);
end


exit