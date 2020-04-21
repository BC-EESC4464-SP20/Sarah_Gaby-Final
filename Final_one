filename= 'ad_viz_plotval_data.csv';
%%pm= (filename);
pm_new= [pm.SiteID, pm.SITE_LATITUDE, pm.SITE_LONGITUDE, pm.DailyMeanPM2_5Concentration]
total_pm= pm.DailyMeanPM2_5Concentration
sitelat= unique((pm.SITE_LATITUDE));
sitelon= unique(pm.SITE_LONGITUDE);
siteid= unique(pm.SiteID);
%%
%y=splitapply(mean, pm.DailyMeanPM2_5Concentration, pm.SiteID)
%from list of ids, find averages from a different list in corresponding
%loop over all site IDs, loop to length site ID and find where site ID of
%original 