#!/bin/bash

if [ "$1" = ? ] || [ "$1" = --help ]; then
  echo "Run as ./mastertestcase.sh <lux file name starting with>" >&2
  exit 1
fi

SUCCESS=0
FAIL=0
FAILD_SCRIPTS=

cd scripts
echo " "

PATTERN=$1*.lux
echo "LUX script PATTERN $PATTERN"
echo " "
echo " "

lux=/home/sundar/lux/bin/lux
for lx in $PATTERN; do
    [ -f "$lx" ] || break
    echo "Running $lx"
    $lux $lx
    
    if [ $? = 0 ]
              then
                             SUCCESS=$((SUCCESS + 1))
              else
                             FAIL=$((FAIL + 1))
                             FAILD_SCRIPTS="$FAILD_SCRIPTS    $lx"
              fi
              
              echo " "
              echo "--- Cleaning any residue mpls-l2vpn config ---"
              
              (echo "
              config
                             no mpls-l2vpn AXIS-ANG1111
                             commit
              exit"| ncs_cli -C -u admin)
    
    echo " "
    echo " "
    echo "--------------------"
    echo " "
    echo " "
done

echo "------ Result ------"
echo "SUCCESS : $SUCCESS"
echo "FAIL : $FAIL"
echo "FAILD SCRIPTS : $FAILD_SCRIPTS"
echo "--------------------"

cd -

