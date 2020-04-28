%% Inital Steps - Filtering Files Over to Matlab
% Must Run this File First 
load Demlatlon.mat
    %for some reason ^^^ that doesn't work --> but if you import the data
    %directly it works and creates its own variable - confusing?

filename2 = 'CCASF12010CMAP.xlsx'
population = readtable(filename2);

%% Getting Minority Averages for Each Town

total_pop = str2double(population.P0050001(2:78));
white =  str2double(population.P0050003(2:78));
black= str2double(population.P0050004(2:78));
minority = black


minority_rate = minority./total_pop;
minority_percent = (minority_rate)*100

%% Pulling over the Latitude and Longitude

demlon = table2array(Demlatlon(:,2));
demlat = table2array(Demlatlon(:,3));

%% Creating Maps of Chicago
% Other
states = geoshape(shaperead('usastatehi', 'UseGeoCoords', true));
oceanColor = [.5 .7 .9];

latlim_2 = [min(demlat) max(demlat)];
lonlim_2 = [min(demlon) max(demlon)];
[latlim_2, lonlim_2] = bufgeoquad(latlim_2, lonlim_2, .05, .05);

% Percent of Population that is a Minority at Each of Locations
figure (1)
ax_2 = usamap(latlim_2, lonlim_2);
setm(ax_2, 'FFaceColor', oceanColor)
geoshow(states)
%cmocean(flipud(gray),50)
intensity = 64
newColormap = colormap(flipud(colormap('gray')))
newColormap = newColormap(1:intensity,:)
colormap(newColormap)
%colormap(flipud(colormap('gray')));
scatterm(demlat, demlon, 150, minority_percent, 'filled')
plotm(41.8757,-87.6243,'k*') 
textm(41.8757,-87.61,'Downtown') 
title('Percentage of Black Residents (%) by Neighborhood in the Greater Chicago Region')
%title('Outline of the Demographic Sites Used')
%plotm(close_lat, close_lon, 'ro');
%% PM2.5
%Loading Data
filename= 'ad_viz_plotval_data.csv';
pm = readtable(filename);
total_pm= str2double(pm.DailyMeanPM2_5Concentration);
total_ID= str2double(pm.SiteID);
total_site_lat=str2double(pm.SITE_LATITUDE);
total_site_lon=str2double(pm.SITE_LONGITUDE);
ID= unique(str2double(pm.SiteID));
pm_new= [total_ID,total_pm,total_site_lat,total_site_lon];
lat=unique(total_site_lat,'stable');
lon=unique(total_site_lon,'stable');
map_details= [ID, lat, lon];

%% Analyzing Data

%avg
for i=1:length(ID)
    location_site=find(pm_new==ID(i));
    avg_site(i,1)=mean(total_pm(location_site)); 
end

%min
for i=1:length(ID)
    location_site=find(pm_new==ID(i));
    min_site(i,1)=min(total_pm(location_site)); 
end

%max
for i=1:length(ID)
    location_site=find(pm_new==ID(i));
    max_site(i,1)=max(total_pm(location_site)); 
end
%anom
total_avg= mean(avg_site);
anom_site=total_avg-avg_site;
%% Mapping PM2.5
latlim = [min(lat) max(lat)];
lonlim = [min(lon) max(lon)];
[latlim, lonlim] = bufgeoquad(latlim, lonlim, .05, .05);
states = geoshape(shaperead('usastatehi', 'UseGeoCoords', true));
oceanColor = [.5 .7 .9];
figure (2)
ax = usamap(latlim, lonlim);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
cmocean('amp')
colormap
scatterm(lat, lon, 150, avg_site, 'filled')
plotm(41.8757,-87.6243,'k*') 
textm(41.8757,-87.61,'Downtown') 
title('Average Daily PM2.5 Concentration (ug/m3 LC) in the Greater Chicago Region')
%% Narrowing Down the Data
cut_lat=42.1
cut_lon=-87.45
cut_lon_extra=-87.9
small=find((lat<=cut_lat)&(lon<=cut_lon)&(lon>=cut_lon_extra))
small_lat=lat(small)
small_lon=lon(small)
small_pm= avg_site(small)

%% Narrowed Down Map
latlim = [min(lat) max(lat)];
lonlim = [min(lon) max(lon)];
[latlim, lonlim] = bufgeoquad(latlim, lonlim, .05, .05);
states = geoshape(shaperead('usastatehi', 'UseGeoCoords', true));
oceanColor = [.5 .7 .9];
figure (3)
ax = usamap(latlim, lonlim);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
cmocean('amp')
colormap
scatterm(small_lat, small_lon, 150, small_pm, 'filled')
%text(41.8757, -87.6243, '(Downtown)');
plotm(41.8757,-87.6243,'k*') 
textm(41.8757,-87.61,'Downtown') 
title('PM2.5 Sites Within the Demogrpahic Parameter')
%% Creating the Combination Figure
%Matching the Closest Sites
dist = sqrt((demlat-small_lat').^2 + (demlon-small_lon').^2);
dist(dist == 0) = Inf;
[~,closest_id] = min(dist);
close_arrays=(closest_id)'
%12 locations of dem closest to pm2.5 data
close_lat= demlat(close_arrays(:))
close_lon= demlon(close_arrays(:))
close_lat_lon= [close_lat, close_lon]
black_close= minority_percent(close_arrays)
x = black_close;
y = small_pm;
scatter(x,y,75,'filled', 'b')
xlabel('Percentage of Black Residents (%)')
ylabel('Average Daily PM2.5 Concentration (ug/m3 LC)')
h=lsline
set(h,'color', 'r')
slope=.0102*x+9.5747
title('Correlation Between the Percentage of Black Residents and PM2.5 Pollution') 
%% Past Work that isn't what we want
% dist = sqrt((small_lat-demlat').^2 + (small_lon-demlon').^2);
% dist(dist == 0) = Inf;
% [~,closest_id] = min(dist);
% %77locations of pm2.5 closest to demo data
% close_arrays=(closest_id)'
% close_lat= small_lat(close_arrays(:))
% close_lon= small_lon(close_arrays(:))
% close_lat_lon= [close_lat, close_lon]
% pm_close= small_pm(close_arrays)
% y = pm_close
% x = minority_percent
% scatter(x,y)
% xlabel('Percentage of Black Residents')
% ylabel('Average Daily PM2.5 Concentration')
% lsline
%% finding the distance statistics
for i= 1:12
dist_total = sqrt((demlat(close_arrays)-small_lat(i)').^2 + (demlon(close_arrays)-small_lon(i)').^2);
end 
dist_mean=mean(dist_total)
dist_min=min(dist_total)
dist_max=max(dist_total)
lat_lon=.1
km=6
km_dist_min=dist_min/lat_lon/km
km_dist_max=dist_max/lat_lon/km
km_dist_avg=dist_mean/lat_lon/km
