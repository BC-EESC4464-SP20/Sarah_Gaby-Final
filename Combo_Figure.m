%find the two sites that are most similiar and plot the %black with pm2.5
demlat_lon=[demlat,demlon]
dist = sqrt((demlat-lat').^2 + (demlon-lon').^2);
dist(dist == 0) = Inf;
[~,closest_id] = min(dist);
close_arrays=(closest_id)'
close_lat= demlat(close_arrays(:))
close_lon= demlon(close_arrays(:))
close_lat_lon= [close_lat, close_lon]
black_close= minority_percent(close_arrays)
x = black_close;
y = avg_site;
scatter(x,y)
xlabel('Percentage of Black Residents')
ylabel('Average Daily PM2.5 Concentration')
lsline