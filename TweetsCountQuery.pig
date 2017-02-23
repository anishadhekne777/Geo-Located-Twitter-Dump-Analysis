REGISTER file:/etc/Pig/pig-0.16.0/lib/piggybank.jar
DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVLoader;
SET default_parallel 10;

tweets= LOAD '/DATA1.txt' using PigStorage(',') AS (TweetId,Date,Hour,UserName,Nickname,Favs,RTs,Latitude,Longitude,Country,Place,State,Followers,Following,Listed,Tweetlanguage,TweetUrl);
projectTweets= FOREACH tweets GENERATE TweetId,Date,Hour,UserName,Nickname,- Longitude AS timezone,Place,State;
--STORE projectUser INTO '/Output/projectUser' USING PigStorage(',');

-- filter the users dataset according to the longitude values
filterTweetsCentral= FILTER projectTweets BY timezone >=85 AND $5<100;
filterTweetsEast= FILTER projectTweets BY timezone <85;
filterTweetsMountain= FILTER projectTweets BY timezone >=100 AND $5<120;
filterTweetsPacific= FILTER projectTweets BY timezone >=120;

-- Generate Tweets Count for Central Time Zone
filterTweetsCentralAll= GROUP filterTweetsCentral ALL;
TweetsCentralCount= FOREACH filterTweetsCentralAll GENERATE ('Central TimeZone Tweets',COUNT($1.$0));
STORE TweetsCentralCount INTO '/Output/Central/CentralTweetsCount' USING PigStorage(',');

-- Generate Tweets Count for Eastern Time Zone
filterTweetsEastAll= GROUP filterTweetsEast ALL;
TweetsEastCount= FOREACH filterTweetsEastAll GENERATE ('East TimeZone Tweets',COUNT($1.$0));
STORE TweetsEastCount INTO '/Output/East/EastTweetsCount' USING PigStorage(',');

-- Generate Tweets Count for Mountain Time Zone
filterTweetsMountainAll= GROUP filterTweetsMountain ALL;
TweetsMountainCount= FOREACH filterTweetsMountainAll GENERATE ('Mountain TimeZone Tweets',COUNT($1.$0));
STORE TweetsMountainCount INTO '/Output/Mountain/MountainTweetsCount' USING PigStorage(',');

-- Generate Tweets Count for Pacific Time Zone
filterTweetsPacificAll= GROUP filterTweetsPacific ALL;
TweetsPacificCount= FOREACH filterTweetsPacificAll GENERATE ('Pacific TimeZone Tweets',COUNT($1.$0));
STORE TweetsPacificCount INTO '/Output/Pacific/PacificTweetsCount' USING PigStorage(',');

