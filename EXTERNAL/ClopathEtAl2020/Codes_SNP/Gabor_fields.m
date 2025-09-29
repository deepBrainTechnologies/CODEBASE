%% - functions
function gb=Gabor_fields(sigma,gamma,psi,lambda,theta,loc,ppd,vf_size)
sz = vf_size*ppd; % size in pixels

sigma = sigma * ppd;
lambda = lambda * ppd;

loc = loc*ppd;

sigma_x = sigma;
sigma_y = sigma/gamma;
 
[x, y]=meshgrid(-fix(sz/2):fix(sz/2),fix(sz/2):-1:fix(-sz/2));

% Rotation 
x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);
 
gb0 = exp(-0.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lambda*x_theta+psi);

gb = imtranslate(gb0, loc);

end