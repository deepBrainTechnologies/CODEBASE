function [conn ma_conn] = ...
	connections_cortcolsimple(weights,p_intra,p_inter,r_c,...
	n_x,n_y,n_colcells,seed)
% Establishes connections between cells
% 1) on main axons within cortical columns, and
% 2) on collaterals 
% "weights" is an array of cell weights
%   - length of unmyelinated axon in um
% "p_intra" - probability that 2 main axons are connected within a cortical
% column on the IS
% "p_inter" - proabability that 2 1-um collateral sections are connected 
% on an unmyelinated section of axon
% "r_c" - maximum distance between connected cell somata on the grid
% "n_x", "n_y" - number of rows and columns in hexagonal grid
% "n_colcells" - number of cells in a single cortical column
% ma_conn gives connection on main axon

% set the seed for the random number generator for repeatability
%stream = RandStream.getDefaultStream;
%stream.reset; % reset stream to initial internal state
rand('seed',seed)

% how many cells do we need?
n_cols = n_x*n_y + floor(n_y/2);
n_cells = n_cols*n_colcells;
conn = cell(n_cells,1);
ma_conn = cell(n_cells,1);

% set weights for whole network so that their chosen randomly from 'weights'
weights_ad = set_weights(weights,n_cells);

% for each cortical column, randomly set connections between cells
for i=1:n_cols
  rand_matrix = rand(n_colcells);
  connections = (rand_matrix<=p_intra);
  % take out self and double connections 
  connections = triu(connections,1);
  conn_ind = find(connections);
  for j=1:length(conn_ind)
    % translate index in conn_ind into row and column
    c1 = floor((conn_ind(j)-1)/n_colcells) + 1; % column
    c2 = mod(conn_ind(j)-1,n_colcells) + 1; % row
    
    % get cell ID based on which columns we're in
    cell1 = c1 + n_colcells*(i-1);
    cell2 = c2 + n_colcells*(i-1);
    % connect cells
    conn{cell1} = [conn{cell1} cell2];
    conn{cell2} = [conn{cell2} cell1];
    ma_conn{cell1} = [ma_conn{cell1} cell2];
    ma_conn{cell2} = [ma_conn{cell2} cell1];
  end
end

% set connections on unmyelinated axon collaterals between (and within)
% cortical columns

% give every cell coordinates in the Cartesian plane
% first cell is at (0,0)
% x-coord counts off by 2 units in positive direction 
% x-coord is even for all cells in even rows, odd for odd rows
% y-coord counts up by 1, but understood to be multiple of sqrrt(3)
% in Cartesian plane.
coord_list = zeros(n_cols,2);
x_coord = 0;
y_coord = 0;
max_x_coord = n_x*2-1;
for i=1:n_cols
  coord_list(i,:) = [x_coord y_coord];
  x_coord = x_coord + 2;
  
  if x_coord>max_x_coord
    y_coord = y_coord + 1;
    if mod(y_coord,2)==0 % even row
      x_coord = 0;
    else
      x_coord = -1;
    end
  end
end
cl = coord_list;

% relative indexes of cells r_c from (0,0) for all columns past this one
d = 2*r_c;
xmax = ceil(d);
ymax = ceil(d/(sqrt(3)));
i=1;
for x=0:2:xmax
  if x<=d
    rc_list(i,:)= [x 0];
    i = i+1;
  end
end
for y=2:2:ymax % even rows
  for x=[0:2:d -(2:2:d)]
    if sqrt(x^2+3*y^2)<=d
      rc_list(i,:)= [x y];
      i = i+1;
    end
  end
end
for y=1:2:ymax
  for x=[1:2:d -(1:2:d)]
    if sqrt(x^2 + 3*y^2)<=d
      rc_list(i,:) = [x y];
      i = i+1;
    end
  end
end
src = size(rc_list);
rc = rc_list;

% set connections between unmyelinated sections
for i=1:n_cols
  col1 = i;
  col1_coords = coord_list(i,:);
  for j=1:src(1)
    col2_coords = col1_coords+rc_list(j,:);
    if coord_in_bounds(col2_coords,n_x,n_y)
      col2 = coord_to_col(col2_coords,n_x);
      cells1 = (col1-1)*n_colcells + (1:n_colcells);
      cells2 = (col2-1)*n_colcells + (1:n_colcells);
      
      rand_matrix = rand(n_colcells);
      p = 1 - exp(-p_inter*diag(weights_ad(cells2))*...
                  ones(n_colcells)*diag(weights_ad(cells1)));
      % cells1(1) mult. along 1st col, cells2(1) mult along 1st row
      connections = (rand_matrix<=p);
      if col1==col2 % same columns
                    % remove self and double connections
        connections = triu(connections,1);
      else % only remove double connections
        connections = triu(connections,0);
      end
      conn_ind = find(connections);
      
      for k=1:length(conn_ind)
        % translate index in conn_ind into row and column
        c1 = floor((conn_ind(k)-1)/n_colcells) + 1; % column
        c2 = mod(conn_ind(k)-1,n_colcells) + 1; % row
        
        % get cell ID based on which columns we're in
        cell1 = cells1(c1);
        cell2 = cells2(c2);
        if ~any(conn{cell1}==cell2)
          % connect cells
          conn{cell1} = [conn{cell1} cell2];
          conn{cell2} = [conn{cell2} cell1];
        else % cells are already connected on the IS
          % remove them from ma_conn to show that connection stays
          ma_conn{cell1} = setdiff(ma_conn{cell1},cell2);
          ma_conn{cell2} = setdiff(ma_conn{cell2},cell1);
        end
      end %k=1:length(conn_ind)
      
    end %coord_in_bounds(col2_coords,n_x,n_y)
  end %j=1:length(rc_list)
end %i=1:n_cols



% subfunctions -----------------------------------------

function in_bounds = coord_in_bounds(coord,n_x,n_y)
% Are the given coordinates in the network?
% This assumes that the coordinates are on a hexagonal grid.

x = coord(1);
y = coord(2);
max_x_coord = 2*n_x-1;
in_bounds = 1;
if y>n_y-1
	in_bounds = 0;
elseif y<0;
	in_bounds = 0;
elseif x>max_x_coord
	in_bounds = 0;
elseif x<-1
	in_bounds = 0;
end
