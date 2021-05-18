# How to run TPC-H@Postgresql on Docker Container

## Ref
http://xtr.ai/blog/2019-03-12-tpch/
## 참고
  본 repo에 있는 쿼리들은 1,12,14,18번 analyze 쿼리를 
  정상작동 하게 수정하여 사용했으며, 다른 쿼리는 수정이 필요할 수 있음.
# prerequisite
## 0. Prepare TPC-H Data and Docker Image
```bash

$ mkdir [script dir] 
$ cd [script dir]
#본 폴더에 있는 파일 [script_dir]에 전부 다운로드해야함

$ zip -F tpch-kit.zip --out temp.zip
$ unzip temp.zip
$ cd tpch-kit/dbgen/
#1. Load Table Data

$ sudo chmod +x dbgen

## -s [size]GB table data
$ ./dbgen -s 120

$ sudo docker pull oiu7934/tpch-pgsql-12.4
```

## 1. Permission  and Create Container
```bash
$ cd ..
$ mkdir [data_dir] 
$ sudo docker run -idt --name [container_name] \
--shm-size 2G \
-v [data_dir]:/mount \
-v [log_dir]:/local_log \
-v [script_dir]:/tpch \
oiu7934/tpch-pgsql-12.4:latest
## password: vldb1597
```
## 2. Initailize DB
```bash
$ sudo docker exec -it -u pgsql [container_name] /bin/bash
# in container
 $ sudo chown -R pgsql:pgsql /mount /local_log;
 $ sudo chmod -R 700 /mount /local_log;
 # ~/bashrc에 
 # export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/pgsql/postgresql-12.4/build/lib
 # export PATH=/home/pgsql/postgresql-12.4/build/bin:$PATH
 # 추가
 $ source ~/.bashrc
 $ initdb -D /mount/ --no-locale --encoding=UTF8
 $ pg_ctl start -D /mount
 $ db=tpch1
 $ createdb $db
 $ psql -d $db < /tpch/tpch-kit/dbgen/dss.ddl
 $ sudo chmod +x /tpch/tpch-kit/dbgen/run.sh
 $ cd tpch/tpch-kit/dbgen
 $ ./run.sh
 # verify the data
 $ psql -d $db -c '\dt+'
 $ exit 
 # init 끝
```


# Run TPC-H
```bash
$ vi [script_dir]/test.sh ## 각자 실험 상황에 맞게 수정

  1  #!/bin/bash
  2 log_name=$1
  3 function msecs() {
  4     echo $((`date +%s%N` / 1000000))
  5 }
  6 
  7 function msec_to_sec() {
  8     MSECS=$1
  9     SECS=$(($MSECS / 1000))
 10     MSECS=$(($MSECS - $SECS * 1000))
 11     printf %d.%03d $SECS $MSECS
 12 }
 13 
 14 TOTAL_MSECONDS=0
 15 for q in 12 14 ## 쿼리번호
 16 do
 17     ii=$(printf "%02d" $q)
 18     echo "start query-$q"
 19     START=`msecs`
 20     psql -d tpch1 -t -A -F"," < /tpch/queries/q$ii.analyze.sql > /local_log/${log_name}_q$ii-plan.csv
 21     END=`msecs`
 22     DURATION=$(( $END - $START ))
 23     echo "duration of query-$q = $DURATION"
 24     printf "%d: \t%16s secs\n" $q `msec_to_sec $DURATION` >> /local_log/${log_name}_execution time.log
 25     TOTAL_MSECONDS=$(( $TOTAL_MSECONDS + $DURATION ))
 26 done
 27 
 28 printf "Total: \t%16s secs\n" `msec_to_sec $TOTAL_MSECONDS` >> /local_log/${log_name}_execution time.log
 29 


$ sudo chmod +x [script_dir]/test.sh


# run
$ sudo docker exec -u pgsql [container_name] /bin/bash -c "source ~/.bashrc; /tpch/test.sh"
```
