%check CIR PDF
clear all;
close all;
%CIR Parameters &  time horizon
kappa=0.5; sigma=2; X0=0; theta=0;
[t_ou,x_ou,P_ou]=FP_Ornstein_Uhlenbeck(0.5, 0, 2, 0.1 , 0.01, -4 , 4, 0 , 1);

tau=[0 0.3 0.7 0.9];

%grid values for X
for i=1:length(tau)
	pdfou(:,i)=pdf('normal',x_ou,X0*exp(-kappa*(tau(i)))+theta*(1-exp(-kappa*tau(i))),(sigma^2/(2*kappa))*(1-exp(-2*kappa*tau(i))));
    pdfou_est(:,i)=P_ou(:,find(t_ou==tau(i),1));
end

h=figure(1);
for i=1:length(tau)
    subplot(2,2,i)
    plot(x_ou,pdfou(:,i),'-.','DisplayName','analytical pdf'); 
    hold on;
    plot(x_ou,pdfou_est(:,i),'-','DisplayName','estimated pdf');
    legend('location','northwest');
    title(strcat('T=',num2str(tau(i))));
    xlabel('x'); ylabel('pdf');
end

sgtitle('PDF of the Ornstein-Uhlenbeck process at various times') 
%title('The density of X(t) in the ou model at different horizons')
print(h,'-dpng','OU_pdf')