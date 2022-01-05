clc; clear;
for j=1:10
rejected_customers=0;
%generate first customer
customers=1;
busy_servers=1;
arrival=erl(8,8,1);
departure=arrival+pareto(1.05);
t=arrival;
%next Event
while customers<10000
    if  busy_servers<=0 || (t <= min(departure))
        %Then the next event is an arrival
        p=poissrnd(1);
        if p==0
            continue
        else
            for i=1:p
                customers=customers+1;
                arrival(end+1)=arrival(end)+erl(8,8,1);
                departure(end+1)=arrival(end)+pareto(1.05);
                t=arrival(end);
                if busy_servers<=9
                    busy_servers=busy_servers+1;
                else
                    rejected_customers=rejected_customers+1;
                    departure(end)=[];
                end
            end
        end
    else
        %The next event is a departure
        busy_servers=busy_servers-1;
        [~,idx]=min(departure);
        departure(idx)=[];
        %arrival(end)=[];
    end
    
end
fra(j)=rejected_customers/10000;
end
fraction_rejected=mean(fra)
CI(1)=mean(fra)-1.96*std(fra)/sqrt(10)
CI(1)=mean(fra)+1.96*std(fra)/sqrt(10)
s=0;
for j=0:10
    denominator=8^j/factorial(j);
    s=s+denominator;
end
ErlangB=(8^10/factorial(10))/s

function Y=erl(lambda,n,size)
for i=1:size
    Uni=rand(1,n);
    term=-1/lambda*log(Uni);
    Y(i)=sum(term);
end
end
function W=pareto(k)
b=8*((k-1)/k);
W=b*(rand(1))^(-1/k);
end