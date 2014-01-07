#!/bin/bash

drinkerfile='drinkers.txt'
barfile='bars.txt'

mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT drinkerID FROM drinker;" > "${drinkerfile}"
mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT * FROM bar;" > "${barfile}"

#read bar file and put contents into parallel arrays
i=0
barcount=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM bar;"`
barcount=`expr ${barcount} - 1`

while read line; do
	echo "${line}" | awk -F '\t' '{print $1}'
	barLocs[${i}]="`echo \"${line}\" | awk -F '\t' '{print $2}'`"
	barNames[${i}]="`echo \"${line}\" | awk -F '\t' '{print $3}'`"
	barFreqCount[${i}]=0
	i=`expr ${i} + 1`
done < "${barfile}"

numInsert=0
# for each drinker, go through each bar and randomly see if should be inserted
while read id; do
	for i in {0..47}; do
		if [ ${RANDOM} -lt 10000 ]; then # insert
			barFreqCount[${i}]=`expr ${barFreqCount[${i}]} + 1`
			echo "INSERTING drinkerID=${id} as frequenting '${barNames[${i}]}' in '${barLocs[${i}]}'"
			mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO frequents (drinkerID, location, barName) VALUES (${id}, '${barLocs[${i}]}', '${barNames[${i}]}');"
			numInsert=`expr ${numInsert} + 1`
		fi
	done
done < "${drinkerfile}"

echo "\nChecking for bars without drinkers\n"

numDrinkers=`wc -l ${drinkerfile}`
for i in {0..47}; do
	exists=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM frequents WHERE location='${barLocs[$i]}' AND barName='${barNames[$i]}'"`
	if [ ${exists} -eq 0 ]; then # this bar has no drinkers
		# choose 5 drinkers at random and insert
		for k in 1 2 3 4 5; do
			rand=`expr ${RANDOM} % ${numDrinkers}`
			rand=`expr ${rand} + 1`
			randomDrinker=`head -n ${rand} | tail -n 1`
		
			echo "INSERTING drinkerID=${randomDrinker} as frequenting '${barNames[${i}]}' in '${barLocs[${i}]}'"
			mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO frequents (drinkerID, location, barName) VALUES (${randomDrinker}, '${barLocs[${i}]}', '${barNames[${i}]}');"
			numInsert=`expr ${numInsert} + 1`
		done
	fi
done

echo "DONE - inserted ${numInsert}"
