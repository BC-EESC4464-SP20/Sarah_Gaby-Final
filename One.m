filename= 'ad_viz_plotval_data.csv';
pm = readtable(filename);
total_pm= str2double(pm.DailyMeanPM2_5Concentration)
total_ID= str2double(pm.SiteID)
sitelat= unique(str2double(pm.SITE_LATITUDE));
sitelon= unique(str2double(pm.SITE_LONGITUDE));
ID= unique(str2double(pm.SiteID));
pm_new= [total_ID,total_pm]

%%
for i=1:26
    location_site=find(pm_new==ID(i));
    %pm_specific= location_site(pm_new(i))
end 
%y=splitapply(mean, pm.DailyMeanPM2_5Concentration, pm.SiteID)
%from list of ids, find averages from a different list in corresponding
%loop over all site IDs, loop to length site ID and find where site ID of
%original