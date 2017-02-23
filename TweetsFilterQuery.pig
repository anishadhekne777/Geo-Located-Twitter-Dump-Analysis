REGISTER file:/etc/Pig/pig-0.16.0/lib/piggybank.jar
DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVLoader;
SET default_parallel 10;

users= LOAD '/DATA1.txt' using PigStorage(',') AS (TweetId,Date,Hour,UserName,Nickname,Favs,RTs,Latitude,Longitude,Country,Place,State,Followers,Following,Listed,Tweetlanguage,TweetUrl);
projectUser= FOREACH users GENERATE TweetId,Date,Hour,UserName,Nickname,- Longitude AS timezone,Place,Tweetlanguage;
--STORE projectUser INTO '/Output/projectUser' USING PigStorage(',');

-- filter the users dataset according to the longitude values
filterUsersCentral= FILTER projectUser BY timezone >=85 AND $5<100;
filterUsersEast= FILTER projectUser BY timezone <85;
filterUsersMountain= FILTER projectUser BY timezone >=100 AND $5<120;
filterUsersPacific= FILTER projectUser BY timezone >=120;

-- Generate Count of Tweets as per Place users are located
UsersGroup= GROUP users by Place;
UsersGroupCount= FOREACH UsersGroup GENERATE group,COUNT($1.$0); 
STORE UsersGroupCount INTO '/Output/GroupTweetsPlace' USING  PigStorage(',');

-- Generate Count of Tweets as per State users are located
UsersGroup= GROUP users by State;
UsersGroupCount= FOREACH UsersGroup GENERATE group,COUNT($1.$0);
STORE UsersGroupCount INTO '/Output/GroupTweetsState' USING  PigStorage(',');

-- Generate Count of Tweets as per Time Stamp
UsersGroup= GROUP users by (Date,Hour);
UsersGroupCount= FOREACH UsersGroup GENERATE group.Date,group.Hour,COUNT($1.$0);
STORE UsersGroupCount INTO '/Output/GroupTweetsTimeStamp' USING  PigStorage(',');

-- Generate Count of Tweets as per language
UsersGroup= GROUP projectUser by (Tweetlanguage);
UsersGroupCount= FOREACH UsersGroup GENERATE group,COUNT($1.$0);
STORE UsersGroupCount INTO '/Output/GroupTweetsLanguage' USING  PigStorage(',');

-- Store the results in separate output folders
--STORE filterUsersCentral INTO '/Output/filterPlace/Central' USING PigStorage(',');
--STORE groupEast INTO '/Output/filterPlace/East' USING PigStorage(',');
--STORE groupMountain INTO '/Output/filterPlace/Mountain' USING PigStorage(',');
--STORE groupPacific INTO '/Output/filterPlace/Pacific' USING PigStorage(',');
