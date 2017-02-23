REGISTER file:/etc/Pig/pig-0.16.0/lib/piggybank.jar
DEFINE CSVLoader org.apache.pig.piggybank.storage.CSVLoader;
DEFINE TextLoader org.apache.pig.piggybank.storage.AllLoader;
SET default_parallel 10;

users = LOAD '/DATA1.csv' USING PigStorage(',') AS (TweetId,Date,Hour,UserName,Nickname,Bio,Tweetcontent,Favs,RTs,Latitude,Longitude,Country,Place,Profilepicture,Followers,Following,Listed,Tweetlanguage,TweetUrl);
projectTweets= FOREACH users GENERATE ($0,$3);

-- Generate Tweet Count by each user 
TweetCount= GROUP projectTweets BY ($0.$1);
TweetCountFinal= FOREACH TweetCount GENERATE group,COUNT($1.$0);
TweetCountFinalOrder = ORDER TweetCountFinal BY $1 DESC;
STORE TweetCountFinalOrder INTO '/Output/TweetCount' USING PigStorage(',');

-- Generate  ReTweet count by different users
projectReTweets= FOREACH users GENERATE ($3,$6);
ReTweetCount= GROUP projectReTweets BY ($0.$1);
ReTweetCountFinal= FOREACH ReTweetCount GENERATE group,COUNT($1.$0);
ReTweetCountFinalOrder = ORDER ReTweetCountFinal BY $1 DESC;
STORE ReTweetCountFinalOrder INTO '/Output/ReTweetCount' USING PigStorage(',');

-- Generate Tweet count by each user
projectReTweets= FOREACH users GENERATE ($0,$6);
ActiveTweets= GROUP projectTweets BY ($0.$1);
ActiveTweetsCountFinal= FOREACH ActiveTweets GENERATE group,COUNT($1.$0);
ActiveTweetsCountFinalOrder = ORDER ActiveTweetsCountFinal BY $1 DESC;
STORE ActiveTweetsCountFinalOrder INTO '/Output/ActiveTweetsCount' USING PigStorage(',');

