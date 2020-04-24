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

%% avg
for i=1:length(ID)
    location_site=find(pm_new==ID(i));
    avg_site(i,1)=mean(total_pm(location_site)); 
end
%% min
for i=1:length(ID)
    location_site=find(pm_new==ID(i));
    min_site(i,1)=min(total_pm(location_site)); 
end
%% max
for i=1:length(ID)
    location_site=find(pm_new==ID(i));
    max_site(i,1)=max(total_pm(location_site)); 
end
%% anom
total_avg= mean(avg_site);
anom_site=total_avg-avg_site;
%%
latlim_2 = [min(demlat) max(demlat)];
lonlim_2 = [min(demlon) max(demlon)];
[latlim_2, lonlim_2] = bufgeoquad(latlim_2, lonlim_2, .05, .05);
states = geoshape(shaperead('usastatehi', 'UseGeoCoords', true));
oceanColor = [.5 .7 .9];
%%
% Locations of PM2.5 Data 
figure (1)
ax_2 = usamap(latlim_2, lonlim_2);
setm(ax_2, 'FFaceColor', oceanColor)
geoshow(states)
plotm(lat,lon,'m.','markersize',15) 
%%
%avg
figure (2)
ax_2 = usamap(latlim_2, lonlim_2);
setm(ax_2, 'FFaceColor', oceanColor)
geoshow(states)
cmocean('amp')
colormap
scatterm(lat, lon, 150, avg_site, 'filled')
%text(41.8757, -87.6243, '(Downtown)');
plotm(41.8757,-87.6243,'k*') 
textm(41.8757,-87.61,'Downtown') 

