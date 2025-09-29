function [p_thresh1 p_thresh2] = p_thresholds(p_intra,n_colcell,L,L_2,M)
 % give the thresholds for p so that it is possible to break up the
 % network
   
   p_thresh1 = (1-p_intra*(n_colcell-1))/(L^2*M);
   p_thresh2 = 1/(L*L_2*M);