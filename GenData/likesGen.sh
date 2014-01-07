#!/bin/bash

beerfile='beers.txt'
drinkerfile='drinkers.txt'


mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT beerName FROM beer;" > "${beerfile}"
mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT drinkerID FROM drinker;" > "${drinkerfile}"

#read bar file and put contents into parallel arrays
i=0
beercount=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM beer;"`
beercount=`expr ${beercount} - 1`

while read line; do
	beers[${i}]="${line}"
	i=`expr ${i} + 1`
done < "${beerfile}"

numInsert=0
# for each drinker, go through each beer and randomly see if should be inserted
while read id; do
	for beer in "${beers[@]}"; do
		if [ ${RANDOM} -lt 1000 ]; then # insert at ~20%
			echo "INSERTING beer='${beer}' as liked by drinkerID='${id}'"
			mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO likes (drinkerID, beerName) VALUES ('${id}', '${beer}');"
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
		count=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM likes where drinkerID=${id};"`
		if [ ${count} -eq 0 ]; then
			again=1
			for beer in "${beers[@]}"; do
				if [ ${RANDOM} -lt 1000 ]; then # insert at ~1%
					echo "INSERTING beer='${beer}' as liked by drinkerID='${id}'"
					mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO likes (drinkerID, beerName) VALUES ('${id}', '${beer}');"
					numInsert=`expr ${numInsert} + 1`
				fi
			done
		fi
	done < "${drinkerfile}"
done

echo "DONE - inserted ${numInsert}"
