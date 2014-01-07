#!/bin/bash

beerfile='beers.txt'
barfile='bars.txt'
sellsfile='sells.txt'


mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT beerName FROM beer;" > "${beerfile}"
mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT * FROM bar;" > "${barfile}"

#read bar file and put contents into parallel arrays
i=0
beercount=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM beer;"`
beercount=`expr ${beercount} - 1`

while read line; do
	beers[${i}]="${line}"
	echo ${beers[${i}]}
	i=`expr ${i} + 1`
done < "${beerfile}"

numInsert=0
# for each drinker, go through each bar and randomly see if should be inserted
while read line; do
	barLoc="`echo "$line" | awk -F '\t' '{print $2}'`"
	barName="`echo "$line" | awk -F '\t' '{print $3}'`"
	for beer in "${beers[@]}"; do
		if [ ${RANDOM} -lt 25000 ]; then # insert
			echo "INSERTING beer='${beer}' as sold at '${barName}' in '${barLoc}'"
			mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO sells (barName, location, beerName) VALUES ('${barName}', '${barLoc}', '${beer}');"
			numInsert=`expr ${numInsert} + 1`
		fi
	done
done < "${barfile}"


mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT * FROM sells;" > "${sellsfile}"
numRows=`mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT count(*) FROM sells;"`

cunderMax=$((${numRows} * 4/5)) #implicit floor
coverMax=$((${numRows} * 1/5)) #implicit floor
rem=$((${numRows} - ${cunderMax} - ${coverMax}))
if [ rem -gt 0 ]; then
	coverMax=$((${coverMax} + ${rem}))
fi
cunder=0
cover=0
while read line; do
	barName="`echo "$line" | awk -F '\t' '{print $1}'`"
	barLoc="`echo "$line" | awk -F '\t' '{print $2}'`"
	beer="`echo "$line" | awk -F '\t' '{print $3}'`"
	while true; do
		# generate price and cents
		dollars=`expr ${RANDOM} % 18`
		dollars=`expr ${dollars} + 3`
		cents=`expr ${RANDOM} % 3`
		if [ ${cents} -eq 0 ]; then
			cents=50
		elif [ ${cents} -eq 1 ]; then
			cents=99
		else
			cents=0
		fi
		price="${dollars}.${cents}"
		
		if [ ${dollars} -le 10 ]; then
			if [ ${cunder} -eq ${cunderMax} ]; then
				continue
			else
				cunder=`expr ${cunder} + 1`
				echo "UPDATING price=${price} for beerName=${beer} at '${barName}' in '${barLoc}'"
				mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE sells SET price='${price}' WHERE beerName='${beer}' AND barName='${barName}' AND location='${barLoc}';"
				break
			fi
		else
			if [ ${cover} -eq ${coverMax} ]; then
				continue
			else
				cover=`expr ${cover} + 1`
				echo "UPDATING price=${price} for beerName=${beer} at '${barName}' in '${barLoc}'"
				mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE sells SET price='${price}' WHERE beerName='${beer}' AND barName='${barName}' AND location='${barLoc}';"
				break
			fi
		fi
	done
done < "${sellsfile}"

total=`expr ${cover} + ${cunder}`
echo "DONE - inserted ${numInsert} and updated ${total} prices"
