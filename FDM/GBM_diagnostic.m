%check CIR PDF
clc;
clear all;
close all;
%CIR Parameters &  time horizon
mu = 0;
sigma = 1;
[t_gbm,x_gbm,P_gbm]=FP_Geometric_Brownian(mu, sigma, 0.1, 0.01, 0 , 10, 0 , 1);

tau=[0 0.3 0.7 0.9];
%grid values for X
for i=1:length(tau)
	pdfgbm(:,i)=pdf('lognormal',x_gbm, log(1.5)+(mu-sigma^2/2)*(t_gbm),sigma*(t_gbm).^0.5);
    pdfgbm_est(:,i)=P_gbm(:,find(t_gbm==tau(i),1));
end
h=figure(1);
for i=1:length(tau)
    subplot(2,2,i)
    plot(x_gbm,pdfgbm(:,i),'-.','DisplayName','analytical pdf'); 
    hold on;
    plot(x_gbm,pdfgbm_est(:,i),'-','DisplayName','estimated pdf');
    legend('location','northeast');
    title(strcat('T=',num2str(tau(i))));
    xlabel('x'); ylabel('pdf');
end

sgtitle('PDF of the Geometric Brownian Motion at various times') 
%title('The density of X(t) in the CIR model at different horizons')
print(h,'-dpng','GBM_pdf')