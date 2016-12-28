% G = digraph({'A' 'B' 'C'}, {'D' 'C' 'D'}, [10 20 45]);
% G = addedge(G, {'A' 'D' 'E'}, {'E' 'B' 'D'}, [5 30 5]);

A = [0 1 2; 1 0 3; 2 3 0];
node_names = {'A','B','C'};
G = graph(A,node_names);