function [t,x,P]=FP_Ornstein_Uhlenbeck(kappa, theta, sigma, h ,k, x_min,x_max, t_min,t_max)

t = (t_min:k:t_max)';
x = (x_min:h:x_max)';

 %dummy variable
[M,d] = size(x);
[N,d] = size(t);

a = kappa * ones(size(x));
b = kappa * (x - theta);
c = (sigma^2/2) * ones(size(x));

[M1, M2] = populate_M1_M2(a,b,c,h,k);
 
[L,U] = lu(M1);
P = zeros(M,N);
P(:,1)=normpdf(x,0,1);

for i=(2:N)
    P(:,i)= U \ (L \ (M2*P(:,i-1)));
end


