%   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
% script_DOCUMENTING_Gaussian1DRF_RateCoder_XXX
%   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
%
%______________________________________________________________________
% function_Gaussian1DRF_RateCoder_XXX   (Thanks to Jonathan Pillow)
%    -simulating a single neuron with Gaussian1D filter response (R.F.)
%     relative to the input feature (for example: orientation of bars)
%    -RateCoder: we asume(model) the neuron as having a rate code.
%     therefore the tuning curve is orientation vs rate (firing rate)
%
%______________________________________________________________
% function_Gaussian1DRF_RateCoder_StimProtocol1.m:
%   
%   STIMPROTOCOL 1: 
%   we run several trials on the same orientation,
%   of a fixed length each trial (to get the rate coded response).
%   spaning the entire range covered by the tuning curve
%   as a result we generate a spike train easily analysed because we
%   know the stimuli run at each trial.
%
%   designed and used for simulations where we want to analyse how
%   stimuli encoding changes for example in Neuronal Networks.