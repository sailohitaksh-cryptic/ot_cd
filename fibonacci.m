format short
clear all
clc
f=@(x) x.*(x-2);
n=3;
L=0;
R=1.5;
t=linspace(L,R,100)
plot(t,f(t))
fib=ones(1,n);
for i=3:n+1
    fib(i)=fib(i-1)+fib(i-2);
end
for k=1:n
    ratio=fib(n+1-k)/fib(n+2-k);
    x2=L+ratio.*(R-L);
    x1=L+R-x2;
    fx1=f(x1);
    fx2=f(x2);
    resl(k,:)=[L R x1 x2 fx1 fx2];
    if(fx1<fx2)
        R=x2;
    elseif(fx2<fx1)
        L=x1;
    else
        if min(abs(x1),abs(L))==abs(L)
            R=x2;
        else
            L=x1;
        end
    end
end

res=array2table(resl);
var={'L','R','x1','x2','fx1','fx2'};
res.Properties.VariableNames(1:size(res,2))=var;
xopt=(L+R)/2
opt_val=f(xopt)