# How To Upgrade Python 3.5.2 to Python 3.7

This Post is based on Ubuntu 16.04 LTS

## Install

1. Install Requirements

'''bash
$ sudo apt-get install -y build-essential
$ sudo apt-get install -y checkinstall
$ sudo apt-get install -y libreadline-gplv2-dev
$ sudo apt-get install -y libncursesw5-dev
$ sudo apt-get install -y libssl-dev
$ sudo apt-get install -y libsqlite3-dev
$ sudo apt-get install -y tk-dev
$ sudo apt-get install -y libgdbm-dev
$ sudo apt-get install -y libc6-dev
$ sudo apt-get install -y libbz2-dev
$ sudo apt-get install -y zlib1g-dev
$ sudo apt-get install -y openssl
$ sudo apt-get install -y libffi-dev
$ sudo apt-get install -y python3-dev
$ sudo apt-get install -y python3-setuptools
$ sudo apt-get install -y wget
'''

2. Prepare to Build

'''bash
$ mkdir /tmp/Python37
$ cd /tmp/Python37
'''

3. Pull down Python 3.7, build, and install

'''bash
$ wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
$ tar xvf Python-3.7.0.tar.xz
$ cd /tmp/Python37/Python-3.7.0
$ ./configure
$ sudo make altinstall
'''

4. Python3 version update and Check Verion

'''bash
$ sudo update-alternatives --install /usr/bin/python3 python /usr/local/bin/python3.7 10
$ python3 -V
#Python3.7.0
'''
done.

##Reference
https://nogadaworks.tistory.com/203
