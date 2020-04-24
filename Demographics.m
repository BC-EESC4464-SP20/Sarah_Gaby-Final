%Steps before running
    % Add Common Functions to Path, Import Demlatlon data
%% To- Do List
    %Getting minority averages for each town
    %Mapping towns 
    %Filling map circles with minority averages
%% Inital Steps - Filtering Files Over to Matlab
% filename= 'Dem_lat:lon.csv';
% demlatlon = readtable(filename);
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
    %maybe put a marker at downtown Chicago for point of reference
    
% Other
states = geoshape(shaperead('usastatehi', 'UseGeoCoords', true));
oceanColor = [.5 .7 .9];

latlim_2 = [min(demlat) max(demlat)];
lonlim_2 = [min(demlon) max(demlon)];
[latlim_2, lonlim_2] = bufgeoquad(latlim_2, lonlim_2, .05, .05);

% Percent of Population that is a Minority at Each of Locations
figure (2)
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
