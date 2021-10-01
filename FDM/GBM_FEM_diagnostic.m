%check CIR PDF
clc;
clear all;
close all;
%CIR Parameters &  time horizon
mu = 0;
sigma = 1;
x_0=1.5; 
nu=0.5;
h=0.1; 
k=0.01; 
x_min=0; 
x_max=10; 
t_min=0; 
t_max=1;

%[t_gbm,x_gbm,P_gbm]=FP_Geometric_Brownian(mu, sigma, x_0, nu, h ,k, x_min,x_max, t_min,t_max);
GBM=csvread('..\GBM_FEM.csv',1,1);
x_gbm = GBM(:,1);
pdfgbm_est = GBM(:,2:5);
tau=[0.1 0.3 0.6 1];
%grid values for X
for i=1:length(tau)
	pdfgbm(:,i)=pdf('lognormal',x_gbm, log(1.5)+(mu-sigma^2/2)*(tau(i)),sigma*(tau(i)).^0.5);
    
end
h=figure(1);
for i=1:length(tau)
    subplot(2,2,i);
    plot(x_gbm,pdfgbm(:,i),'-','DisplayName','true distribution','LineWidth',1.5, 'Color', 'red'); 
    hold on;
    plot(x_gbm,pdfgbm_est(:,i),'--','DisplayName','estimated distribution','LineWidth',1.5, 'Color', 'blue');
    legend('location','northeast');
    title(strcat('T=',num2str(tau(i))));
    xlabel('x'); ylabel('pdf');
end

sgtitle('PDF of the Geometric Brownian Motion at various times using FEM'); 
%title('The density of X(t) in the CIR model at different horizons')
%print(h,'-dpng','GBM_pdf')