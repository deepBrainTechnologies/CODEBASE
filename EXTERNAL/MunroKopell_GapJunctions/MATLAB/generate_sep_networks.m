function generate_sep_networks(cell_list,layer,p_intra,r_c,n_x,n_y, ...
                               n_colcell,seedl,seedu,add_to_old)
% generate connections_corcolsimple networks varying:
% p_inter, r_c
% around the threshold for a large cluster for seeds seedl:seedu.
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

sl = seedl
su = seedu

weights = weigh_axons(cell_list);
%cd ~/cortcol_networks
cd ..

% how many cells do we need?
n_cols = n_x*n_y + floor(n_y/2);
n_cells = n_cols*n_colcell;

% estimate p thresholds
L = mean(weights);
L_2 = sum(weights.^2)/sum(weights);
M = 3*r_c*(r_c+1)*n_colcell + n_colcell-1;
p_thresh1 = 1/(L^2*M)
p_thresh2 = 1/(L*L_2*M)
width = p_thresh1
width_step = width/10

% find rounded p
p_exp = floor(log10(p_thresh1))
w_exp = floor(log10(width_step))
exp_diff = p_exp-w_exp
p_mant1 = p_thresh1/10^p_exp
p_mant2 = p_thresh2/10^p_exp
w_mant = width_step/10^w_exp

p_r1 = ceil(p_mant1*10^(exp_diff))
p_r2 = ceil(p_mant2*10^(exp_diff))
w_r = floor(w_mant)
p = (w_r/4):(w_r/4):(p_r2/2);
p = [p (p_r2/2):w_r:p_r1];
p = unique(p)
p = p*10^(p_exp-(exp_diff))

% generate graphs
for j=1:length(p)
  clear p_curr filename conn ma_conn
  p_curr = p(j)
  [filename, errmsg] = sprintf(...
      'cortcolsimple_L%d-rc%d-pa%g-pe%g-ncc%d-nx%d-ny%d.mat',...
      p_intra,layer,r_c,p_intra,p_curr,n_colcell,n_x,n_y)
  if add_to_old && exist(filename,'file')
    fprintf(1,'loading %s\n',filename);
    load(filename)
  else
    fprintf(1,'starting anew\n')
    conn = cell(seedu,1);
    ma_conn = cell(seedu,1);
  end
  
  for k=sl:su
    k
    [conn{k} ma_conn{k}] = connections_cortcolsimple2...
        (weights,p_intra,p_curr,r_c,n_x,n_y,n_colcell,k);
  end
  if add_to_old
    save(filename,'weights','n_cols','n_cells','L','L_2','M',...
         'p_thresh1','p_thresh2','p','p_curr','conn','ma_conn');
  else
    save(filename)
  end
end


exit