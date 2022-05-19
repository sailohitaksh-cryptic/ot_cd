format short 
clear all
clc
cost=[3 11 4 14 15;6 16 18 2 28;10 13 15 19 17;7 12 5 8 9];
A=[15 25 10 15];
B=[20 10 15 15 5];
[m,n]=size(cost);
bfs=m+n-1;
if(sum(A)-sum(B)==0)
    fprintf('Solution is feasible')
else
    if(sum(A)>sum(B))
        cost(:,end+1)=zeros(1,size(A,2));
        B(end+1)=sum(A)-sum(B);
    else
        cost(end+1,:)=zeros(1,size(A,2));
        A(end+1)=sum(B)-sum(A);
    end
end
X=zeros(size(cost));
icost=cost;
for i=1:size(cost,1)
    for j=1:size(cost,2)
        hh=min(cost(:));
        [rowind,colind]=find(hh==cost);
        x11=min(A(rowind),B(colind));
        [val,ind]=max(x11);
        ii=rowind(ind);
        jj=colind(ind);
        y11=min(A(ii),B(jj));
        X(ii,jj)=y11;
        A(ii)=A(ii)-y11;
        B(jj)=B(jj)-y11;
        cost(ii,jj)=Inf;
    end
end
ib=array2table(X);
disp(ib);
totbfs=length(nonzeros(X));
if totbfs==bfs
    fprintf('non-degenerate');
else
    fprintf('degenerate');
end
c=sum(sum(icost.*X))