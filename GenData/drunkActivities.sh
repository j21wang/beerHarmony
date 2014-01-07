#!/bin/bash

curl http://www.cs.earlham.edu/~jimg/reading/bored.html | grep '<br>' | grep '-' | awk -F '- ' '{print $2}' | awk -F '<br>' '{print $1}' | sed s/"'"/""/g > drunkActivities.txt

while read activity
do
   count=`echo ${activity} | wc -m`
   if [ ${count} -gt 10 ]; then
      echo "INSERTING ${activity}"
      mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO drunkActivity (activityName) VALUES ('${activity}');"
   fi
done < drunkActivities.txt
