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


# 1. LXC(Linux Container)
<img src="https://www.redhat.com/cms/managed-files/what-is-a-container.png" width="30%"> LXC(Linux Container)</img>
## 정의
시스템의 나머지 부분과 격리된 프로세스 세트. 
## 사용이유
특정 어플리케이션의 실행에 있어서, 라이브러리, 파일, 종속성 등과 같은 환경에 의존한다면, 
다른 환경에서는 어플리케이션 개발 및 역할 수행에 있어서, 많은 부가적인 작업이 필요하게 됨. 
리눅스 컨테이너 이미지는 특정 어플리케이션이 수행되는데 필요한 환경들이 포함이 되어있다.
리눅스 컨테이너 이미지의 배포를 통해, 다른 환경에서 발생하는 부가적인 작업을 감소시키고 
해당 어플리케이션의 수행을 에뮬레이션할 수 있다.

## 가상화 VS 컨테이너
<img src="https://www.redhat.com/cms/managed-files/virtualization-vs-containers.png" width="50%" style="vertical-align:middle;margin:auto;"> 가상화 VS 컨테이너</img>
#### 가상화 : 단일 하드웨어 시스템에서 여러운영체제를 동시에 수행하는 것
가상화는 하이퍼바이저를 사용하여 하드웨어를 에뮬레이션 하고, 이를 통해 여러 운영체제를 동시에 실행--> OS의 기능이 중복되어, 경량화가 컨테이너 만큼 불가능.
#### 컨테이너 : 동일한 웅영체제 커널을 공유.시스템의 나머지 부분으로 부터 애플리케이션 프로세스 세트를 격리
컨테이너 환경에서는 모든 컨테이너 전체가 하나의 운영체제를 공유하므로, 어플리케이션과 서비스를 가볍게 유지가능하며, 빠른속도로 동시 실행 가능


