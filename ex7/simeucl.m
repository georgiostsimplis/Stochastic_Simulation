clear;clc;        

x=randi([1,20],2,20);
cost=squareform(pdist(x'));
random_tour = randperm(20);
initial_route=random_tour;
%calculate initial cost
money=0;
for i=1:19
    cosmo=cost(random_tour(i),random_tour(i+1));
    money=money+cosmo;
end
cosmo=cost(random_tour(end),random_tour(1));
money=money+cosmo;
totco(1)=money;
%calculate initial route
x1=x(:,random_tour);
x1(:,end+1)=x1(:,1);

iter=0;
temperature(1) =3;
temp=temperature;
while temp>0.0001
    t1=randi(20);
    t2=randi(20);
    while t1==t2
        t2=randi(20);
    end
    swap1=random_tour(t1);
    swap2=random_tour(t2);
    
    random_tour(t1) = swap2;
    random_tour(t2) = swap1;
    
    newmoney=0;
    cosmo1=0;
    for i=1:19
        cosmo1=cost(random_tour(i),random_tour(i+1));
        newmoney=newmoney+cosmo1;
    end
    dif=newmoney-money;
    if (dif<0 | exp(-dif/temperature(iter+1))>rand(0,1))
        money=newmoney;
        opt_tour=random_tour;
    end
    iter=iter+1;
    temperature(end+1)=1/sqrt(iter+1);
    temp=temperature(end);
    
    totco(iter+1)=money;
end

x2=x(:,opt_tour);
x2(:,end+1)=x2(:,1);

k=1:length(totco);
figure(1)
plot(k,totco,'Linewidth',2);
title("cost reduction")
xlabel('Iterations')
ylabel('Cost')
ylim([0 ,300])

figure(2)
plot(k,temperature,'Linewidth',2);
title("Temperature Reduction")
xlabel('Iterations')
ylabel('Temperature')

figure(3)
plot(x1(1,:),x1(2,:),'Linewidth',2);
title("Initial route")

figure(4)
plot(x2(1,:),x2(2,:),'Linewidth',2);
title("Optimal route")

fprintf('The initial cost was: %f \n', totco(1));
fprintf('\n The final cost is: %f \n', totco(end));




