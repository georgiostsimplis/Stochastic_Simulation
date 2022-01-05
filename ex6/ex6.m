clc; clear;
w=metropolis';
figure(1)
histogram(w);
[w1,w2]=metropolis2();
figure(2)
hist3([w1',w2'],'CDataMode','auto','FaceColor','interp')


function X=metropolis()
n=10000;
A=8;
X=zeros(1,n);
for i=1:(n-1)
    xp=randi([0,10]);
    fx=(A^xp)/factorial(xp);
    fxt=(A^X(i))/factorial(X(i));
    com_pro=min(1,fx/fxt);
    u=rand();
    if u<=com_pro
        X(i+1)=xp;
    else
        X(i+1)=X(i);
    end
end
end


function [X,Y]=metropolis2()
n=10000;
A1=4;
A2=4;
X=zeros(1,n);
Y=zeros(1,n);
for i=1:(n-1)
    xp=randi([0,10]);
    yp=randi([0,10]);
    fx=((A1^xp)/factorial(xp))*((A2^yp)/factorial(yp));
    fxt=((A1^X(i))/factorial(X(i)))*((A2^Y(i))/factorial(Y(i)));
    com_pro=min(1,fx/fxt);
    u=rand();
    if u<=com_pro
        X(i+1)=xp;
        Y(i+1)=yp;
    else
        X(i+1)=X(i);
        Y(i+1)=Y(i);
    end
end
end

function Y=erl(lambda,n,size)
for i=1:size
    Uni=rand(1,n);
    term=-1/lambda*log(Uni);
    Y(i)=sum(term);
end
end
    
    