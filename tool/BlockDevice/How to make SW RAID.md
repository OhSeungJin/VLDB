
# How to make SW RAID



## Reference
  - [Link](https://www.notion.so/RAID-b73edf16f2af43cb9fe02d903fcf29c0)
  
## 실제 사용(IOD, Non-IOD Device)
``` bash
# iod Devie : /dev/nvme0n1 /dev/nvme0n2 /dev/nvme0n3 /dev/nvme0n4
# non iod Device : /dev/nvme1n1


# IOD DEVICE
$ sudo fdisk /dev/nvme0n1
> p
> t
> fd 
> w
# 다른 디바이스에도 똑같이 적용

$ sudo mdadm --create /dev/md0 --level=0 --raid-device=3 \
 /dev/nvme0n1p1  /dev/nvme0n2p1  /dev/nvme0n3p1

$ sudo -i
#root로 변경

# su를 활용하여 super user로 변경
$ echo "DEVICE partitions" > /etc/mdadm.conf

# 구성 추가
$ mdadm --detail --scan >> /etc/mdadm.conf

$ exit

# NON IOD DEVICE
$ sudo fdisk /dev/nvme1n1
> p
> t
> fd 
> w
# 다른 디바이스에도 똑같이 적용

$ sudo mdadm --create /dev/md0 --level=0 --raid-device=3 \
 /dev/nvme1n1p1  /dev/nvme1n1p2  /dev/nvme1n1p3

$ sudo -i
#root로 변경

# su를 활용하여 super user로 변경
$ echo "DEVICE partitions" > /etc/mdadm.conf

# 구성 추가
$ mdadm --detail --scan >> /etc/mdadm.conf

$ exit
```
  
  
## 1) mdadm 설치
 ```bash
 $ sudo apt-get install mdadm
```

  
## 2) System Partition ID (FD) 설정
디스크 파티션의 Type을 Linux raid autodetect로 바꿔준다.
SW RAID로 묶고 싶은 device에 전부 아래와 같은 과정을 반복
 ```bash
 $ sudo fdisk [device]
 > p
 > t
 > fd
 > w
```


  
## 3) RAID 설정 작업 (mdadm)
 ```bash
 $ sudo mdadm --create /dev/md0 --level=0 --raid-device=[n] \
[device_1] [device_2] ... [device_n]

$ sudo -i
#root로 변경

# su를 활용하여 super user로 변경
$ echo "DEVICE partitions" > /etc/mdadm.conf

# 구성 추가
$ mdadm --detail --scan >> /etc/mdadm.conf

$ exit

```

  
## 4) 파일 시스템 작업(mkfs)
 ```bash
$ sudo mkfs.ext4 /dev/md0
```

## 5) 마운트 작업(mount)
 ```bash
$ mkdir raid_test_dir 
$ mount /dev/md0 raid_test_dir
```

## 5) 마운트 작업(mount)
 ```bash
$ mkdir raid_test_dir 
$ mount /dev/md0 raid_test_dir
```

## 6) RAID 삭제 작업
 ```bash
# RAID 작업 중지
$ mdadm --stop /dev/md0 

# RAID disk 삭제
$ mdadm --remove /dev/md0

# superblock 정보 삭제
$ mdadm --zero-superblock [device_1] [device_2] ... [device_n]
```


 
