
%% flags

simulate_w_based = 1;
simulate_rate_based = 1;

%% weight-based perturbations
if simulate_w_based
      
    dp = .5;
    
    [influence_w] = w_based_perturbation(nids, dp, w);

end

%% - perturbing single neurons in rate-based networks
if simulate_rate_based 
    
    dp = .5;
    noise = .01;
    
    I_stim = .5+.01*cc_sts;
    T_stim = 200;
    T_trans = 50;
    
    rect = 1;
    [influence_r, r1m] = rate_based_perturbation(nids, dp, N_stim, I_stim, T_stim, T_trans, w, dt, tau, rect, noise);

end

%% - functions

% - calculating influence from network weight matrices
function [influence] = w_based_perturbation(nids, dp, w)
    N = length(w);
    L = eye(N)-w;
        
    influence = nan*zeros(length(nids),N);
    for i = 1:length(nids)
        nid = nids(i);
        
        sp = zeros([N,1]);
        sp(nid) = dp;

        r2 = L\sp;

        influence(i,:) = r2 / dp;
        
    end
    
    for i = 1:length(nids)
        influence(i,nids(i)) = nan;
    end

end

% - simulating and calculating influence in rate-based networks
function [influence, rdm] = rate_based_perturbation(nids, dp, N_stim, I_stim, T_stim, T_trans, w, dt, tau, rect, noise)
    % - nids: perturbed neurons
    % - dp: size of perturbation
    
    N = length(w);
    T_tot = T_stim+T_trans;
    T = 0:dt:T_tot;
    
    r0m_all = nan*zeros(length(nids),N,N_stim);
    rpm_all = nan*zeros(length(nids),N,N_stim);
    
    % - obtaining perturbed rates
    for ij = 1:N_stim
        
        I0 = I_stim(ij,:)' + rand(N,length(T))*noise;
        r0 = simulate_dynamics(I0, T, w, dt, tau, rect);
                
        for i = 1:length(nids)
            nid = nids(i);

            r0m_all(i,:,ij) = nanmean(r0(:,T>T_trans),2);
            
            Ip = I_stim(ij,:)' + rand(N,length(T))*noise;
            Ip(nid,:) = Ip(nid,:) + dp;
            rp = simulate_dynamics(Ip, T, w, dt, tau, rect);
            rpm_all(i,:,ij) = nanmean(rp(:,T>T_trans),2);   

        end
    end
    
    rdm = rpm_all - r0m_all;
    
    % - calculating the influence
    influence = squeeze(nanmean(rpm_all,3) - nanmean(r0m_all,3))/dp;
    
    for i = 1:length(nids)
        influence(i,nids(i)) = nan;
    end
            
end

% - simulating dynamics of rate-based networks
function [r] = simulate_dynamics(I, T, w, dt, tau, rect)
    N = length(w);
    r = zeros(N, length(T));
    for i = 1:length(T)-1
        inp = w' * r(:,i) + I(:,i);
        rd = -r(:,i) + NL(inp, rect);
        r(:,i+1) = r(:,i) + dt/tau * rd;
    end
end

% - nonlinearity of neuronal transfer functions (rectification by default)
function [zo] = NL(zi, rect)
    zo = zi;
    if rect
    zo(zo < 0) = 0;
    end
    zo = zo.^1;
end
