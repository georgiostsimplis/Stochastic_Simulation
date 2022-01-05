clc; clear;
% Hyperexponential arrival time
for j=1:10
rejected_customers=0;
%generate first customer
customers=1;
busy_servers=1;
arrival=hyper(0.8333,5);
departure=arrival+exprnd(8);
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
                arrival(end+1)=arrival(end)+hyper(0.8333,5);
                departure(end+1)=arrival(end)+exprnd(7.8);
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

function Z=hyper(lambda1,lambda2)
U=rand(1);
if U<0.8
    Z=-1/lambda1*log(U);
else
    Z=-1/lambda2*log(U);
end
end

