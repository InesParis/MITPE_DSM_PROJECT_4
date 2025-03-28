function intervals = partition(N)
part0 = [0; sort(rand(N-1,1))];
part1 = [part0(2:N); 1];
intervals = part1 - part0;