%Run Crank_Nicholson
%https://sites.google.com/uniupo.it/stochasticcalculus/important-sdes/mean-reverting-models/cox-ingersoll-ross-model/the-cir-pdf?authuser=0
clc;
clear;
close all;
[t_ou,x_ou,P_ou]=FP_Ornstein_Uhlenbeck(0.5, 0, 2, 0.1 , 0.01, -4 , 4, 0 , 1);
[t_gbm,x_gbm,P_gbm]=FP_Geometric_Brownian(0, 1, 0.1, 0.01, 0 , 10, 0 , 1);
[t_cir,x_cir,P_cir]=FP_CIR(0.03, 0.03, 0.02, 0.01 , 0.1, 0.3 , 0.6, 0.5 , 5);

fig1 = figure(1);
[T_ou,X_ou] = meshgrid(t_ou,x_ou);
surf(T_ou,X_ou,P_ou);
colorbar;
xlabel("t");
ylabel("x");
title("PDF of the Ornstein-Uhlenbeck");
saveas(fig1,"PDF_OU.png");

figure(2)
[T_gbm,X_gbm] = meshgrid(t_gbm,x_gbm);
surf(T_gbm,X_gbm,P_gbm);
colorbar;
xlabel("t");
ylabel("x");
title("PDF of the Geometric Brownian");
saveas(figure(2),"PDF_GBM.png");

figure(3)
[T_cir,X_cir] = meshgrid(t_cir,x_cir);
surf(T_cir,X_cir,P_cir);
colorbar;
xlabel("t");
ylabel("x");
title("PDF of the Cox-Ingersoll-Ross");
saveas(figure(3),"PDF_CIR.png");
