demlon = table2array(Demlatlon(:,2));
demlat = table2array(Demlatlon(:,3));
lat=unique(total_site_lat,'stable')
lon=unique(total_site_lon,'stable')
%%
latlim_2 = [min(demlat) max(demlat)];
lonlim_2 = [min(demlon) max(demlon)];
[latlim_2, lonlim_2] = bufgeoquad(latlim_2, lonlim_2, .05, .05);
states = geoshape(shaperead('usastatehi', 'UseGeoCoords', true));
oceanColor = [.5 .7 .9];
%%

figure(9)
ax = usamap(latlim_2, lonlim_2);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
plotm(41.8757,-87.6243,'k*') 
textm(41.8757,-87.61,'Downtown') 
hold on 

for i=1:12
plotm(small_lat(i),small_lon(i),'m.','markersize',15);
scatterm(small_lat(i), small_lon(i), 50, small_pm(i), 'filled');
cmocean('amp');
end 


for i=1:77
cmocean('gray')
    plotm(demlat(i),demlon(i),'m.','markersize',15);
scatterm(demlat(i), demlon(i), 50, minority_percent(i), 'filled');
end 

hold on
%%
figure (10)
ax = usamap(latlim_2, lonlim_2);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
plotm(41.8757,-87.6243,'k*') 
textm(41.8757,-87.61,'Downtown') 

for i=1:77
cmocean('gray')
    plotm(demlat(i),demlon(i),'m.','markersize',15);
scatterm(demlat(i), demlon(i), 50, minority_percent(i), 'filled');
end 
hold off
%%
% %%
% new_new_new= (small_lat, small_lon, small_pm)
% new_new_new_new= (demlat, demlon, minority_percent)

new_nan= NaN(width(3), length(89))