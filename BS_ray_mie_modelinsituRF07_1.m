clc
clear all
close all
m=3.41+2.02i;%Lhermitte 2002 (p191, T=200degC, 94GHz)
K2=0.828;%Lhermitte 2002
D=0:0.01:0.5;%cm
X=(pi*D)/3.2e-1;
C=(3.2^4)/((pi^5)*0.828);
for i=1:length(D)
    x=X(i);
    if x==0 % To avoid a singularity at x=0
    result=[real(m) imag(m) 0 0 0 0 0 0 1.5];
    elseif x>0 % This is the normal situation
    nmax=round(2+x+4*x^(1/3));
    n1=nmax-1;
    n=(1:nmax);cn=2*n+1; c1n=n.*(n+2)./(n+1); c2n=cn./n./(n+1);
    x2=x*x;
    f=mie_abcd(m,x);
    anp=(real(f(1,:))); anpp=(imag(f(1,:)));
    bnp=(real(f(2,:))); bnpp=(imag(f(2,:)));
    g1(1:4,nmax)=[0; 0; 0; 0]; % displaced numbers used for
    g1(1,1:n1)=anp(2:nmax); % asymmetry parameter, p. 120
    g1(2,1:n1)=anpp(2:nmax);
    g1(3,1:n1)=bnp(2:nmax);
    g1(4,1:n1)=bnpp(2:nmax);
    dn=cn.*(anp+bnp);
    q=sum(dn);
    qext=2*q/x2;
    en=cn.*(anp.*anp+anpp.*anpp+bnp.*bnp+bnpp.*bnpp);
    q=sum(en);
    qsca=2*q/x2;
    qabs=qext-qsca;
    fn=(f(1,:)-f(2,:)).*cn;
    gn=(-1).^n;
    f(3,:)=fn.*gn;
    q=sum(f(3,:));
    qb1(1,i)=q*q'/x2;
    sigm(i)=qb1(1,i)*pi*((D(i)/2)^2);
    sigr(i)=(pi^5)*0.828*(D(i)^6)/((3.2e-1)^4);
    end
end
r=D/2;
a=pi*(r.^2);
p1=plot(D*10,sigm./a,'r-','linewidth',4);hold on;set(gca,'YScale','log','XScale','log');hold on;
p2=plot(D*10,sigr./a,'k-','linewidth',4);set(gca,'YScale','log','XScale','log');hold on;

xticks([0.1 0.2 1 2 3 4 5]);
set(gca,'fontsize',16,'fontweight','bold');
ylabel('\sigma/\pir^2');
xlabel('D(mm)');
grid on;grid minor;
hold on;
xlim([0.07 5]);
error=((sigr-sigm)./sigr)*100;
% subplot(122);
yyaxis right;
AX(1)=plot(D*10,(error),'b--','linewidth',2);set(gca,'XScale','log','YSCale','linear');
grid on;grid minor;
set(gca,'fontsize',16,'fontweight','bold');
ylabel('Error (%)');grid on;grid minor;
xlabel('D(mm)');
xlim([0.07 5]);
hold on;
yyaxis left;
% subplot(121);
clearvars -except p1 p2
file06='C:\Users\Mampi\Dropbox\CSET\Data\CSET_rf07.nc';file07='C:\Users\Mampi\Dropbox\CSET\Data\CSET_rf07.nc';
lat06=ncread(file06,'LAT');%lat07=ncread(file07,'LAT');
lon06=ncread(file06,'LON');%lon07=ncread(file07,'LON');
time06=ncread(file06,'Time');%time07=ncread(file07,'Time');
alt06=ncread(file06,'GGALT');%alt07=ncread(file07,'GGALT');
DC2conc06=ncread(file06,'CONC1DC_LWOO')*1e3;%#/m3    2DC conc.
dbz06=ncread(file06,'DBZ1DC_LWOO');
Tv=ncread(file06,'TVIR')+273;
p=ncread(file06,'PSXC')*1e2;
D06=ncread(file06,'REFF2DCR_LWOO')*2*1e-4;%cm (rad) Round
m=3.41+2.02i;%Lhermitte 2002 (p191, T=200degC, 94GHz)
K2=0.828;%Lhermitte 2002
X=(pi*D06)/3.2e-1;
C=(3.2^4)/((pi^5)*0.828);
sigm=NaN(length(D06),1);
sigr=NaN(length(D06),1);
for i=1:length(D06)
    x=X(i);
    if x==0 % To avoid a singularity at x=0
    result=[real(m) imag(m) 0 0 0 0 0 0 1.5];
    elseif x>0 % This is the normal situation
    nmax=round(2+x+4*x^(1/3));
    n1=nmax-1;
    n=(1:nmax);cn=2*n+1; c1n=n.*(n+2)./(n+1); c2n=cn./n./(n+1);
    x2=x*x;
    f=mie_abcd(m,x);
    anp=(real(f(1,:))); anpp=(imag(f(1,:)));
    bnp=(real(f(2,:))); bnpp=(imag(f(2,:)));
    g1(1:4,nmax)=[0; 0; 0; 0]; % displaced numbers used for
    g1(1,1:n1)=anp(2:nmax); % asymmetry parameter, p. 120
    g1(2,1:n1)=anpp(2:nmax);
    g1(3,1:n1)=bnp(2:nmax);
    g1(4,1:n1)=bnpp(2:nmax);
    dn=cn.*(anp+bnp);
    q=sum(dn);
    qext=2*q/x2;
    en=cn.*(anp.*anp+anpp.*anpp+bnp.*bnp+bnpp.*bnpp);
    q=sum(en);
    qsca=2*q/x2;
    qabs=qext-qsca;
    fn=(f(1,:)-f(2,:)).*cn;
    gn=(-1).^n;
    f(3,:)=fn.*gn;
    q=sum(f(3,:));
    qb1(1,i)=q*q'/x2;
    sigm(i)=qb1(1,i)*pi*((D06(i)/2)^2);
    sigr(i)=(pi^5)*0.828*(D06(i)^6)/((3.2e-1)^4);
    end
end
r=D06/2;
a=pi*(r.^2);
plot(D06*10,sigr./a,'y.');set(gca,'YScale','log');hold on;
plot(D06*10,sigm./a,'y.');set(gca,'YScale','log');hold on;
xlim([0.07 5]);
% ylim([1e-10 1e2]);
legend([p1,p2],{'Mie model','Rayleigh model'});