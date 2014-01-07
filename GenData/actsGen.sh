#!/bin/bash

typefile='drinkertypes.txt'
drinkerfile='drinkers.txt'


mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT drunkType FROM typeOfDrunk;" > "${typefile}"
mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT drinkerID FROM drinker;" > "${drinkerfile}"

#read bar file and put contents into parallel arrays
i=0
typecount=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM typeOfDrunk;"`
typecount=`expr ${typecount} - 1`

while read line; do
	types[${i}]="${line}"
	i=`expr ${i} + 1`
done < "${typefile}"

numInsert=0
# for each drinker, go through each drunk type and randomly see if should be inserted
while read id; do
	for type in "${types[@]}"; do
		if [ ${RANDOM} -lt 1500 ]; then # insert at ~5%
			echo "INSERTING drunkType='${type}' as a type for drinkerID='${id}'"
			mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO acts (drinkerID, drunkType) VALUES ('${id}', '${type}');"
			numInsert=`expr ${numInsert} + 1`
		fi
	done
done < "${drinkerfile}"

#check and make sure all drinkers have atleast one type
while true; do
	if [ ${again} -eq 0 ]; then
		break;
	fi
	again=0
	while read id; do
		count=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM acts where drinkerID=${id};"`
		if [ ${count} -eq 0 ]; then
			again=1
			for type in "${types[@]}"; do
				if [ ${RANDOM} -lt 1500 ]; then # insert at ~5%
					echo "INSERTING drunkType='${type}' as a type for drinkerID='${id}'"
					mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO acts (drinkerID, drunkType) VALUES ('${id}', '${type}');"
					numInsert=`expr ${numInsert} + 1`
				fi
			done
		fi
	done < "${drinkerfile}"
done

echo "DONE - inserted ${numInsert}"
