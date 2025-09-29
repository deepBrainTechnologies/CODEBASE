function w = weigh_tree(axon,top)
% give the total length of subtree on axon starting with "top" comaprtment
% given in MATLAB

w = 0;

to_search = top;
while ~isempty(to_search)
	w = w + axon.L(to_search(1));
	to_search = [to_search axon.children{to_search(1)}];
	to_search = to_search(2:end);
end
