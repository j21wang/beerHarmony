#!/bin/bash

file='bars.txt'

mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT * FROM bar;" > "${file}"

chars=( 0 1 2 3 4 5 6 7 8 9 'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' )

while read line; do
	key=''
	barLoc=`echo "${line}" | awk -F '\t' '{print $2}'`
	barName=`echo "${line}" | awk -F '\t' '{print $3}'`
	for i in {1..10}; do
		k=`expr ${RANDOM} % 36`
		key="${key}${chars[${k}]}"
	done
	echo "INSERTING license ${key} for '${barName}' in '${barLoc}'"
	mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE bar SET license='${key}' WHERE location='${barLoc}' AND barName='${barName}';"
done < "${file}"
