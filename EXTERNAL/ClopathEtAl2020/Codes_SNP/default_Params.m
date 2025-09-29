
%% - network parameters

% - receptive field (RF) params
ppd = 4; % resolution (pixel per degree)
vf_size = 50; % visual field size (in degrees)
sz = vf_size*ppd; % visual size (in pixels)
    
N_stim_all = 1000;
N_stim = 1;

% - network and connectivity params
NE = 400;
NI = 400;
N = NE+NI;

J0 = 1/NE;
JEE = J0;
JEI = 2*J0;
JIE = -2*J0;
JII = -2*J0;

exp_pwr = 2;

% - simulation params
dt = 1;
tau = 10;

% - neuron ids to perturb
N_pert = 400;

% - random sample to perturb
generate_random_set = 1;
if generate_random_set
    nids = 1:NE;
    nids = nids(randperm(NE));
    nids = nids(1:N_pert);
end

% - a sample reference RF
nids_smpl = nids([1]);
