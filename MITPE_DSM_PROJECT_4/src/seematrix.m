function seematrix(M)
% Identify type of matrix.
num_symbols = length(unique(M));
binary = (num_symbols <= 2);

if binary
   map = [[1 1 1]   % black
          [0 0 0]]; % white
   colormap(map)
   image(M + 1, 'CDataMapping', 'direct')
else
   colormap('default')
   image(M, 'CDataMapping', 'scaled')
   set(gca, 'TickLength', [0 0])
   colorbar('EastOutside', 'Box', 'on')
end
set(gca, 'DataAspectRatio', [1 1 1])
set(gca, 'XAxisLocation', 'top')
set(gca, 'FontSize', 12)