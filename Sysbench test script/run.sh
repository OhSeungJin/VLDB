# Remove the previous data
rm -rf /home/osj/test_data/*
rm -rf /home/osj/test_log/*
# Copy the backup data
cp -r /home/osj/data_backup/sysbench/data/* /home/osj/test_data/
cp -r /home/osj/data_backup/sysbench/log/* /home/osj/test_log/

tmux split-window -v
tmux select-pane -t 0
tmux split-window -v
tmux select-pane -t 0
# Run the MySQL server
mysqld_safe --defaults-file=/home/osj/mysql_config/185G/$1.cnf &
sleep 15s

pid=$(ps -aux | grep mysqld | grep -v     grep| grep -v mysqld_safe|  awk '{print $2}')

file_name=$1'_'$2

time=1200
tps_loc=/home/osj/zssd_test/185G/tps/tps$file_name.txt 

tmux send-keys -t 1 "sudo perf record -F 99 -p $pid -g -- sleep $time" ENTER
tmux send-keys -t 1 "vldb1597" ENTER

tmux send-keys -t 2 "iostat -cdx 10 | tee /home/osj/zssd_test/185G/iostat/$file_name.txt" ENTER

#Run the benchmark
sysbench --test=/home/osj/sysbench-1.0.17/tests/include/oltp_legacy/oltp.lua \
				--mysql-host=localhost  --mysql-db=sbtest --mysql-user=root \
				--mysql-password=vldb1597 \
				--max-requests=0  --oltp-table-size=2000000 \
				--time=$time  --oltp-tables-count=400 --report-interval=10 \
				--db-ps-mode=disable  --random-points=10  --mysql-table-engine=InnoDB \
				--mysql-port=3306   --threads=$2  run | tee $tps_loc
# Shutdown the MySQL server
sleep 3s
tmux send-keys -t 2 C-c
mutex_loc=/home/osj/zssd_test/185G/mutex/mutex$file_name.txt
mysql -uroot -pvldb1597 -e "SELECT EVENT_NAME, COUNT_STAR, SUM_TIMER_WAIT/1000000000 SUM_TIMER_WAIT_MS FROM performance_schema.events_waits_summary_global_by_event_name WHERE SUM_TIMER_WAIT > 0 AND EVENT_NAME LIKE 'wait/synch/mutex/innodb/%' OR EVENT_NAME LIKE 'wait/synch/sxlock/innodb/%' ORDER BY SUM_TIMER_WAIT_MS;" | tee $mutex_loc 

mysqladmin -uroot -pvldb1597 shutdown
tmux send-keys -t 2 C-c

mv  perf.data /home/osj/zssd_test/185G/perf/perf$file_name.data

sleep 2s
tmux kill-pane -t 1 
tmux kill-pane -t 1
tmux kill-pane -t 1

