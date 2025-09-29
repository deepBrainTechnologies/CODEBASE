%__________________________________________________________________________
%
% function post_syn_out = ...
%		generate_Synapse_1stLevel_simplified(pre_syn_in,TYPE_Corr,
%                                         probabilities,delays,jitters)
%
%
%
%   NCMU_Req_2A
%__________________________________________________________________________
function post_syn_out = ...
		generate_Synapse_1stLevel_simplified(pre_syn_in,TYPE_Corr, probabilities,delays,jitters)

#define Delayed


nSpikes = length(pre_syn_in);
pre_syn_in = pre_syn_in(:)';   %[1 x nSpikes]
nDelayedCopies = length(probabilities);
probabilities = probabilities(:)';     %[1 x nProbabilities]
delays = delays(:)';                   %[1 x nDelays]
jitters = jitters(:)';                 %[1 x nJitters]

assert(length(delays)==length(jitters) && length(jitters)==nDelayedCopies, ...
	"number of probabilities, delays and jitters must be the same);

switch  TYPE_Corr
	
  case
    Delayed:
		probabilityArray = repmat(probabilities',[1 nSpikes])> rand(nDelayedCopies,nSpikes);
		post_syn_out = repmat(post_syn_out,[nDelayedCopies 1]) + ...
				  repmat(delays',[1 nSpikes]) + ...
				  repmat(jitters',[1 nSpikes]);
		
		
end
end

