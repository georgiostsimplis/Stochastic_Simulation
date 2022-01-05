%% Exercise 13
clc;clear;
disp('=========Exersice 13==========')
x = [56, 101, 78, 67, 93, 87, 64, 72, 80, 69];
a = -5;
b = 5;
n = 10;

sample=bootstrap(x,n);
means1=mean(sample')';
p=posibility1(means1,x,a,b);
aa=sprintf('\nThe possibility is:  %f',p);
disp(aa)

%% Exercise 15
disp('=========Exersice 15==========')
X = [5, 4, 9, 6, 21, 17, 11, 20, 7, 10, 21, 15, 13, 16, 8];
n = 15;
sample2=bootstrap(X,n);

S=var(sample2')';
Var2=var(S);
ab=sprintf('\nThe Var(S^2) is:  %f',Var2);
disp(ab)

%% Exercise 3
disp('=========Part 3==========')
for i=1:200
    ar(i)=pareto(1.05);
end
sample3=bootstrap(ar,200);
mm=mean(sample3')';
mean3=mean(mm);

mmmed=median(sample3')';
medd1=median(mmmed);
ab=sprintf('\nThe estimated mean is is:  %f',mean3);
disp(ab)
ab=sprintf('\nThe estimated median is is:  %f',medd1);
disp(ab)
%% b c

vaar1=var(mm);
vaar2=var(mmmed);
ab=sprintf('\nThe Var of the mean is is:  %f',vaar1);
disp(ab)
ab=sprintf('\nThe Var of the median is is:  %f',vaar2);
disp(ab)

mean(ar)
median(ar)


%% functions
function samples=bootstrap(x,n)
for i=1:n
    samples(i,:)=datasample(x,n);
end
end

function pos=posibility1(means,x,a,b)
differences=means-mean(x);
count=0;
for i=differences'
    if (i>a) && (i<b)
        count=count+1;
    end
    pos=count/length(differences);
end
end

function W=pareto(k)
b=1;
W=b*(rand(1))^(-1/k);
end

function median=medv(x)
sortedval=sort(x);
k=length(x);
if mod(k,2)==0
    median=(sortedval(k/2)+sortedval(k/2+1))/2;
else
    median=sortedval((k+1)/2);
end
end

function [med,varmed]=boosvarmed(x,r)
med=medv(x);
sample=bootstrap(x,r);
for i=1:r
    rowmed(i)=medv(sample(i,:));
end
varmed=var(rowmed);


end

