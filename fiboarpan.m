clc;
format long;
clear all
f=@(x)((x^3)+(8*x*x)+(3*x)+5);
b=0;
a=-1;
l=b-a;
I_of_un=0.25*l;
eps=I_of_un/l;
val=1/eps;
n=0;
for i=1:100000
    if(fibonacci(i)>=val)
        n=i;
        break;
    end
    i=i+1;
end

for i=n:-1:2
    x1=a+((fibonacci(i-2))*l/fibonacci(i));
    x2=a+((fibonacci(i-1)*l/fibonacci(i)));
    if(f(x1)>f(x2))
        a=x1;
    elseif(f(x1)<f(x2))
        b=x2;
    elseif(f(x1)==f(x2))
        a=x1;
        b=x2;
    end
    a
    b
    l=b-a;
end
x1=x1+0.05
x2
disp('point of minima is ');
(x1+x2)/2
