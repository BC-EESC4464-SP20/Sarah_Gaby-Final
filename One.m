filename= 'ad_viz_plotval_data.csv';
pm = readtable(filename);
total_pm= str2double(pm.DailyMeanPM2_5Concentration)
total_ID= str2double(pm.SiteID)
total_site_lat=str2double(pm.SITE_LATITUDE);
total_site_lon=str2double(pm.SITE_LONGITUDE);
ID= unique(str2double(pm.SiteID));
pm_new= [total_ID,total_pm,total_site_lat,total_site_lon]
lat=unique(total_site_lat,'stable')
lon=unique(total_site_lon,'stable')
map_details= [ID, lat, lon]

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
total_avg= mean(avg_site)
anom_site=total_avg-avg_site
%%
%maybe put a marker at downtown Chicago for point of reference
latlim = [min(lat) max(lat)];
lonlim = [min(lon) max(lon)];
[latlim, lonlim] = bufgeoquad(latlim, lonlim, .05, .05);
%%
% Locations of Demographic Data (77) 
figure (3)
ax = usamap(latlim, lonlim);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
geoshow(placenames)
plotm(latlon,'m.','markersize',15) % 77 locations of where we have data for demographics
%%
% Percent of Population that is a Minority at Each of Locations
figure (2)
ax = usamap(latlim, lonlim);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
geoshow(placenames)
cmocean('gray')
scatterm(lat, lon, 100, minority_percent, 'filled')