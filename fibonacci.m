clc
clear
f=@(x) x*(x-2);
a=0;b=1.5;n=4
for i=3:n+1
    F(1)=1;
    F(2)=1;
    F(i)=F(i-1)+F(i-2);
end
for i=n+1:-1:3
    x1=a+(F(i-2)/F(i))*(b-a);
    x2=b-(F(i-2)/F(i))*(b-a);
    fx1=f(x1);
    fx2=f(x2);
    table=[a b x1 x2 f(x1) f(x2)]
    if f(x1)>f(x2)
        a=x1
        table=[a b x1 x2 f(x1) f(x2)]
    else
        b=x2
        table=[a b x1 x2 f(x1) f(x2)]
    end
end
opt_pt=(a+b)/2
opt_val=f(opt_pt)