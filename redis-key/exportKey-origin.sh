#!/bin/bash  
REDIS_HOST=localhost  
REDIS_PORT=6379  
REDIS_DB=1  
  
  
KEYNAME=$1
KEYFILE=key.txt  
echo key name $KEYNAME  key file $KEYFILE
echo "KEYS $KEYNAME" | ./redis-cli -h $REDIS_HOST -p $REDIS_PORT | sort > "$KEYFILE"
  
  
  
OUTFILE=$2
TEMPFILE=$OUTFILE.tmp  
echo > $TEMPFILE  
echo > $OUTFILE
for key in `cat $KEYFILE`  
do  
    echo $key  
    #echo "HGETALL $key" | redis-cli -h $REDIS_HOST -p $REDIS_PORT -n $REDIS_DB >> $TEMPFILE    
    keyValue=`echo "GET $key" | ./redis-cli -h $REDIS_HOST -p $REDIS_PORT`   
    echo key $key  value $keyValue
    echo "SET $key '$keyValue'" >> $OUTFILE
done  

