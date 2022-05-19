clc
clear all
cost=[3,11,4,14,15;6,16,18,2,28;10,13,15,19,17;7,12,5,8,9]
cost1=cost;
m=4;
n=5;
basic=m+n-1;
X=-ones(m,n);
a=[15,25,10,15];
b=[20,10,15,15,5];
if sum(a)==sum(b)
    for s=1:basic
        [p,q]=min(cost);
        [u,v]=min(p);
        j=v;
        i=q(j);
        X(i,j)=min(a(i),b(j));
        a(i)=a(i)-X(i,j);
        b(j)=b(j)-X(i,j);
        if a(i)==0 && b(j)~=0
            cost(i,:)=1000;
        elseif a(i)~=0 && b(j)==0
            cost(:,j)=1000;
        elseif a(i)==0 && b(j)==0   
            cost(i,:)=1000;
        end
    end
else
    fprintf('unbalanced TP');
    if sum(a)<sum(b)
        new=zeros(1,n);
        cost=[cost;new];
        m=m+1;
        diff=sum(b)-sum(a);
        a=[a,diff];
    else
        new=zeros(m,1);
        cost=[cost,new];
        n=n+1;
        diff=sum(a)-sum(b);
        b=[b,diff];
    end
    cost1=cost;
    X=-ones(m,n);
    for s=1:basic
        [p,q]=min(cost);
        [u,v]=min(p);
        j=v;
        i=q(j);
        X(i,j)=min(a(i),b(j));
        a(i)=a(i)-X(i,j);
        b(j)=b(j)-X(i,j);
        if a(i)==0 && b(j)~=0
            cost(i,:)=1000;
        elseif a(i)~=0 && b(j)==0
            cost(:,j)=1000;
        elseif a(i)==0 && b(j)==0   
            cost(i,:)=1000;
        end
    end
end
for i=1:m
    for j=1:n
        if X(i,j)<0
            X(i,j)=0;
        end
    end
end
cost1
X
Z=cost1.*X
total_cost=sum(sum(Z))