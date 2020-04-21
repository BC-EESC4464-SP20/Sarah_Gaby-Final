%%Getting minority averages for each town
%%Mapping towns 
%%Filling map circles with minority averages
%% Inital Steps
filename= 'Dem_lat:lon.csv';
demlatlon = readtable(filename);
    %for some reason ^^^ that doesn't work --> but if you import the data
    %directly it works and creates its own variable - confusing?
demlat = table2array(Demlatlon(:,2));
demlon = table2array(Demlatlon(:,3));

filename2 = 'CCASF12010CMAP.xlsx'
help = readtable(filename2);


%% Getting Minority Averages for Each Town

%% Pulling over the Latitude and Longitude
