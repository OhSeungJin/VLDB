# How to Install and Start Docker

## Thanks
- https://github.com/meeeejin/til/blob/master/docker/mysql-with-docker-volume.md

## Install Docker Engine
## Install Docker Engine

1. Update the `apt` package index:

```bash
$ sudo apt-get update
```

2. Install the necessary packages to allow `apt` to use a repository over HTTPS:

```bash
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```

3. Add Docker’s official GPG key:

```bash
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Verify that you now have the key with the fingerprint:

```bash
$ sudo apt-key fingerprint 0EBFCD88
    
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ unknown] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```

4. Set up the stable repository:

```bash
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

5. Install the latest version of Docker Engine:

```bash
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
```

### Test Docker Installation

1. Verify that Docker Engine - Community is installed correctly by running the hello-world image:

```bash
$ sudo docker run hello-world

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
ca4f61b1923c: Pull complete
Digest: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

2. Run `docker image ls` to list the hello-world image that you downloaded to your machine:

```bash
$ sudo docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              fce289e99eb9        15 months ago       1.84kB
```

3. You can check the status of all the containers using the below command:

```bash
$ sudo docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS                               NAMES
2eeed464cd9f        hello-world         "/hello"                 2 minutes ago       Exited (0) 2 minutes ago                                       objective_perlman
```

4. You can stop one or more running containers:

```bash
$ sudo docker stop [container-name]
```

## Search Docker image in Dockerhub

```bash
$ sudo docker search -[OPTION] [Term]
# sudo docker search ycsb


NAME                         DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
nuodb/ycsb                   Yahoo! Cloud Serving Benchmark (YCSB) with a…   1
matjazmav/ycsb               YCSB  https://github.com/brianfrankcooper/YC…   1                                       [OK]
0track/ycsb                  YCSB for EPaxos and VCD                         0                                       [OK]
dvasilas/ycsb                YCSB extended with Proteus-style query opera…   0
risdenk/ycsb-testing         Docker testing for YCSB                         0                                       [OK]
jmimick/ycsb                                                                 0
webdizz/ycsb                 Docker image of YCSB a framework for benchma…   0                                       [OK]
andreifecioru/ycsb-cluster                                                   0
catherine01/ycsb                                                             0
.
.
.
(생략)

```

## Remove container

```bash
$ sudo docker rm [OPTION] [container_ name]
```

## Create Docker Container

```bash
$ sudo docker run [container_name] -[OPTIONS] [image_name] 
```
다양한 옵션이 존재하므로, 자세한 내용은 [여기] http://pyrasis.com/book/DockerForTheReallyImpatient/Chapter20/28 를 


## Execute Docker Container using /bin/bash

```bash
$ sudo docker exec -it [container_name] /bin/bash
#Container에서 빠져나오고 싶다면 "Ctrl+D"
```


