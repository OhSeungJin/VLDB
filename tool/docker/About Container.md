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
[RedHat](https://www.redhat.com/ko/topics/containers/whats-a-linux-container)
[Opennaru](http://www.opennaru.com/openshift/container/what-is-the-difference-between-docker-lxd-and-lxc/)

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




# 2. Docker(Linux Container)
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
