demlon = table2array(Demlatlon(:,2));
demlat = table2array(Demlatlon(:,3));
lat=unique(total_site_lat,'stable')
lon=unique(total_site_lon,'stable')
%%
latlim = [min(lat) max(lat)];
lonlim = [min(lon) max(lon)];
[latlim, lonlim] = bufgeoquad(latlim, lonlim, .05, .05);
states = geoshape(shaperead('usastatehi', 'UseGeoCoords', true));
oceanColor = [.5 .7 .9];
%%
ax = usamap(latlim, lonlim);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
plotm(41.8757,-87.6243,'k*') 
textm(41.8757,-87.61,'Downtown') 
hold on 
for i=1:26
plotm(lat(i),lon(i),'m.','markersize',15);
scatterm(lat(i), lon(i), 50, avg_site(i), 'filled');
cmocean('amp');

end 
hold on
for i=1:77
plotm(demlat(i),demlon(i),'m.','markersize',15);
scatterm(demlat(i), demlon(i), 50, minority_percent(i), 'filled');
cmocean('gray')
end 
hold off