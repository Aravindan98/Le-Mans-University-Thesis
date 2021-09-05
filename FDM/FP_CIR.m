function [t,x,P]=FP_CIR(kappa, theta, sigma, h ,k, x_min,x_max, t_min,t_max, alpha, beta)

t = (t_min:k:t_max)';
x = (x_min:h:x_max)';

 %dummy variable
[M,d] = size(x);
[N,d] = size(t);

a = (kappa) * ones(size(x));
b = (kappa*(x-theta)+sigma^2);
c = ((sigma)^2*x)/2;

[M1, M2] = populate_M1_M2(a,b,c,h,k);
 
[L,U] = lu(M1);
P = zeros(M,N);
P(:,1)=normpdf(x,alpha,beta);

for i=(2:N)
    P(:,i)= U \ (L \ (M2*P(:,i-1)));
end


