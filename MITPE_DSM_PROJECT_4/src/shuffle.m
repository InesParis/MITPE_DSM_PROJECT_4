function Xshuff = shuffle(X)
Xshuff = X;
n = length(X);
for i = 2:n
   j = ceil(i*rand);
   temp      = Xshuff(j);
   Xshuff(j) = Xshuff(i);
   Xshuff(i) = temp;
end