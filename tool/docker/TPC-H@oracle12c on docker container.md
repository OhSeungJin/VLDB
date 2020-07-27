
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

6. Generate TPC-H Benchmark DATA
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
