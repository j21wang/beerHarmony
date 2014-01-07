#!/bin/bash

file='allDrinkers.txt'

mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT drinkerID FROM drinker;" > "${file}"

cChina=0
cUS=0
cBrazil=0
cRussia=0
cFrance=0
cItaly=0
cUK=0
cJapan=0
cUganda=0
cGermany=0
cAustralia=0
cOther=0
id=0

while read line; do
   while true; do
      n=`expr ${RANDOM} % 242`
      n=`expr ${n} + 1`
      country=`head -n ${n} countryNames.txt | tail -n 1`

      #China
      echo "$country" | grep -E -e "China" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cChina} -eq 20 ]; then
            continue
         else
            cChina=`expr ${cChina} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #US
      echo "$country" | grep -E -e "United States" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cUS} -eq 15 ]; then
            continue
         else
            cUS=`expr ${cUS} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #Brazil
      echo "$country" | grep -E -e "Brazil" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cBrazil} -eq 10 ]; then
            continue
         else
            cBrazil=`expr ${cBrazil} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #Russia
      echo "$country" | grep -E -e "Russia" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cRussia} -eq 10 ]; then
            continue
         else
            cRussia=`expr ${cRussia} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #France
      echo "$country" | grep -E -e "France" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cFrance} -eq 9 ]; then
            continue
         else
            cFrance=`expr ${cFrance} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #Italy
      echo "$country" | grep -E -e "Italy" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cItaly} -eq 8 ]; then
            continue
         else
            cItaly=`expr ${cItaly} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #UK
      echo "$country" | grep -E -e "United Kingdom" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cUK} -eq 10 ]; then
            continue
         else
            cUK=`expr ${cUK} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #Japan
      echo "$country" | grep -E -e "Japan" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cJapan} -eq 5 ]; then
            continue
         else
            cJapan=`expr ${cJapan} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #Uganda
      echo "$country" | grep -E -e "Uganda" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cUganda} -eq 2 ]; then
            continue
         else
            cUganda=`expr ${cUganda} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #Germany
      echo "$country" | grep -E -e "Germany" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cGermany} -eq 8 ]; then
            continue
         else
            cGermany=`expr ${cGermany} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #Australia
      echo "$country" | grep -E -e "Australia" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cAustralia} -eq 5 ]; then
            continue
         else
            cAustralia=`expr ${cAustralia} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

      #Other
      echo "$country"
      if [ $? -eq 0 ]; then
         if [ ${cOther} -eq 170 ]; then
            continue
         else
            cOther=`expr ${cOther} + 1`
            echo "INSERTING country=${country} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "INSERT INTO fromCountry(countryName,drinkerID) VALUES ('${country}',${id});"
            break
         fi
      fi

   done;
   id=`expr ${id} + 1` 
done < "${file}"
