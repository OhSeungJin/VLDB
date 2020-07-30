# ycsb@rocksdb on container

## ycsb_only_script

```bash
#!bin/bash

#-------------<Modify Here>-------------# 
#---------------------------------------#
password= "vldb1597"
TEST_DEV= /dev/nvme0n1p1
TEST_DIR= /home/osj/test_data
SCRIPT_DIR= /home/osj/workspace/YCSB/script/
LOG_DIR= /home/osj/workspace/log/ycsb/
TEST_NAME= "test"
USER_NAME= "osj"
SYS_TIME= $(date "+%y/%m/%D   %H:%M:%S")
MAX_TIME= 4500
WORKLOAD= "workloada_w" # [ workloada_r, workloada_w ]
#---------------------------------------#
#---------------------------------------#




# 0. mount and Permission
	echo "[$SYS_TIME] Mount Device Permission Start"

	echo $password | sudo -S mkfs.ext4 $TEST_DEV
	echo $password | sudo -S mount $TEST_DEV $TEST_DIR
	echo $password | sudo -S chown -R $USER_NAME:$USER_NAME $TEST_DIR
	echo $password | sudo -S chmod 777 $TEST_DIR

	$SYS_TIME= $(date "+%y/%m/%d   %H:%M:%S")
	echo "[$SYS_TIME] Mount Device Permission Complete"

# 1. run benchmark
	$SYS_TIME= $(date "+%y/%m/%d   %H:%M:%S")
	echo "[$SYS_TIME] BenchMark Start"
	
	iostat 1 -xm $TEST_DEV &> $LOG_DIR/iostat-$TEST_NAME.log &
	echo $password | sudo -S docker run -it --rm --name ycsb \
	-v $TEST_DIR:/app/YCSB/data \
	-v $SCRIPT_DIR:/app/YCSB/script \
	-v $LOG_DIR:/app/YCSB/local_log \
	csoyee/ycsb:1.0 \
	/bin/bash -c "./bin/./bin/ycsb run rocksdb -s \
	-P /app/YCSB/script/$WORKLOAD -p maxexecutiontime=$MAX_TIME \
	-p rocksdb.dir=/app/YCSB/data &> /app/YCSB/local_log/ycsb-$TEST_NAME.log"
	
	$SYS_TIME= $(date "+%y/%m/%d   %H:%M:%S")
	echo "[$SYS_TIME] BenchMark END"
	
	echo $password | sudo -S killall -15 iostat
```
