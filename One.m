filename= 'ad_viz_plotval_data.csv';
pm = readtable(filename);
%pm_new= [pm.SiteID, pm.SITE_LATITUDE, pm.SITE_LONGITUDE, pm.DailyMeanPM2_5Concentration]
total_pm= str2double(pm.DailyMeanPM2_5Concentration)
sitelat= unique(str2double(pm.SITE_LATITUDE));
sitelon= unique(str2double(pm.SITE_LONGITUDE));
ID= unique(str2double(pm.SiteID));

%%
mean(total_pm(1:15))

%y=splitapply(mean, pm.DailyMeanPM2_5Concentration, pm.SiteID)
%from list of ids, find averages from a different list in corresponding
%loop over all site IDs, loop to length site ID and find where site ID of
%original