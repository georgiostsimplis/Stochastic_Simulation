clc; clear;
%% Generator
a=11; c=1; x=1; M=10001;
for i=1:10000
    x=mod(a*x+c,M);
    u(i)=x/M;
end
figure(1)
histogram(u,10)
title('Histogram of experimental generator');

u1=u;
for i=2:10000
    u1(2,i-1)=u(i);    
end
%Scatter
figure(2)
scatter(u1(1,:),u1(2,:));
title('Scatter-Plot of experimental generator')
%% chi- square test

edges=0:0.1:1;
u2=discretize(u,edges);
T1=0;
for i=1:10
   observed=find(u2==i);
   T1=T1+((length(observed)-1000)^2)/1000;
end 
fprintf("The value of the chi-square test for our generator1 is :\n %f",T1);
%% Kolmogorov Smirnov test

D=[];
Fn=0;
sortU=unique(u);
for i=1:length(sortU)
    n=length(find(u==sortU(i)));
    Fn=Fn+(n/10000);
    F0=sortU(i);
    D(i)=abs(Fn-F0);
end
Dmax=max(D);

fprintf("\n \n The value of the Dmax of K-S test for our generator1 is :\n %f",Dmax);

% Test using existing library
%pd=makedist('uniform');
%h=kstest(u,'cdf',pd)
%% Run test 1
m=mean(u);
n1=length(find(u>m));
n2=length(find(u<m));
run=0;
j=1;
while j<10000
    while u(j)<m
        if j<10000
            j=j+1;
        else
            break
        end
    end
    run=run+1;
    while u(j)>m
        if j<10000
            j=j+1;
        else
            break
        end
    end
    run=run+1;
end

m1=2*(n1*n2/(n1+n2))+1;
s1sq=2*(n1*n2*(2*n1*n2-n1-n2))/((n1+n2)^2*(n1+n2-1));

z1=(m1-run)/sqrt(s1sq);
%[h,p] = runstest(u,median(u));


fprintf("\n \n The value of the Z Run test 1 for our generator1 is :\n %f",z1);
%% Run test 2
A=[4529.4 9044.9 13568 18091 22615 27892;
    9044.9 18097 27139 36187 45234 55789;
    13568 27139 40721 54281 67852 83685;
    18091 36187 54281 72414 90470 111580;
    22615 45234 67852 90470 113262 139476;
    27892 55789 83685 111580 139476 172860];

B=[1/6 5/24 11/120 19/720 29/5040 1/840]';

i=2;
r=[];
idx=0;
%find the sequence of increacing values
while i<9999
    idx=idx+1;
    count=1;
    while u(i)>u(i-1)
        i=i+1;
        count=count+1;
    end
    r(idx)=count;
    i=i+1;
end
%compute the R vector
R=[];
for i=1:6
    R(i)=length(find(r==i));
    if i==6
        R(i)=length(find(r>=6));
    end
end
n3=10000;
Z=1/(n3-6)*(R'-n3*B)'*A*(R'-n3*B);

fprintf("\n \n The value of the Z of Run II test for our generator1 is :\n %f",Z);

%% Run test 3
simb=[];
for i=1:9999
    if u(i+1)>u(i)
        simb(i)=1;
    else
        simb(i)=0;
    end
end
i=1;
run=[];
idx=0;
while i<9998
    idx=idx+1;
    count1=1;
    while simb(i)==simb(i+1)
        count1=count1+1;
        i=i+1;
    end
    run(idx)=count1;
    i=i+1;
end
run1=length(find(run==1));
run2=length(find(run==2));
aa1=(length(run)-19999/3)/sqrt((160000-29)/90);    
fprintf("\n \n The value of the Z of Run III test for our generator1 is :\n %f",aa1);

%% correlation Test
%indx1=randperm(length(u),length(u)/2);
%contr=[1:10000];
%indx2=setdiff(contr,indx1);
%set1=u(indx1);
%set2=u(indx2);
xxx=sort(u);
idx1=[1:5000];
idx2=[5001:10000];
set1=u(idx1);
set2=u(idx2);
ro1= (1/5000)*sum((set1.*set2));
fprintf("\n \n The value of the ro of Correlation test for our generator1 is :\n %f",ro1);
%% experimenting
disp(" \n ===============================================")
a=601; c=1; x=1; M=100001;
for i=1:10000
    x=mod(a*x+c,M);
    u(i)=x/M;
end
figure(3)
histogram(u,10)
title('Histogram of experimental generator 2');
u1=u;
for i=2:10000
    u1(2,i-1)=u(i);    
end
%Scatter
figure(4)
scatter(u1(1,:),u1(2,:));
title('Scatter-Plot of experimental generator')

%% chi- square test

edges=0:0.1:1;
u2=discretize(u,edges);
T1=0;
for i=1:10
   observed=find(u2==i);
   T1=T1+((length(observed)-1000)^2)/1000;
end 
fprintf("The value of the chi-square test for our generator2 is :\n %f",T1);
%% Kolmogorov Smirnov test

D=[];
Fn=0;
sortU=unique(u);
for i=1:length(sortU)
    n=length(find(u==sortU(i)));
    Fn=Fn+(n/10000);
    F0=sortU(i);
    D(i)=abs(Fn-F0);
end
Dmax=max(D);

fprintf("\n \n The value of the Dmax of K-S test for our generator2 is :\n %f",Dmax);
%% run test 1
%% Run test 1
m=mean(u);
n1=length(find(u>m));
n2=length(find(u<m));
run11=0;
j=1;
while j<10000
    while u(j)<m
        if j<10000
            j=j+1;
        else
            break
        end
    end
    run11=run11+1;
    while u(j)>m
        if j<10000
            j=j+1;
        else
            break
        end
    end
    run11=run11+1;
end

m1=2*(n1*n2/(n1+n2))+1;
s1sq=2*(n1*n2*(2*n1*n2-n1-n2))/((n1+n2)^2*(n1+n2-1));

z1=(m1-run11)/sqrt(s1sq);
[h,p] = runstest(u,median(u));
fprintf("\n \n The value of the Z Run test 1 for our generator2 is :\n %f",z1);
%Run test 2
%% Run test 2
A=[4529.4 9044.9 13568 18091 22615 27892;
    9044.9 18097 27139 36187 45234 55789;
    13568 27139 40721 54281 67852 83685;
    18091 36187 54281 72414 90470 111580;
    22615 45234 67852 90470 113262 139476;
    27892 55789 83685 111580 139476 172860];

B=[1/6 5/24 11/120 19/720 29/5040 1/840]';

i=2;
r=[];
idx=0;
%find the sequence of increacing values
while i<9999
    idx=idx+1;
    count=1;
    while u(i)>u(i-1)
        i=i+1;
        count=count+1;
    end
    r(idx)=count;
    i=i+1;
end
%compute the R vector
R=[];
for i=1:6
    R(i)=length(find(r==i));
    if i==6
        R(i)=length(find(r>=6));
    end
end
n3=10000;
Z=1/(n3-6)*(R'-n3*B)'*A*(R'-n3*B);

fprintf("\n \n The value of the Z of Run II test for our generator2 is :\n %f",Z);
%% Run test 3
simb=[];
for i=1:9999
    if u(i+1)>u(i)
        simb(i)=1;
    else
        simb(i)=0;
    end
end
i=1;
run=[];
idx=0;
while i<9998
    idx=idx+1;
    count1=1;
    while simb(i)==simb(i+1)
        count1=count1+1;
        i=i+1;
    end
    run(idx)=count1;
    i=i+1;
end
run1=length(find(run==1));
run2=length(find(run==2));
aa1=(length(run)-19999/3)/sqrt((160000-29)/90);    
fprintf("\n \n The value of the Z of Run III test for our generator2 is :\n %f",aa1);

%%
idx1=[1:5000];
idx2=[5001:10000];
xxx=sort(u);
set1=u(idx1);
set2=u(idx2);
ro1= (1/5000)*sum((set1.*set2));
fprintf("\n \n The value of the ro of Correlation test for our generator1 is :\n %f",ro1);
%% Using available generator
disp(" \n ===============================================")
Unew=rand(1,10000);

figure(5)
histogram(Unew,10)
title("Histogram of system's generator")
%Create Scatterplot
Unew1=Unew;

for i=2:10000
    Unew1(2,i-1)=Unew(i);    
end

%Scatter
figure(6)
scatter(Unew1(1,:),Unew1(2,:));
title("Scatter-Plot of system's generator")

%% chi- square existing test

edges=0:0.1:1;
Unew2=discretize(Unew,edges);
Tnew=0;
for i=1:10
   observed_new=find(Unew2==i);
   Tnew=Tnew+((length(observed_new)-1000)^2)/1000;
end 
%% Kolmogorov Smirnov new test

Dnew=[];
Fn_new=0;
sortU_new=unique(Unew);
for i=1:length(sortU_new)
    n=length(find(Unew==sortU_new(i)));
    Fn_new=Fn_new+(n/10000);
    F0_new=sortU_new(i);
    Dnew(i)=abs(Fn_new-F0_new);
end
Dmax_new=max(Dnew);

% Test using existing library
pd=makedist('uniform');
hnew=kstest(Unew,'cdf',pd);

%% Run test 1 new
m=mean(u);
n1=length(find(Unew>m));
n2=length(find(Unew<m));
run=0;
j=1;
while j<10000
    while Unew(j)<m
        if j<10000
            j=j+1;
        else
            break
        end
    end
    run=run+1;
    while Unew(j)>m
        if j<10000
            j=j+1;
        else
            break
        end
    end
    run=run+1;
end

m1=2*(n1*n2/(n1+n2))+1;
s1sq=2*(n1*n2*(2*n1*n2-n1-n2))/((n1+n2)^2*(n1+n2-1));

z1=(m1-run)/sqrt(s1sq);
%[h,p] = runstest(u,median(u));


fprintf("\n \n The value of the Z Run test 1 for syst generator is :\n %f",z1);
%% Run test 2
A=[4529.4 9044.9 13568 18091 22615 27892;
    9044.9 18097 27139 36187 45234 55789;
    13568 27139 40721 54281 67852 83685;
    18091 36187 54281 72414 90470 111580;
    22615 45234 67852 90470 113262 139476;
    27892 55789 83685 111580 139476 172860];

B=[1/6 5/24 11/120 19/720 29/5040 1/840]';

i=2;
r=[];
idx=0;
%find the sequence of increacing values
while i<9999
    idx=idx+1;
    count=1;
    while Unew(i)>Unew(i-1)
        i=i+1;
        count=count+1;
    end
    r(idx)=count;
    i=i+1;
end
%compute the R vector
R=[];
for i=1:6
    R(i)=length(find(r==i));
    if i==6
        R(i)=length(find(r>=6));
    end
end
n3=10000;
Z=1/(n3-6)*(R'-n3*B)'*A*(R'-n3*B);

fprintf("\n \n The value of the Z of Run II test for syst generator is :\n %f",Z);

%% Run test 3
simb=[];
for i=1:9999
    if Unew(i+1)>Unew(i)
        simb(i)=1;
    else
        simb(i)=0;
    end
end
i=1;
run=[];
idx=0;
while i<9998
    idx=idx+1;
    count1=1;
    while simb(i)==simb(i+1)
        count1=count1+1;
        i=i+1;
    end
    run(idx)=count1;
    i=i+1;
end
run1=length(find(run==1));
run2=length(find(run==2));
aa3=(length(run)-19999/3)/sqrt((160000-29)/90);    
fprintf("\n \n The value of the Z of Run III test for syst generator is :\n %f",aa3);
idx1=[1:5000];
idx2=[5001:10000];
xxx=sort(Unew);
set1=Unew(idx1);
set2=Unew(idx2);
ro1= (1/5000)*sum((set1.*set2));
fprintf("\n \n The value of the ro of Correlation test for syst generator is :\n %f",ro1);
%% Results
%fprintf("The value of the chi-square test for our generator is :\n %f",T1);
fprintf("\n \n The value of the chi-square test for existing generator is :\n %f",Tnew);
%fprintf("\n \n The value of the Dmax of K-S test for our generator is :\n %f",Dmax);
fprintf(" \n \n The value of the Dmax of K-S test for existing generator is :\n %f",Dmax_new);
fprintf("\n")
figure(7)
histogram(u,10)
hold on 
histogram(Unew,10)
hold off


