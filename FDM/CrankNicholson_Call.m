%Run Crank_Nicholson
%Reference-https://sites.google.com/uniupo.it/stochasticcalculus/important-sdes/mean-reverting-models/cox-ingersoll-ross-model/the-cir-pdf?authuser=0
clc;
clear;
close all;
kappa=0.5; theta=0; sigma=2; x_0=1; nu=0.1; h=0.01; k=0.01;  x_min=-8; x_max=8; t_min=0; t_max=1;
[t_ou,x_ou,P_ou]=FP_Ornstein_Uhlenbeck(kappa, theta, sigma, x_0, nu, h ,k, x_min,x_max, t_min,t_max);
fig1 = figure(1);
[T_ou,X_ou] = meshgrid(t_ou,x_ou);
surf(T_ou,X_ou,P_ou);
colorbar;
xlabel("t");
ylabel("x");
title("PDF of the Ornstein-Uhlenbeck");
%saveas(fig1,"PDF_OU.png");

clear;
mu = 0; sigma = 1;x_0=1.5; nu=0.1; h=0.01; k=0.01; x_min=0; x_max=10; t_min=0; t_max=1;
[t_gbm,x_gbm,P_gbm]=FP_Geometric_Brownian(mu, sigma, x_0, nu, h ,k, x_min,x_max, t_min,t_max);
figure(2)
[T_gbm,X_gbm] = meshgrid(t_gbm,x_gbm);
surf(T_gbm,X_gbm,P_gbm);
colorbar;
xlabel("t");
ylabel("x");
title("PDF of the Geometric Brownian");
%saveas(figure(2),"PDF_GBM.png");

clear;
kappa=0.03; sigma=0.02; theta=0.03; x_0=0.5; nu=0.05; h=0.01; k=0.01; x_min=0.3; x_max=0.6; t_min=0; t_max=5;
[t_cir, x_cir, P_cir]=FP_CIR(kappa, theta, sigma, x_0, nu, h , k, x_min, x_max, t_min, t_max);
figure(3)
[T_cir,X_cir] = meshgrid(t_cir,x_cir);
surf(T_cir,X_cir,P_cir);
colorbar;
xlabel("t");
ylabel("x");
title("PDF of the Cox-Ingersoll-Ross");
%saveas(figure(3),"PDF_CIR.png");
