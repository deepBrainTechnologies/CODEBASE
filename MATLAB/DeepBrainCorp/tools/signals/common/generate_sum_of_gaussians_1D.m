%%_________________________________________________________________________
%  	
%  function [mixGauss,xVect]  =  generate_sum_of_gaussians_1D(mean1, mean2, std1, std2, A1, A2,x1,x2,dx)
%            
%	returns a mixture of gaussians
%	examples of use: 
%		-signal in temporal/freq domain whose profile corresponds to a sum of 2 gaussians
%		yielding a two peaks signal, skewed gaussian, broadened gaussian, etc.
%    for instance signal comming out from photoreceptor layer into neurons
%    (BC, Horizontal, etc)
%
%    mixGauss = A1Gauss(mean1,std1) + A2Gauss(mean2,std2)
%    defined on the interval xVect (1,[x1:dx:x2])
%   NCMU_Req_1
%
%_________________________________________________________________________
function [mixGauss,xVect] =  ...
  generate_sum_of_gaussians_1D(mean1, mean2, std1, std2, A1, A2,x1,x2,dx)

assert(size(mean1,1)==size(mean1,2)&& ...
       size(mean1,1)==size(mean1,2)&& ...
       size(std1,1)==size(std1,2) && ...
       size(mean1,1)==1, "Generates A1Gauss(mean1,std1) + A2Gauss(mean2,std2) on the interval [x1,dx,x2]");

	xVect = x1:dx:x2; xVect=xVect(:)';
	mixGauss = A1/(std1*sqrt(2*pi))*exp(-1/2*((xVect-mean1)/std1).^2) + ...
		   A2/(std2*sqrt(2*pi))*exp(-1/2*((xVect-mean2)/std2).^2);


end


