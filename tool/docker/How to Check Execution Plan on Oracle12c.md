# How to Check Execution Plan on Oracle12c


## Thanks to
  - [Link](https://m.blog.naver.com/sophie_yeom/2208915296680)
  
  
## 1) Oracle12c에 sysdba로 접속
 ```bash
 $ sqlplus / as sysdba
 
 SQL> @?/sqlplus/admin/plustrce.sql;
 
 SQL> grant plustrace to [user_name];
 
 SQL> connect [user_name]/[user_pw];
 
 SQL> @?/rdbms/admin/utlxplan.sql;
 
 SQL> set autotrace on;
 
 SQL> [실행계획 확인할 쿼리].sql;

```


## autotrace option
``` sql
1. set autotrace on
SQL 실제 수행 => SQL 실행결과, 실행계획 및 실행통계 출력
2. set autotrace on explain
SQL 실제 수행 => SQL 실행결과, 실행계획 출력
3. set autotrace on statistics
SQL 실제 수행 => SQL 실행결과, 실행통계 출력
4. set autotrace traceonly
SQL 실제 수행 => 실행계획 및 실행통계 출력
5. set autotrace traceonly explain
SQL 실제 수행 X => 실행계획 출력
6. set autotrace traceonly statistics
SQL 실제 수행 => 실행통계 출력
```     
 
 
 
