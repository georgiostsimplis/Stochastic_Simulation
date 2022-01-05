clear;clc;        
m_cost=[0 1   2    3    4    5    6     7    8     9      10      11       12      13    14     15     16     17   18      19     20;
 1      0   225  110    8  257   22    83  231   277     243      94       30       4   265    274    250     87   83     271       86;
 2    255     0  265  248  103  280   236   91     3      87     274      265     236     8     24     95    247  259      28      259       ;
 3     87   236    0   95  248  110    25  274   250     271       9      244      83   250    248    280     29   26     239        7      ;
 4      8   280   83    0  236   28    91  239   280     259     103       23       6   280    244    259     95   87     230       84      ;
 5    268    87  239  271    0  244   275    9    84      25     244      239     275    83    110     24    274  280      84      274      ;
 6     21   265   99   29  259    0    99  230   265     271      87        5      22   239    236    250     87   95     271       91      ;
 7     95   236   28   91  247   93     0  247   259     244      27       91      87   268    275    280      7    8     240       27      ;
 8    280    83  250  261    4  239   230    0   103      24     239      261     271    95     87     21    274  255     110      280      ;
 9    247     9  280  274   84  255   259   99     0      87     255      274     280     3     27     83    259  244      28      274       ;
10    230   103  268  275   23  244   264   28    83       0     268      275     261    91     95      8    277  261      84      247      ;
11     87   239    9  103  261  110    29  255   239     261       0      259      84   239    261    242     24   25     242        5      ;
12     30   255   95   30  247    4    87  274   242     255      99        0      24   280    274    259     91   83     247       91      ;
13      8   261   83    6  255   29   103  261   247     242     110       29       0   261    244    230     87   84     280      100;
14    242     8  259  280   99  242   244   99     3      84     280      236     259     0     27     95    274  261      24      268       ;
15    274    22  250  236   83  261   247  103    22      91     250      236     261    25      0    103    255  261       5      247       ;
16    244    91  261  255   28  236   261   29   103       9     242      261     244    87    110      0    242  236      95      259      ;
17     84   236   27   99  230   83     7  259   230     230      22       87      93   250    255    247      0    9     259       24      ;
18     91   242   28   87  250  110     6  271   271     255      27      103      84   250    271    244      5    0     271       29      ;
19    261    24  250  271   84  255   261   87    28     110     250      248     248    22      3    103    271  248       0      236       ;
20    103   271    8   91  255   91    21  271   236     271       7      250      83   247    250    271     22   27     248        0      ];
cost=m_cost(2:end,2:end); clear m_cost

x=randi([1,20],2,20);

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
while temp>0.07
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
    cosmo11=cost(random_tour(end),random_tour(1));
    newmoney=newmoney+cosmo11;
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
ylim([0 ,3000])

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




