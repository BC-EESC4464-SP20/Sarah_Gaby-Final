%% Matching the Closest Sites
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
p2 = polyfit(get(h,'x'),get(h,'y'),1)
slope=.0102*x+9.5747
x=1
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