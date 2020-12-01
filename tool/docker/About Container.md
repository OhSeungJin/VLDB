 About Container
===========================
Contents<br><br>
 1.&nbsp;&nbsp;LXC<br>
 2.&nbsp;&nbsp;Docker<br>
 3.&nbsp;&nbsp;Namespace<br>
 4.&nbsp;&nbsp;Cgroup<br>
----------------------------------
<hr>

## Ref
[RedHat_LXC](https://www.redhat.com/ko/topics/containers/whats-a-linux-container)

[Opennaru](http://www.opennaru.com/openshift/container/what-is-the-difference-between-docker-lxd-and-lxc/)

[RedHat Docker](https://www.redhat.com/ko/topics/containers/what-is-docker)

[Docker](https://tech.ssut.me/what-even-is-a-container/)

[NameSpace](https://galid1.tistory.com/442)

[Cgroups_1](https://selfish-developer.com/entry/Cgroup-Control-Group)

[Cgroups_2](https://sonseungha.tistory.com/535)
# 1. LXC(Linux Container)
<img src="https://www.redhat.com/cms/managed-files/what-is-a-container.png" width="30%"></img>
 
LXC(Linux Container)
## 정의
컨테이너는 시스템의 나머지 부분과 격리된 프로세스 세트. LXC는 툴, 템플릿, 라이브러리, 언어 바인딩 세트를 제공하는 오픈소스 컨테이너 플랫폼 
## 사용이유
특정 어플리케이션의 실행에 있어서, 라이브러리, 파일, 종속성 등과 같은 환경에 의존한다면, 
다른 환경에서는 어플리케이션 개발 및 역할 수행에 있어서, 많은 부가적인 작업이 필요하게 됨. 
리눅스 컨테이너 이미지는 특정 어플리케이션이 수행되는데 필요한 환경들이 포함이 되어있다.
리눅스 컨테이너 이미지의 배포를 통해, 다른 환경에서 발생하는 부가적인 작업을 감소시키고 
해당 어플리케이션의 수행을 에뮬레이션할 수 있다.

## 가상화 VS 컨테이너
<img src="https://www.redhat.com/cms/managed-files/virtualization-vs-containers.png" width="50%" style="vertical-align:middle;margin:auto;"> </img>

가상화 VS 컨테이너
#### 가상화 : 단일 하드웨어 시스템에서 여러운영체제를 동시에 수행하는 것
가상화는 하이퍼바이저를 사용하여 하드웨어를 에뮬레이션 하고, 이를 통해 여러 운영체제를 동시에 실행--> OS의 기능이 중복되어, 경량화가 컨테이너 만큼 불가능.
#### 컨테이너 : 동일한 웅영체제 커널을 공유.시스템의 나머지 부분으로 부터 애플리케이션 프로세스 세트를 격리
컨테이너 환경에서는 모든 컨테이너 전체가 하나의 운영체제를 공유하므로, 어플리케이션과 서비스를 가볍게 유지가능하며, 빠른속도로 동시 실행 가능

## 구현 방식
리눅스 컨테이너는 단일 컨트롤 호스트 상에서 려러개의 고립된 리눅스 시스템(컨테이너)들을 실행하기 위한 운영 시스템 레벨 가상화 방법이다.
리눅스 커널은 cgroups를 사용하여 자원할당을 수행하며, cgroups는 또한 어플리케이션 입장에서 운영환경을 고립시키기위해, namespace isolation 기법을 활용함.
즉 LXC는 cgroups와 namespace를 결합하여 어플리케이션의 고립된 환경을 제공함. Docker에서도 컨테이너 드라이버로, LXC를 사용하였으나, 현재는 자체 컨테이너를 사용중 
### 컨테이너별 분할되는 자원
1. 프로세스 테이블 : 컨테이너마다 별도의 프로세스 테이블을 관리. 다른 컨테이너에서 보이지 않게 관리
2. 파일 시스템 : 컨테이너마다 특정 디렉토리를 루트 파일 시스템으로 보이게 함.
3. 네트워크 : 네임스페이스를 이용하여, 컨테이너 별로 네트워크 설정을 구성
4. 하드웨어 자원(CPU, block device, memory etc) : Cgroup 기능을 이용하여, 컨테이너에서 사용할 수 있는 범위를 제한




# 2. Docker
<img src="https://tech.ssut.me/content/images/2017/08/docker.png" width="50%" style="vertical-align:middle;margin:auto;">


## 정의
Docker는 Linux 컨테이너를 만들고 사용할 수 있도록 하는 컨테이너화 기술이다.

## 사용이유
Docker를 사용하면 컨테이너를 매우 가벼운 모듈식 가상 머신처럼 다룰 수 있다. 
컨테이너를 유연하게 사용가능하며, 어플리케이션을 클라우드에 최적화하도록 지원한다.

## 가상화 VS 컨테이너
<img src="https://www.redhat.com/cms/managed-files/traditional-linux-containers-vs-docker_0.png" width="50%" style="vertical-align:middle;margin:auto;"> </img>

LXC VS Docker
#### LXC :멀티플 프로세스를 관리할 수 있는 초기화 시스템을 사용합니다. 즉, 전체 애플리케이션을 하나로 실행 

#### Docker : 애플리케이션이 개별 프로세스로 세분화되도록 하며 이를 수행할 수 있는 툴을 제공


## 구현 방식
Docker 기술은 Linux kernel과 함께 Cgroups 및 Namespace와 같은 커널의 기능을 사용함. 이를 통해, 프로세스를 분리함으로써, 격리된 환경에서 실행 될 수 있도록 한다.

# 3. Namespace

## 정의
하나의 시스템에서 프로세스를 격리시킬 수 있는 가상화 기술 (각 별개의 독립된 공간을 사용하는 것처럼 격리된 환경을 제공하는 경량 프로세스 가상화 기술)<br>
한 덩어리의 데이터에 이름을 붙혀 충돌 가능성을 줄이고, 쉽게 참조할 수 있는 개념<br>
Linux Kernel Namespace는 6개의 Linux Object에 이름을 붙임으로써, 독립된 프로세스의 환경을 구축할 수 있다.

## 사용이유
Docker를 사용하면 컨테이너를 매우 가벼운 모듈식 가상 머신처럼 다룰 수 있다. 
컨테이너를 유연하게 사용가능하며, 어플리케이션을 클라우드에 최적화하도록 지원한다.

## Type of Namespace
### 1. PID namespace
프로세스에 할당된 고유한 ID를 말하며, 이를 통해 프로세스를 격리할 수 있다.<br>
namespace가 다른 프로세스끼리는 서로 접근 할 수 없다.
### 2. Network namespace
네트워크 디바이스, IP 주소, Port 번호, 라우팅 테이블, 필터링테이블 등의 네트워크 리소스를 namespace마다 격리시켜 <br>
독립적으로 가질 수 있다. 이 기능을 이용하면 OS상에서 이미 사용중인 Network Port가 있더라도, 컨테이너 안에서 동일한 Port를 사용할 수 있다.
### 3. UID namespace
-UID : 라눅스에서 사용자를 식별하는데 사용하는 유저 아이디.<br>
-GID : 리눅스에서 사용자그룹을 식별하는데 사용하는 사용자 그룹 아이디.<br>
namespace별로 독립적으로 UID GID를 가지게 할 수 있다. 컨테이너 namespace가 host os 상에서 서로 다른 UID, GID를 가질 수 있다.
### 4. Mount namespace
-Mount : 컴퓨터에 연결된 기기나 기억장치를 OS에 인식시켜 사용가능한 상태로 만드는 것 <br>
 host os와 컨테이너 namespace가 서로 다른 격리된 파일시스템 트리를 가질 수 있도록 한다.
### 5. UTS namespace
namespace별로 호스트명이나 도메인 명을 독자적으로 가질 수 있다.
### 6. IPC namespace
Inter Process Communication(IPC) 오브젝트를 namespace 별로 독립적으로 할당할 수 있다.

# 4. Cgroup(Control Group)

## 정의
Cgroup은 CPU, Network, Memory 등 하드웨어 자원을 그룹별로 관리 할 수 있는 리눅스의 모듈이다.
## 사용이유
성능면에서 자원 경합을 줄이고, 예측성 높은 SLA(Service Level Agreement)를 만족할 수 있다.
계층관리를 통하여, Tasks들에 자원을 할당할 수 있다.
## 구현방식
cgroup의 실체는 파일시스템이다. 직접 cgroup을 마운트하여, 수행중인 프로세스 그룹에 대하여, 하드웨어 자원을 조절할 수 있다.

## Type of Cgroup
### 1. Memory
-memory : cgroup 작업에 사용되는 메모리(프로세스, 커널, swap)를 제한하고 리포팅을 제공하는 서브시스템
### 2. CPU 
-cpu :cgroups는 시스템이 busy 상태일 때 CPU 공유를 최소화 즉 사용량을 제한<br>
-cpuacct: 프로세스 그룹 별 CPU 자원 사용에 대한 분석 통계를 생성 및 제공<br>
-cpuset	:개별 CPU 및 메모리 노드를 cgroup에 바인딩 하기 위해 사용하는 서브시스템
### 3. Network 
-net_cls : 특정 cgroup 작업에서 발생하는 패킷을 식별하기 위한 태그(classid)를 지정 가능 이 태그는 방화벽 규칙으로 사용 가능 <br>
-net_prio : cgroup 작업에서 생성되는 네트워크 트래픽의 우선순위를 선정
### 4. Device
-devices: cgroup의 작업 단위로 device에 대한 접근을 허용하거나 제한합니다. whitelist와 blacklist로 명시되어 있습니다.
### 5. I/O 
-blkio :특정 block device에 대한 접근을 제한하거나 제어하기 위한 서브시스템. block device에 대한 IO 접근 제한을 설정 가능

