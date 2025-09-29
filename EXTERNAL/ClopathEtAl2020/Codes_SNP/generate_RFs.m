
%% - make receptive fields

locs = (rand(N, 2)-.5)*(sz/20) ;

po_exc = linspace(0,pi,NE);
po_inh = linspace(0,pi,NI);
po_all = [po_exc, po_inh];

sigmas = 2.5*ones([1, N]);
sigmas(NE+1:end) = 2.5*ones([1, NI]);
gammas = .5*ones([1, N]);

psis = rand(1,N) * 2*pi;         

sfs_exc = gamrnd(2, 1, [1, NE]) * .04; 
sfs_inh = gamrnd(2, 1, [1, NI]) * .02; 
sfs = [sfs_exc, sfs_inh];

RFs = zeros(N, sz, sz);

% - exc
for i = 1:NE
    rf = Gabor_fields(sigmas(i), gammas(i), psis(i), 1/sfs(i), po_all(i), locs(i,:), ppd, vf_size);
    RFs(i,:,:) = rf(1:sz,1:sz);
end

% - inh
for i = NE+1:N
    rf = Gabor_fields(sigmas(i), gammas(i), psis(i), 1/sfs(i), po_all(i), locs(i,:), ppd, vf_size);
    RFs(i,:,:) = rf(1:sz,1:sz);
end

cc_rfs = corr(reshape(RFs, N, [])');

dpo_all = zeros(N);
for i = 1:N
    dpo_all(i,:) = mod(po_all(i)-po_all, pi);
end  
