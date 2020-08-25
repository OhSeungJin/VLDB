# How to run FIO on DockerContainer


## 1. Pull FIO-Ubuntu image from dockerhub

``` bash
$ sudo docker pull viniciusbds/fio-ubuntu

Using default tag: latest
latest: Pulling from viniciusbds/fio-ubuntu
d51af753c3d3: Pull complete 
fc878cd0a91c: Pull complete 
6154df8ff988: Pull complete 
fee5db0ff82f: Pull complete 
f232657f3c89: Pull complete 
Digest: sha256:7bbf27b5a220f13696fa1d0f4a3cfec4d1527a659627a74b8cdc0de11dd30d35
Status: Downloaded newer image for viniciusbds/fio-ubuntu:latest
docker.io/viniciusbds/fio-ubuntu:latest

```


## 2. Create Fio container

```bash
$ sudo docker run -d --name [container_name] --privileged -v [local_log directory]:/fio_log viniciusbds/fio-ubuntu

```

## 3. run Fio

```bash
$ sudo docker exec -it [container_name] /bin/bash -c "fio --filename=[device] --direct --rw=[read/write/randread/randwrite] --randrepeat=0 --bs=[block size] --size=[io_size] --time_based=1 --runtime=[runtime] --name=[file name] &> /fio_log/[log_name]"
# ex)fio --filename=/dev/nvme0n1p1 --direct=1 --rw=randread --bs=4k --size=200G --time_based=1 --runtime=1800 --norandommap --name fio_randr_file1 &> /fio_log/test_log.fio
