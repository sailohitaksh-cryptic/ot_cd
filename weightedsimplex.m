clc
clear
k=2;%no of equations
nv=3;
m=2;
ob1=[3 2 4];
ob2=[1 5 3];
c=(ob1+ob2)/k;
A=[2 4 1;1 5 3];
b=[8;15];
sign=[1 -1];
S=eye(m);
for i = 1:m
if sign(i) < 0
S(i,i) = -S(i,i);
else if sign(i) == 0
S(i,i) = 0;
end
end
end
Anew = [A S]   %combining slack or surplus variables to initial A.
n = length(Anew)  % number of columns in the Anew.
Afinal = Anew;
%removing the variable with zero coeffients in all equations.
index = 0;
for i = 1:n
if Anew(:,i) == 0
rm = i - index
Afinal(:,rm) = [];
index = index + 1;
end
end
Afinal
n = length(Afinal);
cadd = zeros(1, n - nv);
cnew = [c cadd];
%%%%%%%%%%%%%%Finding initial Basic Feasible Solution%%%%%%%%%%%%%%%%
Cnumber=nchoosek(n,m); % this command computes number of combinations
D=nchoosek(1:n,m); % this command lists all the combinations of m
fs=[]; % empty matrix storing feasible solutions
Z=[]; % empty vector storing the values of objective function at
ifs=[]; % empty matrix storing infeasible solutions
dgfs=[]; % empty matrix storing degenerate feasible solutions
for i=1:Cnumber
index=D(i,:); % picking up combinations one by one
X=zeros(n,1); % initializing solution with zero values
B=[]; % empty basis matrix
i
for j=1:m
B=[B Afinal(:,index(j))]; % putting columns of chosen combination
end
tolerance=10^(-7);
if abs(det(B))< tolerance
disp('change the basis matrix') % if matrix is ill-conditioned or
else
Y=inv(B)*b; % solution computation of square system
X(index)=Y; % placing the values of basic variables in original vector
X
if X>=0 % checking feasibility
break
end
end
end
cb = cnew(index)'
mat = [cb Afinal b]


n=length(Afinal);% Number of variables
c= cnew;
A= Afinal;

for s=1:100 % number of iterations
B=[];
for j=1:m
B=[ B A(:,index(j))]; % computing basis matrix
end
tolerance=10^-7;
if abs(det(B))<tolerance
disp('change basis matrix');
end

cb=c(index); % cost of basic variables
Xb=inv(B)*b; % basic solution
if nnz(Xb)< m % checking degeneracy
disp('degenerate bfs')
Xb
index
end
z=cb*Xb; %computing objective function value
Y=inv(B)*A; % computing column vectors of all variables
NE=cb*Y-c; % computing net evaluations
%optimality check
if NE>=0 % for max problem, sign will be changed for min problem
disp('optimality declared');
Xb
index
z
break
else % if optimality not declared
%choose entering variable
[a,EV]= min(NE);
%choose leaving variable
for j=1:m
if Y(j,EV)>0
ratio(j)=Xb(j)/Y(j,EV); % selecting only positive pivots
else
ratio(j)= 10^8;
end
end
if min(ratio)==10^8 % this would happen if no positive pivots are
%there in column of entering variable
disp('Lpp is unbounded')
else
[k,LV]=min(ratio);
index(LV)=EV;% replacing leaving variable with entering
end
end
end