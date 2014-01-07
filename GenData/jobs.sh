#!/bin/bash

file='ofAge.txt'

mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "SELECT drinkerID FROM ofAgeDrinker;" > "${file}"

cComputer=0
cRetail=0
cCashier=0
cTeacher=0
cPhysician=0
cOther=0

while read line; do
   id=`echo "${line}"`
   while true; do
      n=`expr ${RANDOM} % 199`
      n=`expr ${n} + 1`
      job=`head -n ${n} jobs.txt | tail -n 1 | sed s/"'"/""/g`


      #computer
      echo "$job" | grep -E -e "[cC]omputer" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cComputer} -eq 10 ]; then
            continue
         else 
            cComputer=`expr ${cComputer} + 1`
            echo "INSERTING job=${job} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE ofAgeDrinker SET occupation='${job}' WHERE drinkerID=${id};"
            break
         fi
      fi


      #retail
      echo "$job" | grep -E -e "[rR]etail" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cRetail} -eq 30 ]; then
            continue
         else 
            cRetail=`expr ${cRetail} + 1`
            echo "INSERTING job=${job} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE ofAgeDrinker SET occupation='${job}' WHERE drinkerID=${id};"
            break
         fi
      fi

      #cashier
      echo "$job" | grep -E -e "[cC]ashier" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cCashier} -eq 20 ]; then
            continue
         else 
            cCashier=`expr ${cCashier} + 1`
            echo "INSERTING job=${job} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE ofAgeDrinker SET occupation='${job}' WHERE drinkerID=${id};"
            break
         fi
      fi

      #teacher
      echo "$job" | grep -E -e "[tT]eacher" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cTeacher} -eq 15 ]; then
            continue
         else 
            cTeacher=`expr ${cTeacher} + 1`
            echo "INSERTING job=${job} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE ofAgeDrinker SET occupation='${job}' WHERE drinkerID=${id};"
            break
         fi
      fi

      #physician
      echo "$job" | grep -E -e "[pP]hysician" > /dev/null
      if [ $? -eq 0 ]; then
         if [ ${cPhysician} -eq 15 ]; then
            continue
         else 
            cPhysician=`expr ${cPhysician} + 1`
            echo "INSERTING job=${job} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE ofAgeDrinker SET occupation='${job}' WHERE drinkerID=${id};"
            break
         fi
      fi

      #other
      echo "$job"
      if [ $? -eq 0 ]; then
         if [ ${cOther} -eq 110 ]; then
            continue
         else 
            cOther=`expr ${cOther} + 1`
            echo "INSERTING job=${job} for drinkerID=${id}"
            mysql -u "csuser" --port 3306 --host "cs336-12.cs.rutgers.edu" bbd_plusplus -p"cs2deb75" -Bse "UPDATE ofAgeDrinker SET occupation='${job}' WHERE drinkerID=${id};"
            break
         fi
      fi

   done;
done < "${file}"
