
% - load deault parameters
default_Params;

% - generte receptive fields (RFs), stimuli, and connection weights
generate_RFs;
generate_Stimuli;
generate_Weights;

% - simulate single-neuron perturbations 
% (in rate-based networks and from the weight matrix)
simulate_Perturb;

% - visualize the results and plot some sample figures
plot_pert_sample;
