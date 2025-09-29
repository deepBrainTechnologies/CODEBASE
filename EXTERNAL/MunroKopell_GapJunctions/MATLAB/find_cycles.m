function cycles = find_cycles(conn,node,cycles_through_node)
% give histogram of cycle length
% cycles is a list where each row gives
% [cycle_length #cycles_with_that_length]
% if cycles_through_node==1, only list cycles through node
% Note: lists cycles twice. If cycles go through node, the cycle is 
% counted for each outgoing neighbor. If the cycle does not go through
% node, it is counted on branch where cycle is found twice.
% Note: this assumes that node has more than one connection!!

lc = length(conn);

% Make a spanning tree centered around node
% where each vertex in the tree is placed so that
% its shortest distance in graph is its distance to node.
% Keep previous vertex
% Keep address for each vertex based on branch points.
% Keep distance from each vertex to closest branch point.
% Flag for branch when just AFTER branch node to tell
%    which direction to go from tree

E_tree = []; % edges in tree
E_cycle = []; % edges that make a cycle
% 1st_address1 1st_address2 cell1 cell2

rank_tree = struct('prev',cell(lc,1),'address',cell(lc,1),...
	'dist',cell(lc,1),'branch',cell(lc,1));

S = []; % searched
R= node; %reached
rank_tree(node) = struct('prev',0,'address',[],....
	'dist',0,'branch',0);

while ~isempty(R)
  %fprintf(1,'current cell: %d\n',R(1));
  nc = length(conn{R(1)});
  % decide if we are at branching point,
  % make note to add address if we are
  if nc-length(intersect([R S],conn{R(1)}))>=2
    branch_node = 1;
  else
    branch_node = 0;
  end
  for k=1:length(conn{R(1)})
    if isempty(find([R S]==conn{R(1)}(k),1))
      %fprintf(1,'not reached yet: %d\n',conn{R(1)}(k));
      R = [R conn{R(1)}(k)];
      rank_tree(conn{R(1)}(k)).prev = R(1);
      
      % is R(1) part of the address, 
      % i.e. branch of previous branch point?
      if rank_tree(R(1)).branch
        rank_tree(conn{R(1)}(k)).dist = 1;
        rank_tree(conn{R(1)}(k)).address = ...
            [rank_tree(R(1)).address R(1)];
      else
        rank_tree(conn{R(1)}(k)).dist = ...
            rank_tree(R(1)).dist + 1;
        rank_tree(conn{R(1)}(k)).address = ...
            rank_tree(R(1)).address;
      end
      if branch_node
        rank_tree(conn{R(1)}(k)).branch = 1;
      else
        rank_tree(conn{R(1)}(k)).branch = 0;
      end
    elseif conn{R(1)}(k) ~= rank_tree(R(1)).prev
      %fprintf(1,'already in tree: %d\n',conn{R(1)}(k));
      % Neighbor is already in tree, so add edge to E_cycle if it's not
      % already there. Add edges listing lower node first so that 
      % they're easier to find.
      if R(1)<=conn{R(1)}(k) 
        %fprintf(1,'%d <= %d\n',R(1),conn{R(1)}(k));
        if isempty(E_cycle) || ...
              ~any(E_cycle(:,3)==R(1) & E_cycle(:,4)==conn{R(1)}(k))
          % edge not in E_cycle yet
          E_cycle = [E_cycle; branch(R(1),rank_tree)...
                     branch(conn{R(1)}(k),rank_tree)...
                     R(1) conn{R(1)}(k)];
          % fprintf(1,'1 - added cycle edge: %d %d %d %d\n',...
          % branch(R(1),rank_tree),...
          % branch(conn{R(1)}(k),rank_tree),...
          % R(1), conn{R(1)}(k));
        end
      else % R(1) > conn{R(1)}(k)
           %fprintf(1,'%d > %d\n',R(1),conn{R(1)}(k));
        if isempty(E_cycle) || ...
              ~any(E_cycle(:,4)==R(1) &	E_cycle(:,3)==conn{R(1)}(k))
          % edge not in E_cycle yet
          E_cycle = [E_cycle; ...
                     branch(conn{R(1)}(k),rank_tree)...
                     branch(R(1),rank_tree)...
                     conn{R(1)}(k) R(1)];
          % fprintf(1,'2 - added cycle edge: %d %d %d %d\n',...
          % branch(conn{R(1)}(k),rank_tree),...
          % branch(R(1),rank_tree),...
          % conn{R(1)}(k),R(1));
        end
      end
    end
  end
  S = [S R(1)];
  R = R(2:length(R));
end

% for i=1:length(conn)
% 	fprintf(1,'%d: address=[',i)
% 	for j=1:length(rank_tree(i).address)
% 		fprintf(1,'%d ',rank_tree(i).address(j))
% 	end
% 	fprintf(1,'], dist=%d\n',rank_tree(i).dist);
% end
% Cycles going through node are made from combinations
% of edges in E_cycle. First, compute cycles with 
% one extra edge
%fprintf(1,'length E_cycle = %d\n',length(E_cycle(:,1)));
n_branches = length(conn{node});
sE = size(E_cycle);
cycles = cell(n_branches,1);
%E = E_cycle;

for i=1:sE(1)
  dist = zeros(4,1);
  if ~cycles_through_node && E_cycle(i,1)==E_cycle(i,2)
    % cycle is on same branch, doesn't go through node
    %fprintf(1,'edge is on single branch: %d %d %d %d\n',E_cycle(i,1),...
    %	E_cycle(i,2),E_cycle(i,3),E_cycle(i,4));
    merge_ind = length(intersect(rank_tree(E_cycle(i,3)).address,...
                                 rank_tree(E_cycle(i,4)).address)) + 1;
    for j=3:4
      if merge_ind<=length(rank_tree(E_cycle(i,j)).address)
        dist(j) = rank_tree(E_cycle(i,j)).dist;
      else
        dist(j) = 0;
      end
      %fprintf(1,'node dist = %d\n',dist(j));
      for k=(merge_ind+1):length(rank_tree(E_cycle(i,j)).address)
        stop = rank_tree(E_cycle(i,j)).address(k);
        dist(j) = dist(j) + rank_tree(stop).dist;
        %fprintf(1,'%d dist = %d\n',stop,rank_tree(stop).dist);
      end
    end
    cycle_length = sum(dist) + 3;
  elseif E_cycle(i,1) ~= E_cycle(i,2)
    for j=3:4
      dist(j) = rank_tree(E_cycle(i,j)).dist;
      for k=1:length(rank_tree(E_cycle(i,j)).address);
        stop = rank_tree(E_cycle(i,j)).address(k);
        dist(j) = dist(j)+rank_tree(stop).dist;
      end
    end
    cycle_length = sum(dist)+1;
  else % cycles_through_node==1
    continue;
  end
  
  for j=1:2
    %fprintf('starting branch for E_cycle is %d\n',E_cycle(i,j))
    branch_ind = find(conn{node}==E_cycle(i,j),1);
    sc = size(cycles{branch_ind});
    if sc(1)>0
      cycle_ind = find(cycles{branch_ind}(:,1)...
                       ==cycle_length,1);
      % cycle_ind could be empty if no cycles of this length yet
    else
      cycle_ind = [];
    end
    if isempty(cycle_ind)
      cycles{branch_ind} = [cycles{branch_ind};...
                          cycle_length 1];
    else
      cycles{branch_ind}(cycle_ind,2) = ...
          cycles{branch_ind}(cycle_ind,2)+1;
    end
  end %j=1:2
end %i=1:sE(1)


% subfunctions --------------------------------------------

function b=branch(cell,rank_tree)
% give branch of cell based on address

if isempty(rank_tree(cell).address)
	b = cell;
else
	b=rank_tree(cell).address(1);
end
