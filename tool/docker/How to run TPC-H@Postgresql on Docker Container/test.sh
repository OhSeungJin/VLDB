#!/bin/bash

function msecs() {
    echo $((`date +%s%N` / 1000000))
}

function msec_to_sec() {
    MSECS=$1
    SECS=$(($MSECS / 1000))
    MSECS=$(($MSECS - $SECS * 1000))
    printf %d.%03d $SECS $MSECS
}

TOTAL_MSECONDS=0
for q in 12 14
do
    ii=$(printf "%02d" $q)
    echo "start query-$q"
    START=`msecs`
    psql -d tpch1 -t -A -F"," < /tpch/queries/q$ii.analyze.sql > /local_log/four-$1-$2-$3-$4-$5-$6-results-q$ii.csv
    END=`msecs`
    DURATION=$(( $END - $START ))
    echo "duration of query-$q = $DURATION"
    printf "%d: \t%16s secs\n" $q `msec_to_sec $DURATION` >> /local_log/four-$1-$2-$3-$4-$5-$6-postgres-tpch.log
    TOTAL_MSECONDS=$(( $TOTAL_MSECONDS + $DURATION ))
done

printf "Total: \t%16s secs\n" `msec_to_sec $TOTAL_MSECONDS` >> /local_log/four-$1-$2-$3-$4-$5-$6-postgres-tpch.log

