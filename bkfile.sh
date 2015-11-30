#!/bin/sh
# bkfile: This script makes backup file
#         with the name originalname.CCYYMMDD.
# usage: bkfile originalfile

TODAY=`date +%Y%m%d`

if [ $# -ne 1 ];
then
  echo "usage: bkfile filename"
  exit 9
fi

if [ ! -e $1 ]
then
  echo "$1 does not exist!"
  exit 9
fi

if [ `echo $1 | grep -c "/"` -ne 0 ];
then
  TARGETDIR=`basename $1`
else
  TARGETDIR=.
fi

if [ ! -e $1.bak$TODAY ]
then
  BKFILE=$1.bak$TODAY
else
  icount=1
  while :
  do
    if [ ! -e $1.bak${TODAY}_$icount ]
    then
      BKFILE=$1.bak${TODAY}_$icount
      break
    else
      icount=`echo "$icount +1" | bc -l`
    fi
  done
fi

cp -p $1 $BKFILE

exit
