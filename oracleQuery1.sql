/*
    CRUD: create(insert), read, update, delete

    DDL: Data Definition Language(테이블 구조 정의)
         create(테이블 생성), alter(기존 테이블 수정), drop(테이블 삭제), truncate(테이블 내용 삭제, idx=0) 
    *DML: Data Manipulation Language: 데이터 조작
          select(선택), insert(삽입), delete(테이블 내용 삭제, idx는 유지), update(수정)
    DCL: Data Control Language 
         commit, rollback, grant(권한 주기), revoke(권한 뺏기)    
    DQL: DML 에서 select만 따로 분리해서 정의
*/

/* select문 사용법
    select 컬럼명, 컬럼명... from 테이블이름
*/

-- 현재 계정이 가지고 있는 모든 테이블 정보
select table_name from user_tables;

desc emp; -- emp 테이블 구성 정보(어느칸이 문자형이냐 숫자형이냐)
select empno, ename from emp;

-- emp 테이블에서 empno, ename, deptno 만 출력
-- 별칭설정: '컬럼명 as 별칭' 또는 '컬럼명 별칭'
--           '* as 별칭' 는 안됨
select empno as 직원번호, ename 직원이름, deptno  from emp;

-- emp 테이블에서 특정 조건만 출력되게 하기
/*************
- where 절
    특정 조건 선택시 where 절 이용
    조건 여러개일때는 and나 or 사용
    and와 or 같이 사용시 괄호 잘 써야함.
    (and가 먼저 동작)    
*/
-- 
-- deptno가 30번인 직원들 출력
select empno as 직원번호, ename 직원이름, deptno, sal  
    from emp where deptno=30;
    
-- deptno가 30번 이고, sal 이 1500 이상인 직원들 출력

select empno as 직원번호, ename 직원이름, deptno, sal  
    from emp where deptno=30 and sal >= 1500;

select empno as 직원번호, ename 직원이름, deptno, sal  
    from emp where deptno=30 or sal >= 1500;
    
-- deptno 가 10, 20인 직원들 출력
select empno as 직원번호, ename 직원이름, deptno, sal  
    from emp WHERE deptno=10 or deptno=20;
select empno as 직원번호, ename 직원이름, deptno, sal  
    from emp WHERE deptno<30;
    
-- 아래 두개는 and와 or을 같이 쓰는 예제.
-- 괄호 때문에 둘의 결과가 다름
select empno as 직원번호, ename 직원이름, deptno, sal  
from emp 
WHERE deptno=10 or (deptno=20 and sal>=1500);

select empno as 직원번호, ename 직원이름, deptno, sal  
from emp 
WHERE (deptno=10 or deptno=20) and sal>=1500;

-- 범위: 비교연산자를 이용해서 특정 범위 설정 가능
select empno as 직원번호, ename 직원이름, deptno, sal , sal * 12 as 연봉
from emp 
WHERE (deptno=10 or deptno=20) and sal>=1500;

-- emp 테이블에는 없는 '연봉' 출력
select empno as 직원번호, ename 직원이름, deptno, sal , sal * 12 as 연봉
from emp 
WHERE (deptno=10);

/***************************************************
    정렬: order by절 
         오름차순(desc), 내림차순(asc, 기본값)
         사용법: order by 컬럼명, 컬럼명...
         *where절은 컬럼명 여러개일때 and나 or로 구분
          order by절은 , 로 구분
         *필요할때만 사용하기(코스트가 발생하기 때문)
*/
select * from emp order by deptno asc, sal asc;

-- deptno 가 30인 직원들을 sal 높은순으로 나열
select * from emp where deptno=30 order by sal desc;

/*
    그룹화: group by절
            group by절은 집계함수와 같이 사용해야한다.
            
    count(): 테이블의 row 수 구하기
    max(컬럼명): 해당 컬럼에서 제일 큰 값
    min(컬럼명): 해당 컬럼에서 제일 작은 값
    avg(컬럼명): 해당 컬럼에서 평균값
    sum(컬럼명): 해당 컬럼들의 합
*/
select * from emp order by deptno;
 
select deptno, mgr from emp 
where deptno=30;

select deptno, count(*) from emp 
 group by deptno, mgr order by deptno asc;

-- 최고 월급 얼만지 구하기
select max(sal) from emp;
-- 서브쿼리 (최고 월급자 뽑기) 
select emp.ename, sal from emp 
    where sal = (select max(sal) 
                    from emp);
                    
-- 최저 월급 얼만지 구하기
select min(sal) from emp;
-- 전체 월급 얼만지 구하기
select sum(sal) from emp;
-- 평균 월급 얼만지 구하기
select avg(sal) from emp; -- 소수점 자리수 엄청 많이 나옴
/* 소수점 자리 구하기 
    TO_CHAR(값, 포멧) - 포멧은 0 과 9 사용
    포멧팅의 숫자번째마다 실제값의 숫자번째를 의미하고,
    (포멧팅)9의 의미는 실제값의 그 자리에 숫자가 없으면 화면에 표시 안함
    0의 의미는 실제값에 그 자리에 숫자가 없으면 0으로 표시
    ex) TO_CHAR(avg(sal), 'FM9990.00')
        포멧:FM999990.00, 실제값: 1234.56, 결과-> 1234.56
        포멧:FM000000.00, 실제값: 1234.56, 결과-> 001234.56
*/
select TO_CHAR(92077.085, 'FM00000.9009') from dual;

-- 각 부서의 최대급여, 최소급여, 평균 급여(XXXX,XX) 구하기
select deptno, max(sal), min(sal) , RTRIM(TO_CHAR(avg(sal), 'FM9999999.99')) 
from emp group by deptno order by deptno;
select deptno, max(sal), min(sal) , TO_CHAR(avg(sal), 'FM0000000.99') 
from emp group by deptno order by deptno;

/******************
    having절 - (group by 한 결과에 where절 추가한것과 같은결과)
    *group by절 사용시에만 사용 가능
     group by절의 결과값의 범위 제한할때 사용
*/ 
select deptno, max(sal), min(sal) , RTRIM(TO_CHAR(avg(sal), 'FM9999999.99')) avg
from emp group by deptno HAVING avg(sal) >= 2000 order by deptno;

/**************************************/
/* 연산자 */
-- IN 연산자
select * from emp 
where job='CLERK' or  job='SALESMAN' or  job='MANAGER';
select * from emp 
where job IN ('CLERK','SALESMAN','MANAGER');

-- between 연산자
select * from emp where 1500 <= sal and sal <= 2500;
select * from emp where sal between 1500 and 2500;

-- *like 연산자: %를 이용해서 %부분은 문자가 있던 말던 무시
--              대소문자 구분
select * from emp where job='CL';
select * from emp where job like '%L%';
select * from emp where ename like '%LL%';

-- Null 값 체크 : is not null
select * from emp;
select * from emp where comm = null; -- 에러아님. 아무것도 안가져옴
select * from emp where comm is not null;
select * from emp where comm is null;

/*결합연산자
    1) union: 합집합(결과값의 중복이 있으면 제거)
    2) union all: 합집합(결과값의 중복이 있어도 모두 출력)
    3) minus: 차집합(먼저 작성한 select의 결과에서 빼기)
    4) intersect: 교집합(먼저 작성한 select 결과에서 두번째 select와 같은것만 출력)
*/
select empno, ename,deptno from emp where deptno=10
UNION
select empno, ename,deptno from emp where deptno=20 
order by deptno asc;

/*아래 두개 select문은 deptno=10 으로 동일한 테이블의 결합하고 있음.
    UNION 의 경우 동일한 결과가 두번 출력되지 않고 (결과3개 나옴)
    UNION ALL 의 경우는 그냥 그런거 신경 안쓰고 다 나온다.(결과 6개 나옴)
*/
select ename, job, sal, comm from emp where deptno=10
UNION
select ename, job, sal, comm from emp where deptno=10;

select ename, job, sal, comm from emp where deptno=10
UNION ALL
select ename, job, sal, comm from emp where deptno=10;

/* minus - 첫번째 select 결과에서 두번째select(deptno=10) 의 결과를 뺀거  */
select ename, job, sal, comm, deptno from emp
MINUS
select ename, job, sal, comm, deptno from emp where deptno=10;


/* intersect- 교집합, 첫번째 select 결과에서 두번째select(deptno=10)의 결과와 겹치는거만 출력 */
select ename, job, sal, comm, deptno from emp
INTERSECT
select ename, job, sal, comm, deptno from emp where deptno=10;

/**********************************************/
/*****************  연습문제 *******************/
/**********************************************/
-- 1. emp테이블에서 ename이 S로 끝나는 사원 데이터 모두 출력
select * from emp where ename like '%S'; 
-- 2. deptno가 30인 사원중에 job이 SALESMAN인 사원의 사원번호,이름,직책,급여,부서번호 출력
select empno,ename,job,sal,deptno from emp where deptno=30 and job='SALESMAN';
-- 3. 부서번호 20,30인 부서중 급여가 2000 이상인 사원을 높은 급여순으로 출력
select * from emp where (deptno=20 or deptno=30) and sal>=2000;
-- 4. 30번 부서중 급여가 1000~2000 사이가 아닌 직원정보 출력
select * from emp where deptno=30 and not(sal>=1000 and sal <=2000);
select * from emp where deptno=30 and (sal<1000 or sal >2000);
/**********************************************/

/* 함수 */
/* 문자함수
    upper: 모두 대문자
    lower: 모두 소문자
    initcap: 각 단어의 첫문자들만 대문자
    length: 문자열 길이
    count: row개수
    substr: 문자열자르기 ex)substr(job, 3,2) => job에서 세번째 글자부터 2개 잘라오기
    concat: 문자열합치기 ex)select concat(empno, ename) from emp;
*/ 
select lower(job), initcap(job) from emp;
select * from emp where ename=upper('allen');
select ename, length(ename) from emp;
select count(*) from emp;
select job, substr(job, 3,2) from emp;
select concat(empno, ename) from emp;
/* 숫자함수 
    round: 반올림
    ceil: 올림
    floor: 내림
    trunc: 특정 위치 이하 버림(소수점, 정수부분 다 가능)
            trunc(값, 자리수) => 자리수: 양수는 '소수점 몇자리' 를 의미
                                        음수는 정수자리를 버리진 않고 0으로만 바꿈
                                    ex) trunc(123.4567, 2) => 123.45
                                        trunc(123.4567, -1) => 120
    mod: %같은거. ex) mod(분자, 분모)  
                     mod(나눠지는 수, 나누는 수)  
                     mod(10, 3) => 10 % 3 => 1
    
*/ 
select round(123.4567),ceil(123.4567),floor(123.4567), mod(10, 3) from dual;
select trunc(123.4567), trunc(123.4567, 2), trunc(123.4567, -1) from dual;
 

/* 날짜함수 
    sysdate - 월,년 바뀔때 알아서 다 해줌
    날짜포멧 변경방법: 메뉴바 > 도구 > 환경설정 > 데이터 베이스 > NLS 에서 변경 가능
*/
select sysdate as 오늘 from dual;

-- 날짜 더하기 빼기
select sysdate as 오늘, (sysdate+5) as 오일후 from dual;
-- 월 더하기 빼기 (add_months)
select sysdate as 오늘, add_months(sysdate, -3) as 세달전 from dual;
-- 두 날짜 사이 간격(월) (months_between)
select sysdate as 오늘, trunc(months_between(sysdate, add_months(sysdate, 3))) as 날짜간격 from dual;

-- 포멧 변경
/* - 형변환
    TO_CHAR: Date형을 문자형으로 변환
    TO_DATE: 문자형을 Date형으로 변환
    TO_NUMBER
*/
select TO_DATE(sysdate, 'yyyy-mm-dd') from emp; -- TO_DATE에서는 형변환 의미 없음. 메뉴바 > 도구 가서 변경할것
select TO_CHAR(sysdate, 'yyyy-mm-dd') from emp; 

select TO_CHAR(hiredate, 'yyyy-mm-dd') as 고용일, TO_CHAR(sysdate) as 오늘, (TO_DATE(hiredate) - TO_DATE(sysdate)) as 날짜간격 from emp;
select TO_CHAR(hiredate, 'yyyy-mm-dd') as 고용일, TO_CHAR(sysdate) as 오늘, (abs(TO_DATE(sysdate, 'yyyy-mm-dd')-TO_DATE(hiredate, 'yyyy-mm-dd'))) as 날짜간격 from emp;
 
-- 근속년수 구하기
select 
    TO_CHAR(hiredate, 'yyyy-mm-dd') as 고용일, 
    TO_CHAR(sysdate) as 오늘, 
    ceil(trunc(abs(months_between(TO_DATE(sysdate), TO_DATE(hiredate)))) / 12) as 근속년수
from emp;

/*  날짜 포멧 */
select TO_CHAR(SYSDATE,'yyyymmdd') from dual;
select TO_CHAR(SYSDATE,'yyyy-mm-dd') from dual;
select TO_CHAR(SYSDATE,'yyyy') from dual;
select TO_CHAR(SYSDATE,'yy') from dual;
select TO_CHAR(SYSDATE,'mm') from dual; -- 월 기본 숫자 두자리
select TO_CHAR(SYSDATE,'mon') from dual; -- 문자형태의 월 
select TO_CHAR(SYSDATE,'day') from dual; -- 문자형태의 요일 
select TO_CHAR(SYSDATE,'dy') from dual; --  문자형태의 요일(한자리)
select TO_CHAR(SYSDATE,'d') from dual; -- 요일: 1(일요일)~7(토요일)
select TO_CHAR(SYSDATE,'dd') from dual; -- 날짜
select TO_CHAR(SYSDATE,'ddd') from dual; -- 날짜(365일중에 몇번째 일인지 구해줌)
select TO_CHAR(SYSDATE,'ww') from dual; -- 1년 (53주) 중에 몇번째 주인지 출력
select TO_CHAR(SYSDATE,'w') from dual; -- 이번달 중에 몇번째 주인지 출력
select TO_CHAR(SYSDATE,'dl') from dual; -- 날짜가 기본 포멧팅으로 되서 출력 ex) 2023년 9월 27일 수요일

-- 시간 포멧
select TO_CHAR(SYSDATE,'am') from dual;
select TO_CHAR(SYSDATE,'pm') from dual;
select TO_CHAR(SYSDATE,'hh') from dual; -- 12시간제
select TO_CHAR(SYSDATE,'hh24') from dual; -- 24시간제
select TO_CHAR(SYSDATE,'mi') from dual; -- 분(기본 두자리수. 00~59)
select TO_CHAR(SYSDATE,'ss') from dual; -- 초(기본 두자리수. 00~59)

/*********************************************************************************/
/*********************************************************************************/
/*
    = 테이블 생성(create문) =
        create table 테이블명 (
            열이름  데이터타입  [옵션];
        );
        - 데이터타입
            char(숫자): 문자형.
                  varchar2와 같지만 고정길이 문자
            varchar2(숫자): 문자형
                            숫자 byte의 가변길이 분자
                            최대 4000byte 까지 가능
            long: 문자형
                  가변길이 문자형 데이터
                  최대 2G. 
                  테이블당 하나의 컬럼만 생성 가능
                  
            number(숫자): 숫자만큼의 가변길이 정수형
                          최대 38자리까지 가능
            number(숫자,숫자): 숫자자리 만큼의 가변길이 실수형
            number(7,2): 7자리 가변길이 정수와 2자리 가변길이 소수점 
            
            date: 날짜
            
        - 코멘트            
           생성: 테이블인 경우-> comment on table 테이블명 is '쓸말';
                 컬럼인 경우 ->  comment on column 테이블명.컬럼명 is '쓸말';
           수정: comment on table 테이블명 is '수정할 말'
                comment on column 테이블명.컬럼명 is '수정할 말'
           삭제: comment on table 테이블명 is ''
                comment on column 테이블명.컬럼명 is ''
                
        - 테이블 생성시 코멘트 같이 작성
            create table 테이블명 (
                열이름  데이터타입  [옵션] [Comment '쓸말'];
            );
            
    == 제약조건 == 
        constraint 종류
            1) unique: 해당 컬럼에 중복되는 데이터 금지
            2) NOT NULL: 해당 컬럼은 무조건 정보가 들어가 있어야 한다.
                         (최대한 null값이 없는 테이블로 설계 하는걸 추천)
            3) primary key(기본키) : unique와 not null이 포함되어 있음.
            4) foreign key(외래키) : 다른 테이블의 기본키 값을 연결해서 현재 테이블에 가져다 쓰는것(연결된것)
            
        
        사용이유: 각 테이블에 해당 컬럼이 어떤 조건을 가져야하는지 결정하고,
                 해당 조건을 만족하지 않는 정보가 들어올때 오류를 나타내준다.
                 (한마디로 잘못된 정보가 들어가지 않게 제약사항을 걸어주기 위함)
        
        select * from user_constraints; -- 유저가 소유하고 있는 제약조건 검색
        select * from user_cons_columns; -- 컬럼별로 소유한 제약조건 검색
        
    == 제약조건 수정, 추가, 변경, 삭제 ==
        추가: alter table 테이블이름 add constraint 제약조건이름 제약조건(컬럼명);
        수정: alter table 테이블이름 MODIFY 컬럼명 제약조건;
        이름변경: alter table 테이블이름 rename constraint 이름 to 새이름;
        삭제: alter table 테이블이름 drop constraint 제약조건명;
*/
    drop table classes; -- 클래스 삭제

    -- 제약조건 pk 같이 만들때
    create table classes (
        cno number(4) constraint classesPK_con primary key,
        cname varchar2(255) not null 
    );
    
    -- 제약조건 없이 만들때
    create table classes (
        cno number(4),
        cname varchar2(255) 
    );
    -- 제약조건 추가
    -- alter table 테이블이름 add constraint 제약조건명 제약조건(컬럼명);
    alter table classes add constraint classes_PK_con primary key(cno);
    alter table classes add constraint classes_UNI_cname UNIQUE(cname);
    
    -- 제약조건 수정
    -- alter table 테이블이름 MODIFY 컬럼명 제약조건;
    alter table classes MODIFY cname NOT NULL;
    alter table classes MODIFY cname NULL;
    select * from user_cons_columns; -- 유저가 가지고 있는 컬럼별로 제약조건 검색
    
    -- 제약조건 이름변경
    -- alter table 테이블이름 rename constraint 이름 to 새이름;
    alter table classes rename CONSTRAINT classes_UNI_cname to classes_UQ_cname;
    alter table classes rename CONSTRAINT SYS_C007466 to classes_NN_cname; 
    
    -- 제약조건 삭제
    -- alter table 테이블이름 drop constraint 제약조건명;
    alter table classes drop CONSTRAINT classes_UQ_cname;
    
    insert into classes values (1,'홍길동'); 

--    -- 코멘트 생성
--    comment on table classes is '반정보';
--    comment on column classes.cno is '반_고유번호';
--    comment on column classes.cname is '반_이름';
--    
--    -- 코멘트 확인
--    select * from user_tab_comments;
--    select * from user_col_comments;

    desc classes;

    drop table classes;
    
/* 클래스에 정보 삽입 
    insert into 테이블명 values (컬럼1값, 컬럼2값,....); 
    insert into 테이블명 (컬럼명1, 컬럼명2,...) values (컬럼1값, 컬럼2값,....); 
*/
    
    
/**********************************************/
/*
연습: 비트스터디 학원 관련 db를 설계해보자
    필요한 테이블 - 학생, 강좌, 강사
        학생 - 학생코드(PK),이름,연락처(N),등록일,수업코드(FK),강사코드(FK)
        강좌 - 수업코드(PK),수업명,기간,시간,강의장(N)
        강사 - 강사코드(pk),강사이름,등록일
*/     
    drop table classes;
    create table classes (
        c_seqno varchar2(10) constraint classesPK_c_seqno primary key,
        c_name varchar2(255) not null,
        c_startPeriod date not null,
        c_endPeriod date not null,
        c_roomNo varchar2(255) not null
    );
    insert into classes values ('C-001','자바', '2023-10-04', '2023-12-31', 'D강의장');
    insert into classes values ('C-002','C', '2023-10-04', '2023-12-31', '501강의장');
    insert into classes values ('C-003','파이선', '2023-10-04', '2023-12-31', '302강의장');
    
    drop table teacher;
    create table teacher (
        t_seqno varchar2(10) constraint teacherPK_t_seqno primary key,
        t_name varchar2(255) not null,
        t_regDate date not null
    ); 
    insert into teacher values ('T-001', '선생1', '2022-01-01');
    insert into teacher values ('T-002', '선생2', '2022-01-01');
    insert into teacher values ('T-003', '선생3', '2022-01-01');
    
    drop table student;
    create table student (
        s_seqno varchar2(10) constraint studentPK_s_seqno primary key,
        s_name varchar2(50) not null,
        s_phone varchar2(50),
        s_regDate date not null, 
        c_seqno varchar2(10) constraint studentFK_c_seqno REFERENCES classes(c_seqno) ,
        t_seqno varchar2(10) constraint studentFK_t_seqno REFERENCES teacher(t_seqno)
    );
    truncate table student;
    insert into student values ('S-001', '뷔', '010-1111-2222','2023-10-04','C-001','T-001');
    insert into student values ('S-002', '학생2', '010-1111-2222','2023-10-04','C-001','T-001');
    insert into student values ('S-003', '학생3', '010-1111-2222','2023-10-04','C-002','T-002');
    insert into student values ('S-004', '학생4', '010-1111-2222','2023-10-04','C-001','T-001');
    insert into student values ('S-005', '학생25', '010-1111-2222','2023-10-04','C-001','T-001');
    
--    insert into student (s_name, s_phone) values ('학생 5', '010-1234-5678')
/* 
    = 수정(update문) =
    update 테이블명 set 컬럼명=값 where 컬럼명=값;
    *주의: where 없으면 싹 다 바뀜
*/
    update student set s_name='진' where s_seqno='S-002';

/* = 삭제(delete문) =
    delete from 테이블명;
    delete from 테이블명 where 컬럼명=값;
*/
    delete from student where s_seqno='S-001';
    
/* == 변경(alter) - 테이블 속성 변경 */
-- 컬럼 추가 
    alter table teacher add T_GEN varchar2(10);
    update teacher set T_GEN='Male';
    
-- 컬럼명 변경
    alter table teacher RENAME COLUMN T_GEN to T_GENDER;

-- 자료형 변경
    update teacher set T_GENDER =''; -- 자료형변경을 하려면 해당 컬럼이 비어있어야 한다.
    alter table teacher MODIFY T_GENDER number(1); 
    
-- 열 삭제
    alter table teacher drop column T_GENDER;

/************************************************/
/* 테이블 결합 - join 
    1) inner 타입: null값이면 안나옴
                  equi join: 오라클에서 가장 많이 사용되는 방법
        
    2) outer 타입: null값이어도 나옴
                left outer join
                right outer join
    *보통 inner join이랑 left join 많이 씀(right로 하면 null 애들이 나올수도 있음)
*/

select s.s_seqno, s.s_name, c.*, t.t_name
    from student S join classes C 
        on C.c_seqno = s.c_seqno
            join teacher T 
                on s.t_seqno=t.t_seqno
            order by t.T_SEQNO;
        
/**********************************************/
-- 연습1: emp 정보에 추가로 부서와 지사 정보 같이 출력하기
select E.empno, e.ename, e.job, e.mgr, D.* 
    from emp E
        join dept D
            on E.deptno = D.deptno
            order by E.empno;
-- 위에 코드를 조금 줄여서 쓴거
select E.empno, e.ename, e.job, e.mgr, D.* 
    from emp E, dept D
        where E.deptno = D.deptno
        order by E.empno;
    
-- 연습2: 직원정보에 매니져 이름 추가
-- MGR 이 null 인 직원은 안출력
select e.empno, e.ename, e.job, e.mgr, 
       em.empno, em.ename, em.job
    from emp e 
        join emp em
            on e.mgr = em.empno;
            
-- MGR 이 null 인 직원도 출력    
select e.empno, e.ename, e.job, e.mgr, 
       em.empno, em.ename, em.job
    from emp e 
        join emp em
            on e.mgr = em.empno(+);
            
select e.empno, e.ename, e.job, e.mgr, 
       em.empno, em.ename, em.job
    from emp e 
        left outer join emp em
            on e.mgr = em.empno;

/***********************************************/
/* 서브쿼리 
    -- 최고 월급자 뽑기
    select emp.ename, sal from emp 
        where sal = (select max(sal) 
                        from emp);
                        
    select, from, where 절에 사용 가능.
    order by 에도 사용은 가능하지만 잘 쓰지 않는다.
    (데이터 구조나 양에 따라 다르지만 일반적으로 서브쿼리는 사용을 피하는게 좋다)
    
    1) select 절 서브쿼리 (스칼라 서브쿼리)
        서브쿼리 결과는 하나 또는 집계함수를 거친 단일 값으로 리턴되야 한다.
    2) from 절 서브쿼리  (인라인뷰 서브쿼리)
        서브쿼리 결과는 하나의 테이블로 리턴되야 한다.
    *3) where 절 서브쿼리  (Nested 서브쿼리)
        단일행, 복수행 다 상관없이 리턴 가능하다
        
*/
--empno가 7499인 사원의 직업과 동일한 직원들 정보 출력
select * from emp where job=(select job from emp 
                            where EMPNO=7499);
                            
-- empno가 7654인 사원의 job과 동일하고 sal이 높은 사원들 정보 다 출력
select*from emp 
where job=(select job from emp where EMPNO=7654)
    and sal > (select sal from emp where EMPNO=7654);
    
--from절에서 쓰는 서브쿼리 예제
--전체 emp중에 가장 적은 연봉자 정보 출력

select * from emp order by sal asc ;

select * from (select * from emp order by sal asc )where rownum=1;

--부서별 가장 작은 연봉자 정보 출력
select deptno,min(sal) from emp group by deptno;
select el.empno, el.ename, el.sal, e2.* 
from emp el
    join (select deptno, min(sal) from emp group by depno) e2 
    on el.sal=e2.sal;
    
    --급여가 평균 금액보다 높은 사원 모두 출력
    select ename,sal from emp
    where sal > (select avg(sal) from emp);

