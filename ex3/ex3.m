clc; clear;
U=unifrnd(0,1,1,10000);
exp1=-log(U)./0.05;
figure(1)
histogram(exp1,'Normalization','probability')
xlabel('Numbers')
ylabel('Density')
title('\lambda=0.05') 
disp("======K-S test for Exp(lambda=0.05) distribution=====")
%[h,p] = kstest(exp1,'cdf',[exp1(:) expcdf(exp1(:),expfit(exp1))])
pd = makedist('Exponential','mu',1/0.05)
[h,p] = kstest(exp1,'CDF',pd)
%normal distribution (Box-Muller)
for i=1:length(U)
    u=rand(1);
    n1(i)=(-2*log(U(i)))^(1/2)*cos(2*pi*u);
    n2(i)=(-2*log(U(i)))^(1/2)*sin(2*pi*u);
    n=[n1,n2];
end

disp("======chi^2 test for Normal distribution=====")
[h,p] = chi2gof(n)
figure(2)
histfit(n)
xlabel('Numbers')
ylabel('Frequency')
%histogram(n)
%Pareto k=2.05
figure(3)
par1=U.^(-1/2.05); subplot(2,2,1);
histogram(par1,'Normalization','probability'); title('k=2.05');
disp("===  Pareto k=2.05  ===")
%Means

m1=2.05/(2.05-1) 
mean1=mean(par1)
%Variances
s1=2.05/((2.05-1)^2*(2.05-2))
Var1=var(par1)
disp("======K-S test for Pareto k=2.05 distribution=====")
r1 = gprnd(1/2.05,1/2.05,1,1,10000);
[h,p] = kstest2(par1,r1)
%Pareto k=2.5
disp("===  Pareto k=2.5  ===")
par2=U.^(-1/2.5); subplot(2,2,2);
histogram(par2,'Normalization','probability'); title('k=2.5');
%Means
m2=2.5/(2.5-1)
mean2=mean(par2)
%Variances
s2=2.5/((2.5-1)^2*(2.5-2))
Var2=(std(par2))^2
disp("======K-S test for Pareto k=2.5 distribution=====")
r2 = gprnd(1/2.5,1/2.5,1,1,10000);
[h,p] = kstest2(par2,r2)
%Pareto k=3
par3=U.^(-1/3); subplot(2,2,3);
histogram(par3,'Normalization','probability'); title('k=3');
%Means
disp("===  Pareto k=3  ===")
m3=3/(3-1)
mean3=mean(par3)
%Variances
s3=3/((3-1)^2*(3-2))
Var3=(std(par3))^2
disp("======K-S test for Pareto k=3 distribution=====")
r3 = gprnd(1/3,1/3,1,1,10000);
[h,p] = kstest2(par3,r3)
%Pareto k=4
par4=U.^(-1/4); subplot(2,2,4);
histogram(par4,'Normalization','probability'); title('k=4');
%Means
disp("===  Pareto k=4  ===")
m4=4/(4-1)
mean4=mean(par4)
%Variances
s4=4/((4-1)^2*(4-2))
Var4=(std(par4))^2
disp("======K-S test for Pareto k=4 distribution=====")
r4 = gprnd(1/4,1/4,1,1,10000);
[h,p] = kstest2(par4,r4)



%Create 100 confidence intervals for mean
for i=1:100
    obs=n(randperm(length(n),10));
    CI_mean(1,i)=mean(obs)-2.262*std(obs)/(10)^(1/2);
    CI_mean(2,i)=mean(obs)+2.262*std(obs)/(10)^(1/2);
    cimean(i)=(CI_mean(1,i)+CI_mean(2,i))/2;
end
%Create 100 confidence intervals for variance
for i=1:100
    obs=n(randperm(length(n),10));
    CI_var(1,i)=9 *(std(obs))^2/19.023;
    CI_var(2,i)=9 *(std(obs))^2/2.7;
    civar(i)=(CI_mean(1,i)+CI_mean(2,i))/2;
end
figure(4)
q=1:100;
plot(q,CI_mean(1,:),'r','Linewidth',2)
hold on
plot(q,CI_mean(2,:),'b','Linewidth',2)
z=zeros(1,100);
plot(q,z,'k','Linewidth',2)
title('100 Confidence Intervals for Mean') 
hold off

figure(5)
q=1:100;
plot(q,CI_var(1,:),'r','Linewidth',2)
hold on
plot(q,CI_var(2,:),'b','Linewidth',2)
z=ones(1,100);
plot(q,z,'k','Linewidth',2)
title('100 Confidence Intervals for Variance')
hold off