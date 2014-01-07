#!/bin/bash
link='http://www.people.com'
file='peoplenames-web.txt'
file2='peoplenames.txt'
filelinks='peoplelinks.txt'
src='peoplesrc.txt'
sex='peoplesex.txt'

curl "${link}/people/celebrities" | sed -n '210p' | sed -e 's/<dd>/<dd>\n/g' | sed -e '1d' > "${file}"

cat "${file}" | sed -e 's/&#233;/e/g' | sed -e 's/&#235;/e/g' | sed -e 's/&#252/u/g' | awk -F '>' '{print $2}' | awk -F '<' '{print $1}' > "${file2}"
cat "${file}" | awk -F '"' '{print $2}' > "${filelinks}"

# get sex
while read l; do
	echo $l
	curl "${link}${l}" | grep -e 'snapshotFacts' > "${src}"
	f=`grep  -c -E -e ' [sS]he' "${src}"`
	f2=`grep  -c -E -e ' [hH]er' "${src}"`
	m=`grep  -c -E -e ' [hH]e ' "${src}"`
	m2=`grep  -c -E -e ' [hH]im ' "${src}"`
	f3=`expr ${f} + ${f2}`
	m3=`expr ${m} + ${m2}`
	if [ ${m3} -gt ${f3} ]; then
		echo "m" >> "${sex}"
	elif [ ${m3} -lt ${f3} ]; then
		echo "f" >> "${sex}"
	else
		echo "u" >> "${sex}" # 0 vs 0, will go through manually and change these names
	fi
done < "${filelinks}"

i=0
while read name; do
	s=`head -n 1 "${sex}"`
	sed -e '1d' -i "${sex}"
	echo "INSERTING ${s}  ${name}"
	mysql -u "csuser" --port 3306 --host cs336-12.cs.rutgers.edu bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO drinker (drinkerID, name, gender) VALUES (${i}, '${name}', '${s}');"
	i=`expr ${i} + 1`
done < "${file2}"

