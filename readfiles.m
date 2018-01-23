clc
clear all
close all
Files=dir('C:\Users\Mampi\Dropbox\CSET\Data\CloudSAT\Precip_column\');
% subplot(121);
for k=31%length(Files)
    FileNames=Files(k).name;
    s=strcat(['C:\Users\Mampi\Dropbox\CSET\Data\CloudSAT\Precip_column\',Files(k).name]);
%     fileinfo = hdfinfo(s);
%     sds_info = fileinfo.(2);
    Latitude = hdfread(s,'/2C-PRECIP-COLUMN/Geolocation Fields/Latitude', 'Fields', 'Latitude', 'FirstRecord',1 ,'NumRecords',20678);
    Longitude = hdfread(s,'/2C-PRECIP-COLUMN/Geolocation Fields/Longitude', 'Fields', 'Longitude', 'FirstRecord',1 ,'NumRecords',20678);
    lat=Latitude{:};lon=Longitude{:};
    plot(Longitude{:},Latitude{:},'.');hold on;
end

Precip_rate = hdfread('C:\Users\Mampi\Dropbox\CSET\Data\CloudSAT\Precip_column\2015198001106_49032_CS_2C-PRECIP-COLUMN_GRANULE_P2_R04_E06.hdf', '/2C-PRECIP-COLUMN/Data Fields/Precip_rate', 'Fields', 'Precip_rate', 'FirstRecord',1 ,'NumRecords',20678);
prec=Precip_rate{:};prec(prec<0)=NaN;
% scatter3(lon,lat,prec);xlabel('lon');ylabel('lat');zlabel('prec');

file06='C:\Users\Mampi\Dropbox\CSET\Data\CSET_rf06.nc';
file07='C:\Users\Mampi\Dropbox\CSET\Data\CSET_rf07.nc';
lat06=ncread(file06,'LAT');lat07=ncread(file07,'LAT');
lon06=ncread(file06,'LON');lon07=ncread(file07,'LON');
alt06=ncread(file06,'GGALT');alt07=ncread(file07,'GGALT');
hold on;
plot(lon06,lat06,'r',lon07,lat07,'b','LineWidth',2);
xlim([-147 -146]);ylim([10 50]);
legend('CloudSat','CSET RF06','CSET RF07');
xlabel('Longitude');
ylabel('Latitude');
set(gca,'FontSize',16,'FontWeight','Bold');
% subplot(122);
figure;
plot(lon06,alt06,'r',lon07,alt07,'b','LineWidth',2);
set(gca,'FontSize',16,'FontWeight','Bold');
xlabel('Longitude');
ylabel('Altitude');
xlim([-147 -146]);