function [t,x,P]=FP_Geometric_Brownian(mu, sigma, h ,k, x_min,x_max, t_min,t_max)

t = (t_min:k:t_max)';
x = (x_min:h:x_max)';

 %dummy variable
[M,d] = size(x);
[N,d] = size(t);

a = (sigma^2-mu) * ones(size(x));
b = (2*sigma^2 - mu) * x;
c = (sigma*x).^2/2;

[M1, M2] = populate_M1_M2(a,b,c,h,k);
 
[L,U] = lu(M1);
P = zeros(M,N);
P(:,1)=normpdf(x,1.5,0.5);

for i=(2:N)
    P(:,i)= U \ (L \ (M2*P(:,i-1)));
end


