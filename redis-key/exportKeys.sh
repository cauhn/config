#!/bin/bash  
REDIS_HOST=localhost  
REDIS_PORT=6379  
REDIS_DB=1  
REDIS_SH=/home/work/soft/redis-3.0.7/src/redis-cli
RUN_REDIS=" ./redis-cli -h $REDIS_HOST -p $REDIS_PORT "

TYPE_STRING="string"
TYPE_SET="set"
TYPE_HASH="hash"
TYPE_LIST="list"
  
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
    keyType=`echo "TYPE $key" | $RUN_REDIS`
    echo key $key type $keyType
    if [ $keyType = $TYPE_STRING ];
    then 
        keyValue=`echo "GET $key" | $RUN_REDIS`
        echo "SET $key '$keyValue'" >> $OUTFILE
    elif [ $keyType = $TYPE_LIST ];
    then 
        keyLength=`echo "LLEN $key" | $RUN_REDIS`
        echo "LRANGE $key 0 keyLength" | $RUN_REDIS | xargs echo "LPUSH $key " >> $OUTFILE
    elif [ $keyType = $TYPE_SET ];
    then 
        echo "SMEMBERS $key" | $RUN_REDIS | xargs echo "SADD $key " >> $OUTFILE
    elif [ $keyType = $TYPE_HASH ];
    then 
        echo "HGETALL $key" | $RUN_REDIS | xargs echo "HMSET $key " >> $OUTFILE
    else
        echo "not use the key type $keyType"
    fi   
done  


