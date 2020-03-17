loc=/home/osj/zssd_test/185G/iostat/
list=`ls -t $loc` 

echo $list
for i in $list
	do
		python3 /home/osj/zssd_test/parse.py $i 
	done

#python3 /home/seungjinoh/sysbench-1.0.17/result/parse.py 26_16.txt
#python3 /home/seungjinoh/sysbench-1.0.17/result/parse.py 26_32.txt
#python3 /home/seungjinoh/sysbench-1.0.17/result/parse.py 26_64.txt
#python3 /home/seungjinoh/sysbench-1.0.17/result/parse.py 26_128.txt
#python3 /home/seungjinoh/sysbench-1.0.17/result/parse.py 26_256.txt

echo "all of file writing end"
