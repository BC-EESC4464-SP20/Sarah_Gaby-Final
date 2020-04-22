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
n_a= str2double(population.P0050008(2:78));
bi= str2double(population.P0050009(2:78));
pac = str2double(population.P0050007(2:78));
asian= str2double(population.P0050005(2:78));
black = str2double(population.P0050004(2:78));
hispanic = str2double(population.P0050010(2:78));
minority =  black 

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

latlim = [min(demlat) max(demlat)];
lonlim = [min(demlon) max(demlon)];
[latlim, lonlim] = bufgeoquad(latlim, lonlim, .05, .05);

% Locations of Demographic Data (77) 
figure (1)
ax = usamap(latlim, lonlim);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
plotm(demlat,demlon,'m.','markersize',15) % 77 locations of where we have data for demographics

% Percent of Population that is a Minority at Each of Locations
figure (2)
ax = usamap(latlim, lonlim);
setm(ax, 'FFaceColor', oceanColor)
geoshow(states)
%cmocean('algae')
intensity = 64
newColormap = colormap(flipud(colormap('gray')))
newColormap = newColormap(1:intensity,:)
colormap(newColormap)
colormap(flipud(colormap('gray')));
scatterm(demlat, demlon, 100, minority_percent, 'filled')

