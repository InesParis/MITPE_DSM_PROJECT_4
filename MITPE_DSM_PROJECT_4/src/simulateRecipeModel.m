function [time,cost] = simulateRecipeModel(DSM,kmax,tmax)

%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
% Setup
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
% These variables are each of length nx1 and represent state variables
% characterizing the current list of costs:
%
%    costList  = current cost of each component
%    pList     = probabilities that choosing a particular component will
%                result in a cost reduction
%    qList     = pList normalized so elements sum to 1
%    qSumList  = cumulative sum of qList
%
% These variables contain histories giving the evolution of costs over
% time:
%
%    cost = cost at kth improvement
%    Dt   = time between k-1th and kth improvement

% Get DSM properties.
n     = length(DSM);
dList = sum(DSM)';

costList  = zeros(n,1);
pList     = zeros(n,1);
qList     = zeros(n,1);
fList     = zeros(n,1);
cost      = zeros(kmax,1);
Dt        = zeros(kmax,1);

% Set initial condition.
costList(:) = rand(n,1);
costList    = costList / sum(costList);
cost(1)     = sum(costList);
Dt(1)       = 0;
               
% Initialize important probability variables.
CList    = DSM' * costList;
pList    = (n*CList).^dList ./ factorial(dList);
qList    = pList / sum(pList);
qSumList = cumsum(qList);

%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
% Simulation: Slow algorithm
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
k = 2;
slow_method = true;
while slow_method == true
   Dt(k) = Dt(k) + 1;
   
   % Choose a random component.
   i = ceil(n*rand);
   
   % Generate a new random cost for the affected list.
   Ci           = DSM(:,i);
   di           = dList(i);
   ci_cur       = sum( costList(Ci) );
   CiNew        = (1/n) * rand(di,1);
   ci_new       = sum( CiNew );
   if ci_new < ci_cur
      costList(Ci) = CiNew;
      cost(k)      = sum( costList );
      k            = k+1;
   end
     
   % Test to see if fast algorithm can be applied.
   CList = DSM'*costList;
   if all( CList < 1/n )
      slow_method = false;
   end
end

%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
% Simulation: Fast algorithm
%=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%
k = k - 1;
time = cumsum(Dt);

% Update component picking probabilities.
CList     = DSM'*costList;
pList     = (n*CList).^dList ./ factorial(dList);
qList     = pList / sum(pList);
qSumList  = cumsum(qList);

% Execute fast algorithm.
while time(k) < tmax
   k = k + 1;
   
   % Pick the component i responsible for the kth improvement.
   r = rand;               
   i = 1;                  
   while r > qSumList(i); 
      i = i+1;             
   end
   
   % Generate a random lower cost for the affected set of i, Ci.
   Ci           = DSM(:,i);                     
   di           = dList(i);
   ci_cur       = sum( costList(Ci) );          
   ci_new       = ci_cur * rand^(1/di);         
   costList(Ci) = ci_new * partition(di);       
   cost(k)      = sum( costList );              
   
   % Generate time Dt taken to produce the improvement.
   p_accept = sum(pList / n);
   Dt(k)    = 1 + geornd( p_accept );
   time(k)  = time(k-1) + Dt(k);
   
   % Update component picking probabilities.
   CList    = DSM'*costList;
   pList    = (n*CList).^dList ./ factorial(dList);
   qList    = pList / sum(pList);
   qSumList = cumsum(qList);
end