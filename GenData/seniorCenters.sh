#!/bin/bash

file='seniors.txt'

mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT drinkerID FROM seniorDrinker;" > "${file}"

count=0

while read line; do
   id=`echo "${line}"`
   while true; do
      n=`expr ${RANDOM} % 851`
      n=`expr ${n} + 1`
      home=`head -n ${n} seniorCenters.txt | tail -n 1`

      echo "$home"
      if [ $? -eq 0 ]; then
         if [ ${count} -eq 55 ]; then
            continue
         else 
            count=`expr ${count} + 1`
            echo "INSERTING job=${home} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE seniorDrinker SET seniorCitizenHome='${home}' WHERE drinkerID=${id};"
            break
         fi
      fi

   done;
done < "${file}"
