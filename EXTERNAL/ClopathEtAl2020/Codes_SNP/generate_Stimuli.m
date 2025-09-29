
%% - generate stimuli

locs_stim = zeros(N_stim, 2);

po_stim = linspace(0,pi,N_stim);
po_stim = po_stim(randperm(N_stim));

sigmas_stim = 25*ones([1, N_stim]);
gammas_stim = .5*ones([1, N_stim]);

psis_stim = zeros(1,N_stim);       

sfs_stim = gamrnd(2, 1, [1, N_stim]) * .04; 

stims = zeros(N_stim, sz, sz);
for i = 1:N_stim
    rf = Gabor_fields(sigmas_stim(i), gammas_stim(i), psis_stim(i), 1/sfs_stim(i), ...
        po_stim(i), locs_stim(i,:), ppd, vf_size);
    stims(i,:,:) = rf(1:sz,1:sz);
end

cc_sts = corr(reshape(stims, N_stim, [])', reshape(RFs, N, [])');

% - stimuli ALL
locs_stim = zeros(N_stim_all, 2);

po_stim = linspace(0,pi,N_stim_all);
po_stim = po_stim(randperm(N_stim_all));

sigmas_stim = 25*ones([1, N_stim_all]);
gammas_stim = .5*ones([1, N_stim_all]);

psis_stim = rand(1,N_stim_all) * 2*pi; %[0, pi];%pi/2, pi, 3*pi/4];        

sfs_stim = gamrnd(2, 1, [1, N_stim_all]) * .04; 

stims = zeros(N_stim_all, sz, sz);
for i = 1:N_stim_all
    rf = Gabor_fields(sigmas_stim(i), gammas_stim(i), psis_stim(i), 1/sfs_stim(i), ...
        po_stim(i), locs_stim(i,:), ppd, vf_size);
    stims(i,:,:) = rf(1:sz,1:sz);
end

cc_sts_all = corr(reshape(stims, N_stim_all, [])', reshape(RFs, N, [])');

cc_resp = corr(cc_sts_all, 'rows', 'complete');
  
