function weights_ad = adjust_weights(weights,n_cells)
% set the weights for n_cells cells so that they are chosen randomly from
% 'weights'

% expand weights accordingly
lw = length(weights);
weights_ad = zeros(n_cells,1);

for j=1:n_cells
  r = rand;
  weights_ad(j) = weights(ceil(r*lw));
end

