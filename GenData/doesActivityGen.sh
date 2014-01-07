#!/bin/bash

activityfile='drinkeractivity.txt'
drinkerfile='drinkers.txt'


mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT activityName FROM drunkActivity;" > "${activityfile}"
mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT drinkerID FROM drinker;" > "${drinkerfile}"

#read bar file and put contents into parallel arrays
i=0
activitycount=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM drunkActivity;"`
activitycount=`expr ${activitycount} - 1`

while read line; do
	activities[${i}]="${line}"
	i=`expr ${i} + 1`
done < "${activityfile}"

numInsert=0
# for each drinker, go through each drunk type and randomly see if should be inserted
while read id; do
	for activity in "${activities[@]}"; do
		if [ ${RANDOM} -lt 200 ]; then # insert at ~1%
			echo "INSERTING activityName='${activity}' as an activity for drinkerID='${id}'"
			mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO doesActivity (drinkerID, activityName) VALUES ('${id}', '${activity}');"
			numInsert=`expr ${numInsert} + 1`
		fi
	done
done < "${drinkerfile}"

#check and make sure all drinkers have atleast one type
again=1
while true; do
	if [ ${again} -eq 0 ]; then
		break;
	fi
	again=0
	while read id; do
		count=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM doesActivity where drinkerID=${id};"`
		if [ ${count} -eq 0 ]; then
			again=1
			for activity in "${activities[@]}"; do
				if [ ${RANDOM} -lt 200 ]; then # insert at ~1%
					echo "INSERTING drunkType='${activity}' as an activity for drinkerID='${id}'"
					mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO doesActivity (drinkerID, activityName) VALUES ('${id}', '${activity}');"
					numInsert=`expr ${numInsert} + 1`
				fi
			done
		fi
	done < "${drinkerfile}"
done

echo "DONE - inserted ${numInsert}"
