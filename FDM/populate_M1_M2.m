1function [M1, M2] = populate_M1_M2(a,b,c,h,k)

[N,d] = size(a);

l = k/(h^2);
M1 = zeros(N,N);
M2 = zeros(N,N);

A = (b*h*l)/4 - (c*l)/2;
B = (a*k)/2 - (c*l);
C = (b*h*l)/4 + (c*l)/2;

M1(1,[1 2]) = [1-B(1) -C(1)];
M1(N,[N-1,N]) = [A(N) 1-B(N)];

M2(1,[1,2]) = [1+B(1) C(1)];
M2(N,[N-1,N]) = [-A(N) 1+B(N)];

for r=(2:N-1)
    M1(r,[r-1 r r+1]) = [A(r) 1-B(r) -C(r)];
    M2(r,[r-1 r r+1]) = [-A(r) 1+B(r) C(r)];
end
end

