%check CIR PDF
clear all;
close all;
%CIR Parameters &  time horizon
kappa=0.5; theta=0; sigma=2; x_0=1; nu=0.5; h=0.01; k=0.01;  x_min=-8; x_max=8; t_min=0; t_max=1;
OU=csvread('..\OU_FEM.csv',1,1);

x_ou = OU(:,1);
pdfou_est = OU(:,2:5);
tau=[0.1, 0.3, 0.6, 1];

%grid values for X
for i=1:length(tau)
	pdfou(:,i)=pdf('normal',x_ou,x_0*exp(-kappa*(tau(i)))+theta*(1-exp(-kappa*tau(i))),sqrt((sigma^2/(2*kappa))*(1-exp(-2*kappa*tau(i)))));
end

h=figure(1);
for i=1:length(tau)
    subplot(2,2,i)
    plot(x_ou,pdfou(:,i),'-','DisplayName','true distribution','LineWidth',1.5, 'Color', 'red'); 
    hold on;
    plot(x_ou,pdfou_est(:,i),'--','DisplayName','estimated distribution','LineWidth',1.5, 'Color', 'blue');
    legend('location','northwest');
    title(strcat('T=',num2str(tau(i))));
    xlabel('x'); ylabel('pdf');
end

sgtitle('PDF of the Ornstein-Uhlenbeck process at various times using FEM'); 
%title('The density of X(t) in the ou model at different horizons')
%print(h,'-dpng','OU_pdf')