#!/bin/bash

file='drinkerAges.txt'

mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT * FROM drinker;" > "${file}"

cUnderage=0
cOfAge=0
cSenior=0
while read line; do
	id=`echo "${line}" | awk -F '\t' '{print $1}'`
	while true; do
		n=`expr ${RANDOM} % 81`
		n=`expr ${n} + 10`
		if [ ${n} -lt 21 ]; then
			if [ ${cUnderage} -eq 15 ]; then
				continue
			else
				cUnderage=`expr ${cUnderage} + 1`
				echo "INSERTING age=${n} for drinkerID=${id}"
				mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE drinker SET age=${n} WHERE drinkerID=${id};"
				next=1
				break
			fi
		elif [ ${n} -ge 65 ]; then
			if [ ${cSenior} -eq 55 ]; then
				continue
			else
				cSenior=`expr ${cSenior} + 1`
				echo "INSERTING age=${n} for drinkerID=${id}"
				mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE drinker SET age=${n} WHERE drinkerID=${id};"
				next=1
				break
			fi
		else
			if [ ${cOfAge} -eq 200 ]; then
				continue
			else
				cOfAge=`expr ${cOfAge} + 1`
				echo "INSERTING age=${n} for drinkerID=${id}"
				mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE drinker SET age=${n} WHERE drinkerID=${id};"
				next=1
				break
			fi
		fi
	done;
	next=0
done < "${file}"
