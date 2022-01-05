clc; clear;


U=unifrnd(0,1,1,10000);

%Geometric distribution
p=0.01;
G1=[];
for i=1:length(U)
    x_geo=floor(log(U(i))/log(1-p))+1;
    G1(i)=x_geo;
end
figure(1)
histogram(G1);
title(" Simulated Geometric distribution with p=0.01");

Geo=geornd(0.01,1,10000);
%x^2test for our generator
disp("x^2test for our generator")
[h,p]=chi2gof(G1,'cdf',@(x)geocdf(x,0.01))

disp("x^2test for system's generator")
[h,p]=chi2gof(Geo,'cdf',@(x)geocdf(x,0.01))

figure(2)
histogram(G1,20);
hold on 
histogram(Geo,20);
legend('Simulated','Expected');
hold off
title('Comparison of Geo distributions with p=0.01');

figure(3)
histogram(Geo);
title(" System's Geometric distribution with p=0.01");

%Crude method
Crude=[];
pi2=[7/48 5/48 1/8 1/16 1/4 5/16];
p_i=[7/48,1/4,3/8,7/16,11/16,1];
for j=1:length(U)
    i=1;
    Crude(j)=i;
    while U(j)>p_i(i);
        i=i+1;
        Crude(j)=i;
    end
end
fre=[];
for i=1:6
    fre(i)=length(find(Crude==i))/10000;
end

disp("===========ks-test Crude====================")
 [h,p]=kstest2(pi2,fre)


  
%Rejection method
qi=[1/6 1/6 1/6 1/6 1/6 1/6];
 c=0.25/(1/6);
 R=[];
 while length(R)<10000
     I=floor(6*rand())+1;
     u2=rand();
     if u2<(pi2(I)/c*qi(I))
         R(end+1)=I;
     end
 end
 
 fre1=[];
for i=1:6
    fre1(i)=length(find(R==i))/10000;
end

disp("===========ks-test Rejection====================")
 [h,p]=kstest2(pi2,fre1)
%%
%6 point alias method

pi2=[7/48 5/48 1/8 1/16 1/4 5/16];
F=6*pi2;
L=[1,2,3,4,5,6];
G=[];
S=[];
for j=1:6
    if F(j)>=1
        G(end+1)=j;
    end
    if F(j)<=1
        S(end+1)=j;
    end
end

while length(S)~=0
    t1=G(1);
    t2=S(1);
    L(t2)=t1;
    F(t1)=F(t1)-(1-F(t2));
    if F(t1)<1
        G=G(2:end);
        S(end+1)=t1;
    end
    S=S(2:end);
end
    

Al=[];
k=0;
 while length(Al)<10000;
     y=floor(6*rand())+1;
     u2=rand();
     if u2<F(y);
         Al(end+1)=y;
     else
         Al(end+1)=L(y);
     end
 end
  fre2=[];
for i=1:6
    fre2(i)=length(find(Al==i))/10000;
end

disp("===========ks-test Alias====================")
 [h,p]=kstest2(pi2,fre2)


KK=[fre;fre1;fre2];
figure(4)
bar(1:6,KK)
legend('Crude','Rejection','Alias','Location','NorthWest');
title('Comparison of Simulation methods'); 


 
 