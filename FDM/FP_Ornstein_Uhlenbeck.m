%solving the fokker-planck-kolmogorov equation of the OU process using the Crank-Nicholson Method 
function [t,x,P]=FP_Ornstein_Uhlenbeck(kappa, theta, sigma, x_0, nu, h ,k, x_min,x_max, t_min,t_max)

t = (t_min:k:t_max)';
x = (x_min:h:x_max)';

%d is a dummy variable
[M,d] = size(x);
[N,d] = size(t);

a = kappa * ones(size(x));
b = kappa * (x - theta);
c = (sigma^2/2) * ones(size(x));

[M1, M2] = populate_M1_M2(a,b,c,h,k);
 
[L,U] = lu(M1);

%the matrix is initialized to zeros, ensuring the boundary conditions at
%both ends to be maintained
P = zeros(M,N);

%setting up the initial condition
P(:,1)=normpdf(x,x_0, nu);

for i=(2:N)
    P(:,i)= U \ (L \ (M2*P(:,i-1)));
end


