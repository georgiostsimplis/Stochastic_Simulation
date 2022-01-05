%% 5.1
clc; clear;
U=unifrnd(0,1,1,100);
X=exp(U);
theta1=sum(X)/100;

stderror1=std(X)/sqrt(100);
CI_1(1,1)=theta1-1.96*stderror1/sqrt(100);
CI_1(2,1)=theta1+1.96*stderror1/sqrt(100);
%% 5.2
Y=(exp(U)+exp(1-U))/2;

theta2=sum(Y)/100;
stderror2=std(Y)/sqrt(100);
CI_2(1,1)=theta2-1.96*stderror2/sqrt(100);
CI_2(2,1)=theta2+1.96*stderror2/sqrt(100);
%% 5.3
covmatrix=cov(X,U);
cov_x_u=covmatrix(1,2);
var_u=covmatrix(2,2);
c=-cov_x_u/var_u;
Z=X+c*(U-1/2);
theta3=sum(Z)/100;
stderror3=std(Z)/sqrt(100);
CI_3(1,1)=theta3-1.96*stderror3/sqrt(100);
CI_3(2,1)=theta3+1.96*stderror3/sqrt(100);
%% 5.4
exponents=U/10;
for j=1:100
    numerator =0;
    for i=1:10
        numer=exp((i-1)/10+exponents(j));
        numerator=numerator+numer;
    end
    W(j)=numerator/10;
end
theta4=sum(W)/100;
stderror4=std(W)/sqrt(100);
CI_4(1,1)=theta4-1.96*stderror4/sqrt(100);
CI_4(2,1)=theta4+1.96*stderror4/sqrt(100);
var1=var(X)
var2=var(Y)
var3=var(Z)
var4=var(W)
theta1
theta2
theta3
theta4
%confidence intervals
CI_1
CI_2
CI_3
CI_4