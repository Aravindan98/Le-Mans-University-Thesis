%check CIR PDF

clear all;
close all;
%CIR Parameters &  time horizon
kappa=0.03; sigma=0.02; theta=0.03; x_0=0.5; nu=0.01; h=0.005; k=0.01; x_min=0.3; x_max=0.6; t_min=0; t_max=5;
%[t_cir, x_cir, P_cir]=FP_CIR(kappa, theta, sigma, x_0, nu, h , k, x_min, x_max, t_min, t_max);

CIR=csvread('..\CIR_FEM.csv',1,1);
x_cir = CIR(:,1);
pdfcir_est = CIR(:,2:5);
tau=[1 2 3 4];
%compute d
d=4 *kappa *theta/sigma^2;
%grid values for X
XT=x_cir;
for i=1:length(tau)
	lambda=4*kappa* x_0/(sigma^2 *(exp(kappa*tau(i))-1));
	k=sigma^2 *(1-exp(-kappa*tau(i)))/(4*kappa);
	pdfcir(:,i)=pdf('ncx2',XT/k,d,lambda)/k;
    %pdfcir_est(:,i)=P_cir(:,find(t_cir==tau(i),1));
end
h=figure(1);
for i=1:length(tau)
    subplot(2,2,i)
    plot(x_cir,pdfcir(:,i), '-','DisplayName','true distribution','LineWidth',1.5, 'Color', 'red'); 
    hold on;
    plot(x_cir,pdfcir_est(:,i), '--', 'DisplayName', 'estimated distribution', 'LineWidth', 1.5, 'Color', 'blue');
    %xline(x_0);
    legend('location','northwest');
    title(strcat('T=',num2str(tau(i))));
    xlabel('x'); ylabel('pdf');
end

sgtitle('PDF of the Cox-Ingersoll-Ross process at various times using FEM') 
%title('The density of X(t) in the CIR model at different horizons')
%print(h,'-dpng','CIR_pdf')