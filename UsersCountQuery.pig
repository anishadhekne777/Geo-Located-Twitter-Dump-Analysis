REGISTER file:/etc/Pig/pig-0.16.0/lib/piggybank.jar
DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVLoader;
SET default_parallel 10;


-- Load Data in PigStorage and retrieve required tuple attributes
users= LOAD '/DATA1.txt' using PigStorage(',') AS (TweetId,Date,Hour,UserName,Nickname,Favs,RTs,Latitude,Longitude,Country,Place,State,Followers,Following,Listed,Tweetlanguage,TweetUrl);
projectUser= FOREACH users GENERATE TweetId,Date,Hour,UserName,Nickname,- Longitude AS timezone,Place,State;
--STORE projectUser INTO '/Output/projectUser' USING PigStorage(',');

-- filter the users dataset according to the longitude values
filterUsersCentral= FILTER projectUser BY timezone >=85 AND $5<100;
filterUsersEast= FILTER projectUser BY timezone <85;
filterUsersMountain= FILTER projectUser BY timezone >=100 AND $5<120;
filterUsersPacific= FILTER projectUser BY timezone >=120;

-- Generate User Count for Central TimeZone
CentralDistinctUser= DISTINCT (FOREACH filterUsersCentral GENERATE ($3,$4));
CentralDistinctUsersAll = GROUP CentralDistinctUser ALL;
UserCentralCount= FOREACH CentralDistinctUsersAll GENERATE ('Central TimeZone Users',COUNT($1));
STORE UserCentralCount INTO '/Output/Central/CentralUserCount' USING PigStorage(',');

-- Generate User Count for Eastern TimeZone
EastDistinctUser= DISTINCT (FOREACH filterUsersEast GENERATE ($3,$4));
EastDistinctUsersAll = GROUP EastDistinctUser ALL;
UserEastCount= FOREACH EastDistinctUsersAll GENERATE ('East TimeZone Users',COUNT($1));
STORE UserEastCount INTO '/Output/East/EastUserCount' USING PigStorage(',');

-- Generate User Count for Mountain TimeZone
MountainDistinctUser= DISTINCT (FOREACH filterUsersMountain GENERATE ($3,$4));
MountainDistinctUsersAll = GROUP MountainDistinctUser ALL;
UserMountainCount= FOREACH MountainDistinctUsersAll GENERATE ('Mountain TimeZone Users',COUNT($1));
STORE UserMountainCount INTO '/Output/Mountain/MountainUserCount' USING PigStorage(',');

-- Generate User Count for Pacific TimeZone
PacificDistinctUser= DISTINCT (FOREACH filterUsersPacific GENERATE ($3,$4));
PacificDistinctUsersAll = GROUP PacificDistinctUser ALL;
UserPacificCount= FOREACH PacificDistinctUsersAll GENERATE ('Pacific TimeZone Users',COUNT($1));
STORE UserPacificCount INTO '/Output/Pacific/PacificUserCount' USING PigStorage(',');
