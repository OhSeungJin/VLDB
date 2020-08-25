
# TPC-H@Oracle12c on Container

## 1. Install TPC-H 
1.  Download TPC-H Files From http://www.tpc.org/tpc_documents_current_versions/current_specifications5.asp
2.  unzip the download file (Maybe 2.17.0_rc2)
3.  Copy makefile.suite to makefile
```bash
$ cd 2.18.0_rc2/dbgen/
$ cp makefile.suite makefile
$ vi makefile
```

4. modify makefile like below
```bash
...
################
## CHANGE NAME OF ANSI COMPILER HERE
################
CC      = gcc
# Current values for DATABASE are: INFORMIX, DB2, TDAT (Teradata)
#                                  SQLSERVER, SYBASE, ORACLE, VECTORWISE
# Current values for MACHINE are:  ATT, DOS, HP, IBM, ICL, MVS, 
#                                  SGI, SUN, U2200, VMS, LINUX, WIN32 
# Current values for WORKLOAD are:  TPCH
DATABASE= ORACLE
MACHINE = LINUX
WORKLOAD = TPCH
...
```
5. In the "dbgen directory", run make
```bash
$ make

$ ./dbgen -h
TPC-H Population Generator (Version 2.18.0 build 0)
Copyright Transaction Processing Performance Council 1994 - 2010
USAGE:
dbgen [-{vf}][-T {pcsoPSOL}]
        [-s <scale>][-C <procs>][-S <step>]
dbgen [-v] [-O m] [-s <scale>] [-U <updates>]
... (생략)
```

6. Generate TPC-H Benchmark DATA --> This is Not DB File , Just Table File

(options)

  -s 150 : Generate Total 150GB data 
  -S #: Step
  -C [# of partitions] : Total number of partitions
  
  ```bash
$ ./dbgen -s 150 -S 1 -C 4
$ ./dbgen -s 150 -S 2 -C 4
$ ./dbgen -s 150 -S 3 -C 4
$ ./dbgen -s 150 -S 4 -C 4
```

7. Move the Table Data to Data Directory(Not Test Directory)

```bash
$ cp *.tbl.* [DATA_DIR]
```

8. Make Related Query and Script File
```bash 
$ mkdir [script_dir] [log_dir]
$ cd [script_dir]
$ vi contorl1.sql
```
- contorl1.sql을 아래와 같이 작성

```sql
alter system set control_files='/mount/control01.ctl','/mount/control02.ctl' scope=spfile;
shutdown immediate
```

```bash
$ vi control2.sql
```
- control2.sql을 아래와 같이 작성

```sql
startup
```

```bash
$ vi data1.sql
```
- data1.sql을 아래와 같이 작성

```sql
shutdown immediate
```

```bash
$ vi data2.sql
```

- data2.sql을 아래와 같이 작성

```sql
startup mount

alter database rename file '/u01/app/oracle/oradata/xe/system01.dbf' to '/mount/system01.dbf';
alter database rename file '/u01/app/oracle/oradata/xe/sysaux01.dbf' to '/mount/sysaux01.dbf';
alter database rename file '/u01/app/oracle/oradata/xe/users01.dbf' to '/mount/users01.dbf';
alter database rename file '/u01/app/oracle/oradata/xe/undotbs01.dbf' to '/mount/undotbs01.dbf';
alter database rename file '/u01/app/oracle/oradata/xe/temp01.dbf' to '/mount/temp01.dbf';

alter database open;
```

```bash
$ vi log1.sql
```
- log1.sql을 아래와 같이 작성

```sql
shutdown immediate
```


```bash
$ vi log2.sql
```
- log2.sql을 아래와 같이 작성

```sql
startup mount

alter database rename file '/u01/app/oracle/oradata/xe/redo01.log' to '/mount/redo01.log';
alter database rename file '/u01/app/oracle/oradata/xe/redo02.log' to '/mount/redo02.log';
alter database rename file '/u01/app/oracle/oradata/xe/redo03.log' to '/mount/redo03.log';

alter database open;
```



```bash
$ vi schema1.sql
```

- schema1.sql을 아래와 같이 작성

```sql
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users02.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users03.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users04.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users05.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users06.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users07.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users08.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users09.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;

ALTER TABLESPACE USERS ADD DATAFILE '/mount/users10.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users11.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users12.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users13.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users14.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users15.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users16.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users17.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users18.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users19.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;
ALTER TABLESPACE USERS ADD DATAFILE '/mount/users20.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;

CREATE USER tpch IDENTIFIED BY tpch;

GRANT CREATE SESSION,
      CREATE TABLE,
      UNLIMITED TABLESPACE
    TO tpch;

CREATE OR REPLACE DIRECTORY tpch_dir AS '/data';

GRANT READ ON DIRECTORY tpch_dir TO tpch;

CREATE TABLE tpch.ext_part
(
    p_partkey       NUMBER(10, 0),
    p_name          VARCHAR2(55),
    p_mfgr          CHAR(25),
    p_brand         CHAR(10),
    p_type          VARCHAR2(25),
    p_size          INTEGER,
    p_container     CHAR(10),
    p_retailprice   NUMBER,
    p_comment       VARCHAR2(23)
)
ORGANIZATION EXTERNAL
    (TYPE oracle_loader
          DEFAULT DIRECTORY tpch_dir
              ACCESS PARAMETERS (
                  FIELDS
                      TERMINATED BY '|'
                  MISSING FIELD VALUES ARE NULL
              )
          LOCATION('part.tbl*'))
    PARALLEL 4;

CREATE TABLE tpch.part
(
    p_partkey       NUMBER(10, 0) NOT NULL,
    p_name          VARCHAR2(55) NOT NULL,
    p_mfgr          CHAR(25) NOT NULL,
    p_brand         CHAR(10) NOT NULL,
    p_type          VARCHAR2(25) NOT NULL,
    p_size          INTEGER NOT NULL,
    p_container     CHAR(10) NOT NULL,
    p_retailprice   NUMBER NOT NULL,
    p_comment       VARCHAR2(23) NOT NULL
);

CREATE TABLE tpch.ext_supplier
(
    s_suppkey     NUMBER(10, 0),
    s_name        CHAR(25),
    s_address     VARCHAR2(40),
    s_nationkey   NUMBER(10, 0),
    s_phone       CHAR(15),
    s_acctbal     NUMBER,
    s_comment     VARCHAR2(101)
)
ORGANIZATION EXTERNAL
    (TYPE oracle_loader
          DEFAULT DIRECTORY tpch_dir
              ACCESS PARAMETERS (
                  FIELDS
                      TERMINATED BY '|'
                  MISSING FIELD VALUES ARE NULL
              )
          LOCATION('supplier.tbl*'))
    PARALLEL 4;

CREATE TABLE tpch.supplier
(
    s_suppkey     NUMBER(10, 0) NOT NULL,
    s_name        CHAR(25) NOT NULL,
    s_address     VARCHAR2(40) NOT NULL,
    s_nationkey   NUMBER(10, 0) NOT NULL,
    s_phone       CHAR(15) NOT NULL,
    s_acctbal     NUMBER NOT NULL,
    s_comment     VARCHAR2(101) NOT NULL
);

CREATE TABLE tpch.ext_partsupp
(
    ps_partkey      NUMBER(10, 0),
    ps_suppkey      NUMBER(10, 0),
    ps_availqty     INTEGER,
    ps_supplycost   NUMBER,
    ps_comment      VARCHAR2(199)
)
ORGANIZATION EXTERNAL
    (TYPE oracle_loader
          DEFAULT DIRECTORY tpch_dir
              ACCESS PARAMETERS (
                  FIELDS
                      TERMINATED BY '|'
                  MISSING FIELD VALUES ARE NULL
              )
          LOCATION('partsupp.tbl*'))
    PARALLEL 4;

CREATE TABLE tpch.partsupp
(
    ps_partkey      NUMBER(10, 0) NOT NULL,
    ps_suppkey      NUMBER(10, 0) NOT NULL,
    ps_availqty     INTEGER NOT NULL,
    ps_supplycost   NUMBER NOT NULL,
    ps_comment      VARCHAR2(199) NOT NULL
);

CREATE TABLE tpch.ext_customer
(
    c_custkey      NUMBER(10, 0),
    c_name         VARCHAR2(25),
    c_address      VARCHAR2(40),
    c_nationkey    NUMBER(10, 0),
    c_phone        CHAR(15),
    c_acctbal      NUMBER,
    c_mktsegment   CHAR(10),
    c_comment      VARCHAR2(117)
)
ORGANIZATION EXTERNAL
    (TYPE oracle_loader
          DEFAULT DIRECTORY tpch_dir
              ACCESS PARAMETERS (
                  FIELDS
                      TERMINATED BY '|'
                  MISSING FIELD VALUES ARE NULL
              )
          LOCATION('customer.tbl*'))
    PARALLEL 4;

CREATE TABLE tpch.customer
(
    c_custkey      NUMBER(10, 0) NOT NULL,
    c_name         VARCHAR2(25) NOT NULL,
    c_address      VARCHAR2(40) NOT NULL,
    c_nationkey    NUMBER(10, 0) NOT NULL,
    c_phone        CHAR(15) NOT NULL,
    c_acctbal      NUMBER NOT NULL,
    c_mktsegment   CHAR(10) NOT NULL,
    c_comment      VARCHAR2(117) NOT NULL
);

CREATE TABLE tpch.ext_orders
(
    o_orderkey        NUMBER(10, 0),
    o_custkey         NUMBER(10, 0),
    o_orderstatus     CHAR(1),
    o_totalprice      NUMBER,
    o_orderdate       CHAR(10),
    o_orderpriority   CHAR(15),
    o_clerk           CHAR(15),
    o_shippriority    INTEGER,
    o_comment         VARCHAR2(79)
)
ORGANIZATION EXTERNAL
    (TYPE oracle_loader
          DEFAULT DIRECTORY tpch_dir
              ACCESS PARAMETERS (
                  FIELDS
                      TERMINATED BY '|'
                  MISSING FIELD VALUES ARE NULL
              )
          LOCATION('orders.tbl*'))
    PARALLEL 4;

CREATE TABLE tpch.orders
(
    o_orderkey        NUMBER(10, 0) NOT NULL,
    o_custkey         NUMBER(10, 0) NOT NULL,
    o_orderstatus     CHAR(1) NOT NULL,
    o_totalprice      NUMBER NOT NULL,
    o_orderdate       DATE NOT NULL,
    o_orderpriority   CHAR(15) NOT NULL,
    o_clerk           CHAR(15) NOT NULL,
    o_shippriority    INTEGER NOT NULL,
    o_comment         VARCHAR2(79) NOT NULL
);

CREATE TABLE tpch.ext_lineitem
(
    l_orderkey        NUMBER(10, 0),
    l_partkey         NUMBER(10, 0),
    l_suppkey         NUMBER(10, 0),
    l_linenumber      INTEGER,
    l_quantity        NUMBER,
    l_extendedprice   NUMBER,
    l_discount        NUMBER,
    l_tax             NUMBER,
    l_returnflag      CHAR(1),
    l_linestatus      CHAR(1),
    l_shipdate        CHAR(10),
    l_commitdate      CHAR(10),
    l_receiptdate     CHAR(10),
    l_shipinstruct    CHAR(25),
    l_shipmode        CHAR(10),
    l_comment         VARCHAR2(44)
)
ORGANIZATION EXTERNAL
    (TYPE oracle_loader
          DEFAULT DIRECTORY tpch_dir
              ACCESS PARAMETERS (
                  FIELDS
                      TERMINATED BY '|'
                  MISSING FIELD VALUES ARE NULL
              )
          LOCATION('lineitem.tbl*'))
    PARALLEL 4;

CREATE TABLE tpch.lineitem
(
    l_orderkey        NUMBER(10, 0),
    l_partkey         NUMBER(10, 0),
    l_suppkey         NUMBER(10, 0),
    l_linenumber      INTEGER,
    l_quantity        NUMBER,
    l_extendedprice   NUMBER,
    l_discount        NUMBER,
    l_tax             NUMBER,
    l_returnflag      CHAR(1),
    l_linestatus      CHAR(1),
    l_shipdate        DATE,
    l_commitdate      DATE,
    l_receiptdate     DATE,
    l_shipinstruct    CHAR(25),
    l_shipmode        CHAR(10),
    l_comment         VARCHAR2(44)
);

CREATE TABLE tpch.ext_nation
(
    n_nationkey   NUMBER(10, 0),
    n_name        CHAR(25),
    n_regionkey   NUMBER(10, 0),
    n_comment     VARCHAR(152)
)
ORGANIZATION EXTERNAL
    (TYPE oracle_loader
          DEFAULT DIRECTORY tpch_dir
              ACCESS PARAMETERS (
                  FIELDS
                      TERMINATED BY '|'
                  MISSING FIELD VALUES ARE NULL
              )
          LOCATION('nation.tbl*'))
    PARALLEL 4;

CREATE TABLE tpch.nation
(
    n_nationkey   NUMBER(10, 0),
    n_name        CHAR(25),
    n_regionkey   NUMBER(10, 0),
    n_comment     VARCHAR(152)
);

CREATE TABLE tpch.ext_region
(
    r_regionkey   NUMBER(10, 0),
    r_name        CHAR(25),
    r_comment     VARCHAR(152)
)
ORGANIZATION EXTERNAL
    (TYPE oracle_loader
          DEFAULT DIRECTORY tpch_dir
              ACCESS PARAMETERS (
                  FIELDS
                      TERMINATED BY '|'
                  MISSING FIELD VALUES ARE NULL
              )
          LOCATION('region.tbl*'))
    PARALLEL 4;

CREATE TABLE tpch.region
(
    r_regionkey   NUMBER(10, 0),
    r_name        CHAR(25),
    r_comment     VARCHAR(152)
);
```

```bash
$ vi schema2.sql
```
-schema2.sql을 아래와 같이 작성

```sql
ALTER TABLE tpch.part     PARALLEL 4;
ALTER TABLE tpch.supplier PARALLEL 4;
ALTER TABLE tpch.partsupp PARALLEL 4;
ALTER TABLE tpch.customer PARALLEL 4;
ALTER TABLE tpch.orders   PARALLEL 4;
ALTER TABLE tpch.lineitem PARALLEL 4;

TRUNCATE TABLE tpch.part;
TRUNCATE TABLE tpch.supplier;
TRUNCATE TABLE tpch.partsupp;
TRUNCATE TABLE tpch.customer;
TRUNCATE TABLE tpch.orders;
TRUNCATE TABLE tpch.lineitem;
TRUNCATE TABLE tpch.nation;
TRUNCATE TABLE tpch.region;
```

```bash
$ vi load.sql
```
- load.sql을 아래와 같이 작성

```sql
ALTER SESSION SET nls_date_format='YYYY-MM-DD';
ALTER SESSION ENABLE PARALLEL DML;

INSERT /*+ APPEND */ INTO  tpch.part     SELECT * FROM tpch.ext_part;
INSERT /*+ APPEND */ INTO  tpch.supplier SELECT * FROM tpch.ext_supplier;
INSERT /*+ APPEND */ INTO  tpch.partsupp SELECT * FROM tpch.ext_partsupp;
INSERT /*+ APPEND */ INTO  tpch.customer SELECT * FROM tpch.ext_customer;
INSERT /*+ APPEND */ INTO  tpch.orders   SELECT * FROM tpch.ext_orders;
INSERT /*+ APPEND */ INTO  tpch.lineitem SELECT * FROM tpch.ext_lineitem;
INSERT /*+ APPEND */ INTO  tpch.nation   SELECT * FROM tpch.ext_nation;
INSERT /*+ APPEND */ INTO  tpch.region   SELECT * FROM tpch.ext_region;
```

```bash
$ vi index.sql
```
- index.sql을 아래와 같이 작성

```sql
ALTER TABLE tpch.part
    ADD CONSTRAINT pk_part PRIMARY KEY(p_partkey);

ALTER TABLE tpch.supplier
    ADD CONSTRAINT pk_supplier PRIMARY KEY(s_suppkey);

ALTER TABLE tpch.partsupp
    ADD CONSTRAINT pk_partsupp PRIMARY KEY(ps_partkey, ps_suppkey);

ALTER TABLE tpch.customer
    ADD CONSTRAINT pk_customer PRIMARY KEY(c_custkey);

ALTER TABLE tpch.orders
    ADD CONSTRAINT pk_orders PRIMARY KEY(o_orderkey);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT pk_lineitem PRIMARY KEY(l_linenumber, l_orderkey);

ALTER TABLE tpch.nation
    ADD CONSTRAINT pk_nation PRIMARY KEY(n_nationkey);

ALTER TABLE tpch.region
    ADD CONSTRAINT pk_region PRIMARY KEY(r_regionkey);

ALTER TABLE tpch.partsupp
    ADD CONSTRAINT fk_partsupp_part FOREIGN KEY(ps_partkey) REFERENCES tpch.part(p_partkey);

ALTER TABLE tpch.partsupp
    ADD CONSTRAINT fk_partsupp_supplier FOREIGN KEY(ps_suppkey) REFERENCES tpch.supplier(s_suppkey);

ALTER TABLE tpch.customer
    ADD CONSTRAINT fk_customer_nation FOREIGN KEY(c_nationkey) REFERENCES tpch.nation(n_nationkey);

ALTER TABLE tpch.orders
    ADD CONSTRAINT fk_orders_customer FOREIGN KEY(o_custkey) REFERENCES tpch.customer(c_custkey);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT fk_lineitem_order FOREIGN KEY(l_orderkey) REFERENCES tpch.orders(o_orderkey);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT fk_lineitem_part FOREIGN KEY(l_partkey) REFERENCES tpch.part(p_partkey);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT fk_lineitem_supplier FOREIGN KEY(l_suppkey) REFERENCES tpch.supplier(s_suppkey);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT fk_lineitem_partsupp FOREIGN KEY(l_partkey, l_suppkey)
        REFERENCES tpch.partsupp(ps_partkey, ps_suppkey);

ALTER TABLE tpch.part
    ADD CONSTRAINT chk_part_partkey CHECK(p_partkey >= 0);

ALTER TABLE tpch.supplier
    ADD CONSTRAINT chk_supplier_suppkey CHECK(s_suppkey >= 0);

ALTER TABLE tpch.customer
    ADD CONSTRAINT chk_customer_custkey CHECK(c_custkey >= 0);

ALTER TABLE tpch.partsupp
    ADD CONSTRAINT chk_partsupp_partkey CHECK(ps_partkey >= 0);

ALTER TABLE tpch.region
    ADD CONSTRAINT chk_region_regionkey CHECK(r_regionkey >= 0);

ALTER TABLE tpch.nation
    ADD CONSTRAINT chk_nation_nationkey CHECK(n_nationkey >= 0);

ALTER TABLE tpch.part
    ADD CONSTRAINT chk_part_size CHECK(p_size >= 0);

ALTER TABLE tpch.part
    ADD CONSTRAINT chk_part_retailprice CHECK(p_retailprice >= 0);

ALTER TABLE tpch.partsupp
    ADD CONSTRAINT chk_partsupp_availqty CHECK(ps_availqty >= 0);

ALTER TABLE tpch.partsupp
    ADD CONSTRAINT chk_partsupp_supplycost CHECK(ps_supplycost >= 0);

ALTER TABLE tpch.orders
    ADD CONSTRAINT chk_orders_totalprice CHECK(o_totalprice >= 0);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT chk_lineitem_quantity CHECK(l_quantity >= 0);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT chk_lineitem_extendedprice CHECK(l_extendedprice >= 0);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT chk_lineitem_tax CHECK(l_tax >= 0);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT chk_lineitem_discount CHECK(l_discount >= 0.00 AND l_discount <= 1.00);

ALTER TABLE tpch.lineitem
    ADD CONSTRAINT chk_lineitem_ship_rcpt CHECK(l_shipdate <= l_receiptdate);
```


- generate query file

```bash
$ cd [dbgen_dir]/quries
$ cp ../dists.dss .
for i in {1..22}; do ../qgen $i > query-$i.sql; done
$ ls 
1.sql   16.sql  22.sql  9.sql         query-14.sql  query-20.sql  query-7.sql
10.sql  17.sql  3.sql   dists.dss     query-15.sql  query-21.sql  query-8.sql
11.sql  18.sql  4.sql   query-1.sql   query-16.sql  query-22.sql  query-9.sql
12.sql  19.sql  5.sql   query-10.sql  query-17.sql  query-3.sql
13.sql  2.sql   6.sql   query-11.sql  query-18.sql  query-4.sql
14.sql  20.sql  7.sql   query-12.sql  query-19.sql  query-5.sql
15.sql  21.sql  8.sql   query-13.sql  query-2.sql   query-6.sql

$ cp query-*.sql [script_dir]
```

- make test script
```bash
$ cd [script_dir]
$ touch test.sh
$ sudo chmod u+x test.sh

$ vim test.sh
```

```bash
#!/bin/bash

TEST_NAME= $1
function msecs() {
    echo $((`date +%s%N` / 1000000))
}

function msec_to_sec() {
    MSECS=$1
    SECS=$(($MSECS / 1000))
    MSECS=$(($MSECS - $SECS * 1000))
    printf %d.%03d $SECS $MSECS
}

TOTAL_MSECONDS=0
for q in {1..22}
do
    echo "start query-$q"
    START=`msecs`
    echo exit | sqlplus tpch/tpch @query-$q.sql > /dev/null
    END=`msecs`
    DURATION=$(( $END - $START ))
    echo "duration of query-$q = $DURATION"
    printf "%d: \t%16s secs\n" $q `msec_to_sec $DURATION` >> /local_log/$1-tpch-$q.log
    TOTAL_MSECONDS=$(( $TOTAL_MSECONDS + $DURATION ))
done

printf "Total: \t%16s secs\n" `msec_to_sec $TOTAL_MSECONDS` >> /local_log/$1-tpch-final.log
```



## Create Oracle12c Container
- make script for TPCH init
``` bash
$ vi [script_dir]/initialize.sh
```
```bash
#!/bin/bash

# Set conf file path to the mounted point

su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/control1.sql'
mv /u01/app/oracle/oradata/xe/control01.ctl /mount/
mv /u01/app/oracle/fast_recovery_area/xe/control02.ctl /mount/
su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/control2.sql'

su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/log1.sql'
mv /u01/app/oracle/oradata/xe/redo0* /mount/
su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/log2.sql'

su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/data1.sql'
mv /u01/app/oracle/oradata/xe/*.dbf /mount/
su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/data2.sql'
su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/schema1.sql'
su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/schema2.sql'
su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/load.sql'
su oracle -c 'export PATH=$PATH:$ORACLE_HOME/bin;echo exit | sqlplus / as sysdba @/tpch/index.sql'
```

- Create Oracle Container
```bash
$ docker run --name oracle12c \
-d \
-v [test_dir]/:/mount \
-v [data_dir]:/data \
-v [script_dir]:/tpch \
-v [log_dir]:/local_log\
truevoly/oracle-12
```

- waiting for initialize oracle container

```bash
$ docker logs -f oracle12c

Database not initialized. Initializing database.

Starting tnslsnr

Copying database files

1% complete

3% complete

11% complete

18% complete

26% complete

37% complete

Creating and starting Oracle instance

40% complete

45% complete

......

Import finished

Database ready to use. Enjoy! ;)
```

- data load and index

```bash
$ sudo docker exec -it oracle12c /bin/bash -c "chown -R oracle:dba /mount; chown -R oracle:dba /data"
$ sudo docker exec -u 0 oracle12c /tpch/initialize.sh # 4시간 정도 걸림
```


