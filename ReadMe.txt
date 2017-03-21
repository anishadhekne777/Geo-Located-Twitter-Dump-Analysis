======================================================================
CS 643, Cloud Computing - Fall ‘16 Project-Geolocated Twitter Analysis
by Anisha Dhekne(UCID: aad48)
Date: 12/12/2016
======================================================================

1. Login as IAM User in AWS account
2. Download and install Hadoop.
3. Create multinode Hadoop Cluster
4. Download and install Pig 
	i. Make the folder for installation using mkdir (Repeat for all the instances)
		sudo mkdir Pig
	ii.Download Pig latest stable version (Repeat for all the instaces)
		sudo wget http://apache.mirrors.pair.com/pig/pig-0.16.0/pig-0.16.0.tar.gz
	iii. Install in the created folder (/etc/Pig) (Repeat for all the instances)
		tar -xvf pig-0.16.0.tar.gz
	iv. Create a log directory and change the ownership (Repeat for all the instances)
		ubuntu@ip-172-31-19-157:/$sudo mkdir -p /opt/pig/logs
5. Configure PATH variables in the .bashrc file
   export PIG_HOME=/etc/Pig/pig-0.16.0
6. Verify Pig Version
		source .bashrc
		pig version
7.Run Pig in Local Mode:
                $ pig -x local
		... - Connecting to ...
		grunt>
8. Run Pig in Mapreduce Mode:
     		$ pig 
		... - Connecting to ...
		grunt>
9. Load data into HDFS
	i. In MapReduce mode, Pig reads (loads) data from HDFS and stores the results back in HDFS.
		Format Name Node   (Master): hdfs namenode -format
	        Start HDFS service (Master): start-dfs.sh
	        Start YARN Service (Master): start-yarn.sh
	ii.Move the data file from the local file system to HDFS using put command. 
		$ hdfs dfs -put /etc/Pig/DATA1.txt /
		$ hdfs dfs -put /etc/Pig/DATA1.csv /
	iii.Verify whether the file has been moved into the HDFS
                $ hdfs dfs -cat /DATA1.txt
		$ hdfs dfs -cat /DATA1.csv
	iv. Load data from file DATA1.txt and DATA1.csv into Pig by  executing Pig Latin statement in the Grunt shell.
	
10. Query Execution
	1. pig UserCountQuery.pig
	2. pig TweetCountQuery.pig
	3. pig TweetsFilterQuery.pig
	4. pig ReTweetsFilterQuery.pig
	5. hdfs dfs -copyToLocal /Output/Central/CentralUserCount/* /home/ubuntu/
	6. hdfs dfs -copyToLocal /Output/Eastern/EastUserCount/* /home/ubuntu/
	7. hdfs dfs -copyToLocal /Output/Mountain/MountainUserCount/* /home/ubuntu/
	8. hdfs dfs -copyToLocal /Output/Pacific/PacificUserCount/* /home/ubuntu/
	9. hdfs dfs -copyToLocal /Output/Central/CentralTweetsCount/* /home/ubuntu/
	10. hdfs dfs -copyToLocal /Output/Eastern/EastTweetsCount/* /home/ubuntu/
	11. hdfs dfs -copyToLocal /Output/Mountain/MountainTweetsCount/* /home/ubuntu/
	12. hdfs dfs -copyToLocal /Output/Pacific/PacificTweetsCount/* /home/ubuntu/
	13. hdfs dfs -copyToLocal /Output/GroupTweetsPlace/* /home/ubuntu/
	14. hdfs dfs -copyToLocal /Output/GroupTweetsState/* /home/ubuntu/
	15. hdfs dfs -copyToLocal /Output/TweetCount/* /home/ubuntu/	
	16. hdfs dfs -copyToLocal /Output/ReTweetCount/* /home/ubuntu/
11. Copy the data from /home/ubuntu to local machine using WinScp.
12. Merge the data using excel and Data visualization graphs can be plotted according to the data obtained.
	


 
