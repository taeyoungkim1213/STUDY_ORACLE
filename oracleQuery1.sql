/*
    CRUD: create(insert), read, update, delete

    DDL: Data Definition Language(���̺� ���� ����)
         create(���̺� ����), alter(���� ���̺� ����), drop(���̺� ����), truncate(���̺� ���� ����, idx=0) 
    *DML: Data Manipulation Language: ������ ����
          select(����), insert(����), delete(���̺� ���� ����, idx�� ����), update(����)
    DCL: Data Control Language 
         commit, rollback, grant(���� �ֱ�), revoke(���� ����)    
    DQL: DML ���� select�� ���� �и��ؼ� ����
*/

/* select�� ����
    select �÷���, �÷���... from ���̺��̸�
*/

-- ���� ������ ������ �ִ� ��� ���̺� ����
select table_name from user_tables;

desc emp; -- emp ���̺� ���� ����(���ĭ�� �������̳� �������̳�)
select empno, ename from emp;

-- emp ���̺��� empno, ename, deptno �� ���
-- ��Ī����: '�÷��� as ��Ī' �Ǵ� '�÷��� ��Ī'
--           '* as ��Ī' �� �ȵ�
select empno as ������ȣ, ename �����̸�, deptno  from emp;

-- emp ���̺��� Ư�� ���Ǹ� ��µǰ� �ϱ�
/*************
- where ��
    Ư�� ���� ���ý� where �� �̿�
    ���� �������϶��� and�� or ���
    and�� or ���� ���� ��ȣ �� �����.
    (and�� ���� ����)    
*/
-- 
-- deptno�� 30���� ������ ���
select empno as ������ȣ, ename �����̸�, deptno, sal  
    from emp where deptno=30;
    
-- deptno�� 30�� �̰�, sal �� 1500 �̻��� ������ ���

select empno as ������ȣ, ename �����̸�, deptno, sal  
    from emp where deptno=30 and sal >= 1500;

select empno as ������ȣ, ename �����̸�, deptno, sal  
    from emp where deptno=30 or sal >= 1500;
    
-- deptno �� 10, 20�� ������ ���
select empno as ������ȣ, ename �����̸�, deptno, sal  
    from emp WHERE deptno=10 or deptno=20;
select empno as ������ȣ, ename �����̸�, deptno, sal  
    from emp WHERE deptno<30;
    
-- �Ʒ� �ΰ��� and�� or�� ���� ���� ����.
-- ��ȣ ������ ���� ����� �ٸ�
select empno as ������ȣ, ename �����̸�, deptno, sal  
from emp 
WHERE deptno=10 or (deptno=20 and sal>=1500);

select empno as ������ȣ, ename �����̸�, deptno, sal  
from emp 
WHERE (deptno=10 or deptno=20) and sal>=1500;

-- ����: �񱳿����ڸ� �̿��ؼ� Ư�� ���� ���� ����
select empno as ������ȣ, ename �����̸�, deptno, sal , sal * 12 as ����
from emp 
WHERE (deptno=10 or deptno=20) and sal>=1500;

-- emp ���̺��� ���� '����' ���
select empno as ������ȣ, ename �����̸�, deptno, sal , sal * 12 as ����
from emp 
WHERE (deptno=10);

/***************************************************
    ����: order by�� 
         ��������(desc), ��������(asc, �⺻��)
         ����: order by �÷���, �÷���...
         *where���� �÷��� �������϶� and�� or�� ����
          order by���� , �� ����
         *�ʿ��Ҷ��� ����ϱ�(�ڽ�Ʈ�� �߻��ϱ� ����)
*/
select * from emp order by deptno asc, sal asc;

-- deptno �� 30�� �������� sal ���������� ����
select * from emp where deptno=30 order by sal desc;

/*
    �׷�ȭ: group by��
            group by���� �����Լ��� ���� ����ؾ��Ѵ�.
            
    count(): ���̺��� row �� ���ϱ�
    max(�÷���): �ش� �÷����� ���� ū ��
    min(�÷���): �ش� �÷����� ���� ���� ��
    avg(�÷���): �ش� �÷����� ��հ�
    sum(�÷���): �ش� �÷����� ��
*/
select * from emp order by deptno;
 
select deptno, mgr from emp 
where deptno=30;

select deptno, count(*) from emp 
 group by deptno, mgr order by deptno asc;

-- �ְ� ���� ���� ���ϱ�
select max(sal) from emp;
-- �������� (�ְ� ������ �̱�) 
select emp.ename, sal from emp 
    where sal = (select max(sal) 
                    from emp);
                    
-- ���� ���� ���� ���ϱ�
select min(sal) from emp;
-- ��ü ���� ���� ���ϱ�
select sum(sal) from emp;
-- ��� ���� ���� ���ϱ�
select avg(sal) from emp; -- �Ҽ��� �ڸ��� ��û ���� ����
/* �Ҽ��� �ڸ� ���ϱ� 
    TO_CHAR(��, ����) - ������ 0 �� 9 ���
    �������� ���ڹ�°���� �������� ���ڹ�°�� �ǹ��ϰ�,
    (������)9�� �ǹ̴� �������� �� �ڸ��� ���ڰ� ������ ȭ�鿡 ǥ�� ����
    0�� �ǹ̴� �������� �� �ڸ��� ���ڰ� ������ 0���� ǥ��
    ex) TO_CHAR(avg(sal), 'FM9990.00')
        ����:FM999990.00, ������: 1234.56, ���-> 1234.56
        ����:FM000000.00, ������: 1234.56, ���-> 001234.56
*/
select TO_CHAR(92077.085, 'FM00000.9009') from dual;

-- �� �μ��� �ִ�޿�, �ּұ޿�, ��� �޿�(XXXX,XX) ���ϱ�
select deptno, max(sal), min(sal) , RTRIM(TO_CHAR(avg(sal), 'FM9999999.99')) 
from emp group by deptno order by deptno;
select deptno, max(sal), min(sal) , TO_CHAR(avg(sal), 'FM0000000.99') 
from emp group by deptno order by deptno;

/******************
    having�� - (group by �� ����� where�� �߰��ѰͰ� �������)
    *group by�� ���ÿ��� ��� ����
     group by���� ������� ���� �����Ҷ� ���
*/ 
select deptno, max(sal), min(sal) , RTRIM(TO_CHAR(avg(sal), 'FM9999999.99')) avg
from emp group by deptno HAVING avg(sal) >= 2000 order by deptno;

/**************************************/
/* ������ */
-- IN ������
select * from emp 
where job='CLERK' or  job='SALESMAN' or  job='MANAGER';
select * from emp 
where job IN ('CLERK','SALESMAN','MANAGER');

-- between ������
select * from emp where 1500 <= sal and sal <= 2500;
select * from emp where sal between 1500 and 2500;

-- *like ������: %�� �̿��ؼ� %�κ��� ���ڰ� �ִ� ���� ����
--              ��ҹ��� ����
select * from emp where job='CL';
select * from emp where job like '%L%';
select * from emp where ename like '%LL%';

-- Null �� üũ : is not null
select * from emp;
select * from emp where comm = null; -- �����ƴ�. �ƹ��͵� �Ȱ�����
select * from emp where comm is not null;
select * from emp where comm is null;

/*���տ�����
    1) union: ������(������� �ߺ��� ������ ����)
    2) union all: ������(������� �ߺ��� �־ ��� ���)
    3) minus: ������(���� �ۼ��� select�� ������� ����)
    4) intersect: ������(���� �ۼ��� select ������� �ι�° select�� �����͸� ���)
*/
select empno, ename,deptno from emp where deptno=10
UNION
select empno, ename,deptno from emp where deptno=20 
order by deptno asc;

/*�Ʒ� �ΰ� select���� deptno=10 ���� ������ ���̺��� �����ϰ� ����.
    UNION �� ��� ������ ����� �ι� ��µ��� �ʰ� (���3�� ����)
    UNION ALL �� ���� �׳� �׷��� �Ű� �Ⱦ��� �� ���´�.(��� 6�� ����)
*/
select ename, job, sal, comm from emp where deptno=10
UNION
select ename, job, sal, comm from emp where deptno=10;

select ename, job, sal, comm from emp where deptno=10
UNION ALL
select ename, job, sal, comm from emp where deptno=10;

/* minus - ù��° select ������� �ι�°select(deptno=10) �� ����� ����  */
select ename, job, sal, comm, deptno from emp
MINUS
select ename, job, sal, comm, deptno from emp where deptno=10;


/* intersect- ������, ù��° select ������� �ι�°select(deptno=10)�� ����� ��ġ�°Ÿ� ��� */
select ename, job, sal, comm, deptno from emp
INTERSECT
select ename, job, sal, comm, deptno from emp where deptno=10;

/**********************************************/
/*****************  �������� *******************/
/**********************************************/
-- 1. emp���̺��� ename�� S�� ������ ��� ������ ��� ���
select * from emp where ename like '%S'; 
-- 2. deptno�� 30�� ����߿� job�� SALESMAN�� ����� �����ȣ,�̸�,��å,�޿�,�μ���ȣ ���
select empno,ename,job,sal,deptno from emp where deptno=30 and job='SALESMAN';
-- 3. �μ���ȣ 20,30�� �μ��� �޿��� 2000 �̻��� ����� ���� �޿������� ���
select * from emp where (deptno=20 or deptno=30) and sal>=2000;
-- 4. 30�� �μ��� �޿��� 1000~2000 ���̰� �ƴ� �������� ���
select * from emp where deptno=30 and not(sal>=1000 and sal <=2000);
select * from emp where deptno=30 and (sal<1000 or sal >2000);
/**********************************************/

/* �Լ� */
/* �����Լ�
    upper: ��� �빮��
    lower: ��� �ҹ���
    initcap: �� �ܾ��� ù���ڵ鸸 �빮��
    length: ���ڿ� ����
    count: row����
    substr: ���ڿ��ڸ��� ex)substr(job, 3,2) => job���� ����° ���ں��� 2�� �߶����
    concat: ���ڿ���ġ�� ex)select concat(empno, ename) from emp;
*/ 
select lower(job), initcap(job) from emp;
select * from emp where ename=upper('allen');
select ename, length(ename) from emp;
select count(*) from emp;
select job, substr(job, 3,2) from emp;
select concat(empno, ename) from emp;
/* �����Լ� 
    round: �ݿø�
    ceil: �ø�
    floor: ����
    trunc: Ư�� ��ġ ���� ����(�Ҽ���, �����κ� �� ����)
            trunc(��, �ڸ���) => �ڸ���: ����� '�Ҽ��� ���ڸ�' �� �ǹ�
                                        ������ �����ڸ��� ������ �ʰ� 0���θ� �ٲ�
                                    ex) trunc(123.4567, 2) => 123.45
                                        trunc(123.4567, -1) => 120
    mod: %������. ex) mod(����, �и�)  
                     mod(�������� ��, ������ ��)  
                     mod(10, 3) => 10 % 3 => 1
    
*/ 
select round(123.4567),ceil(123.4567),floor(123.4567), mod(10, 3) from dual;
select trunc(123.4567), trunc(123.4567, 2), trunc(123.4567, -1) from dual;
 

/* ��¥�Լ� 
    sysdate - ��,�� �ٲ� �˾Ƽ� �� ����
    ��¥���� ������: �޴��� > ���� > ȯ�漳�� > ������ ���̽� > NLS ���� ���� ����
*/
select sysdate as ���� from dual;

-- ��¥ ���ϱ� ����
select sysdate as ����, (sysdate+5) as ������ from dual;
-- �� ���ϱ� ���� (add_months)
select sysdate as ����, add_months(sysdate, -3) as ������ from dual;
-- �� ��¥ ���� ����(��) (months_between)
select sysdate as ����, trunc(months_between(sysdate, add_months(sysdate, 3))) as ��¥���� from dual;

-- ���� ����
/* - ����ȯ
    TO_CHAR: Date���� ���������� ��ȯ
    TO_DATE: �������� Date������ ��ȯ
    TO_NUMBER
*/
select TO_DATE(sysdate, 'yyyy-mm-dd') from emp; -- TO_DATE������ ����ȯ �ǹ� ����. �޴��� > ���� ���� �����Ұ�
select TO_CHAR(sysdate, 'yyyy-mm-dd') from emp; 

select TO_CHAR(hiredate, 'yyyy-mm-dd') as �����, TO_CHAR(sysdate) as ����, (TO_DATE(hiredate) - TO_DATE(sysdate)) as ��¥���� from emp;
select TO_CHAR(hiredate, 'yyyy-mm-dd') as �����, TO_CHAR(sysdate) as ����, (abs(TO_DATE(sysdate, 'yyyy-mm-dd')-TO_DATE(hiredate, 'yyyy-mm-dd'))) as ��¥���� from emp;
 
-- �ټӳ�� ���ϱ�
select 
    TO_CHAR(hiredate, 'yyyy-mm-dd') as �����, 
    TO_CHAR(sysdate) as ����, 
    ceil(trunc(abs(months_between(TO_DATE(sysdate), TO_DATE(hiredate)))) / 12) as �ټӳ��
from emp;

/*  ��¥ ���� */
select TO_CHAR(SYSDATE,'yyyymmdd') from dual;
select TO_CHAR(SYSDATE,'yyyy-mm-dd') from dual;
select TO_CHAR(SYSDATE,'yyyy') from dual;
select TO_CHAR(SYSDATE,'yy') from dual;
select TO_CHAR(SYSDATE,'mm') from dual; -- �� �⺻ ���� ���ڸ�
select TO_CHAR(SYSDATE,'mon') from dual; -- ���������� �� 
select TO_CHAR(SYSDATE,'day') from dual; -- ���������� ���� 
select TO_CHAR(SYSDATE,'dy') from dual; --  ���������� ����(���ڸ�)
select TO_CHAR(SYSDATE,'d') from dual; -- ����: 1(�Ͽ���)~7(�����)
select TO_CHAR(SYSDATE,'dd') from dual; -- ��¥
select TO_CHAR(SYSDATE,'ddd') from dual; -- ��¥(365���߿� ���° ������ ������)
select TO_CHAR(SYSDATE,'ww') from dual; -- 1�� (53��) �߿� ���° ������ ���
select TO_CHAR(SYSDATE,'w') from dual; -- �̹��� �߿� ���° ������ ���
select TO_CHAR(SYSDATE,'dl') from dual; -- ��¥�� �⺻ ���������� �Ǽ� ��� ex) 2023�� 9�� 27�� ������

-- �ð� ����
select TO_CHAR(SYSDATE,'am') from dual;
select TO_CHAR(SYSDATE,'pm') from dual;
select TO_CHAR(SYSDATE,'hh') from dual; -- 12�ð���
select TO_CHAR(SYSDATE,'hh24') from dual; -- 24�ð���
select TO_CHAR(SYSDATE,'mi') from dual; -- ��(�⺻ ���ڸ���. 00~59)
select TO_CHAR(SYSDATE,'ss') from dual; -- ��(�⺻ ���ڸ���. 00~59)

/*********************************************************************************/
/*********************************************************************************/
/*
    = ���̺� ����(create��) =
        create table ���̺�� (
            ���̸�  ������Ÿ��  [�ɼ�];
        );
        - ������Ÿ��
            char(����): ������.
                  varchar2�� ������ �������� ����
            varchar2(����): ������
                            ���� byte�� �������� ����
                            �ִ� 4000byte ���� ����
            long: ������
                  �������� ������ ������
                  �ִ� 2G. 
                  ���̺�� �ϳ��� �÷��� ���� ����
                  
            number(����): ���ڸ�ŭ�� �������� ������
                          �ִ� 38�ڸ����� ����
            number(����,����): �����ڸ� ��ŭ�� �������� �Ǽ���
            number(7,2): 7�ڸ� �������� ������ 2�ڸ� �������� �Ҽ��� 
            
            date: ��¥
            
        - �ڸ�Ʈ            
           ����: ���̺��� ���-> comment on table ���̺�� is '����';
                 �÷��� ��� ->  comment on column ���̺��.�÷��� is '����';
           ����: comment on table ���̺�� is '������ ��'
                comment on column ���̺��.�÷��� is '������ ��'
           ����: comment on table ���̺�� is ''
                comment on column ���̺��.�÷��� is ''
                
        - ���̺� ������ �ڸ�Ʈ ���� �ۼ�
            create table ���̺�� (
                ���̸�  ������Ÿ��  [�ɼ�] [Comment '����'];
            );
            
    == �������� == 
        constraint ����
            1) unique: �ش� �÷��� �ߺ��Ǵ� ������ ����
            2) NOT NULL: �ش� �÷��� ������ ������ �� �־�� �Ѵ�.
                         (�ִ��� null���� ���� ���̺�� ���� �ϴ°� ��õ)
            3) primary key(�⺻Ű) : unique�� not null�� ���ԵǾ� ����.
            4) foreign key(�ܷ�Ű) : �ٸ� ���̺��� �⺻Ű ���� �����ؼ� ���� ���̺� ������ ���°�(����Ȱ�)
            
        
        �������: �� ���̺� �ش� �÷��� � ������ �������ϴ��� �����ϰ�,
                 �ش� ������ �������� �ʴ� ������ ���ö� ������ ��Ÿ���ش�.
                 (�Ѹ���� �߸��� ������ ���� �ʰ� ��������� �ɾ��ֱ� ����)
        
        select * from user_constraints; -- ������ �����ϰ� �ִ� �������� �˻�
        select * from user_cons_columns; -- �÷����� ������ �������� �˻�
        
    == �������� ����, �߰�, ����, ���� ==
        �߰�: alter table ���̺��̸� add constraint ���������̸� ��������(�÷���);
        ����: alter table ���̺��̸� MODIFY �÷��� ��������;
        �̸�����: alter table ���̺��̸� rename constraint �̸� to ���̸�;
        ����: alter table ���̺��̸� drop constraint �������Ǹ�;
*/
    drop table classes; -- Ŭ���� ����

    -- �������� pk ���� ���鶧
    create table classes (
        cno number(4) constraint classesPK_con primary key,
        cname varchar2(255) not null 
    );
    
    -- �������� ���� ���鶧
    create table classes (
        cno number(4),
        cname varchar2(255) 
    );
    -- �������� �߰�
    -- alter table ���̺��̸� add constraint �������Ǹ� ��������(�÷���);
    alter table classes add constraint classes_PK_con primary key(cno);
    alter table classes add constraint classes_UNI_cname UNIQUE(cname);
    
    -- �������� ����
    -- alter table ���̺��̸� MODIFY �÷��� ��������;
    alter table classes MODIFY cname NOT NULL;
    alter table classes MODIFY cname NULL;
    select * from user_cons_columns; -- ������ ������ �ִ� �÷����� �������� �˻�
    
    -- �������� �̸�����
    -- alter table ���̺��̸� rename constraint �̸� to ���̸�;
    alter table classes rename CONSTRAINT classes_UNI_cname to classes_UQ_cname;
    alter table classes rename CONSTRAINT SYS_C007466 to classes_NN_cname; 
    
    -- �������� ����
    -- alter table ���̺��̸� drop constraint �������Ǹ�;
    alter table classes drop CONSTRAINT classes_UQ_cname;
    
    insert into classes values (1,'ȫ�浿'); 

--    -- �ڸ�Ʈ ����
--    comment on table classes is '������';
--    comment on column classes.cno is '��_������ȣ';
--    comment on column classes.cname is '��_�̸�';
--    
--    -- �ڸ�Ʈ Ȯ��
--    select * from user_tab_comments;
--    select * from user_col_comments;

    desc classes;

    drop table classes;
    
/* Ŭ������ ���� ���� 
    insert into ���̺�� values (�÷�1��, �÷�2��,....); 
    insert into ���̺�� (�÷���1, �÷���2,...) values (�÷�1��, �÷�2��,....); 
*/
    
    
/**********************************************/
/*
����: ��Ʈ���͵� �п� ���� db�� �����غ���
    �ʿ��� ���̺� - �л�, ����, ����
        �л� - �л��ڵ�(PK),�̸�,����ó(N),�����,�����ڵ�(FK),�����ڵ�(FK)
        ���� - �����ڵ�(PK),������,�Ⱓ,�ð�,������(N)
        ���� - �����ڵ�(pk),�����̸�,�����
*/     
    drop table classes;
    create table classes (
        c_seqno varchar2(10) constraint classesPK_c_seqno primary key,
        c_name varchar2(255) not null,
        c_startPeriod date not null,
        c_endPeriod date not null,
        c_roomNo varchar2(255) not null
    );
    insert into classes values ('C-001','�ڹ�', '2023-10-04', '2023-12-31', 'D������');
    insert into classes values ('C-002','C', '2023-10-04', '2023-12-31', '501������');
    insert into classes values ('C-003','���̼�', '2023-10-04', '2023-12-31', '302������');
    
    drop table teacher;
    create table teacher (
        t_seqno varchar2(10) constraint teacherPK_t_seqno primary key,
        t_name varchar2(255) not null,
        t_regDate date not null
    ); 
    insert into teacher values ('T-001', '����1', '2022-01-01');
    insert into teacher values ('T-002', '����2', '2022-01-01');
    insert into teacher values ('T-003', '����3', '2022-01-01');
    
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
    insert into student values ('S-001', '��', '010-1111-2222','2023-10-04','C-001','T-001');
    insert into student values ('S-002', '�л�2', '010-1111-2222','2023-10-04','C-001','T-001');
    insert into student values ('S-003', '�л�3', '010-1111-2222','2023-10-04','C-002','T-002');
    insert into student values ('S-004', '�л�4', '010-1111-2222','2023-10-04','C-001','T-001');
    insert into student values ('S-005', '�л�25', '010-1111-2222','2023-10-04','C-001','T-001');
    
--    insert into student (s_name, s_phone) values ('�л� 5', '010-1234-5678')
/* 
    = ����(update��) =
    update ���̺�� set �÷���=�� where �÷���=��;
    *����: where ������ �� �� �ٲ�
*/
    update student set s_name='��' where s_seqno='S-002';

/* = ����(delete��) =
    delete from ���̺��;
    delete from ���̺�� where �÷���=��;
*/
    delete from student where s_seqno='S-001';
    
/* == ����(alter) - ���̺� �Ӽ� ���� */
-- �÷� �߰� 
    alter table teacher add T_GEN varchar2(10);
    update teacher set T_GEN='Male';
    
-- �÷��� ����
    alter table teacher RENAME COLUMN T_GEN to T_GENDER;

-- �ڷ��� ����
    update teacher set T_GENDER =''; -- �ڷ��������� �Ϸ��� �ش� �÷��� ����־�� �Ѵ�.
    alter table teacher MODIFY T_GENDER number(1); 
    
-- �� ����
    alter table teacher drop column T_GENDER;

/************************************************/
/* ���̺� ���� - join 
    1) inner Ÿ��: null���̸� �ȳ���
                  equi join: ����Ŭ���� ���� ���� ���Ǵ� ���
        
    2) outer Ÿ��: null���̾ ����
                left outer join
                right outer join
    *���� inner join�̶� left join ���� ��(right�� �ϸ� null �ֵ��� ���ü��� ����)
*/

select s.s_seqno, s.s_name, c.*, t.t_name
    from student S join classes C 
        on C.c_seqno = s.c_seqno
            join teacher T 
                on s.t_seqno=t.t_seqno
            order by t.T_SEQNO;
        
/**********************************************/
-- ����1: emp ������ �߰��� �μ��� ���� ���� ���� ����ϱ�
select E.empno, e.ename, e.job, e.mgr, D.* 
    from emp E
        join dept D
            on E.deptno = D.deptno
            order by E.empno;
-- ���� �ڵ带 ���� �ٿ��� ����
select E.empno, e.ename, e.job, e.mgr, D.* 
    from emp E, dept D
        where E.deptno = D.deptno
        order by E.empno;
    
-- ����2: ���������� �Ŵ��� �̸� �߰�
-- MGR �� null �� ������ �����
select e.empno, e.ename, e.job, e.mgr, 
       em.empno, em.ename, em.job
    from emp e 
        join emp em
            on e.mgr = em.empno;
            
-- MGR �� null �� ������ ���    
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
/* �������� 
    -- �ְ� ������ �̱�
    select emp.ename, sal from emp 
        where sal = (select max(sal) 
                        from emp);
                        
    select, from, where ���� ��� ����.
    order by ���� ����� ���������� �� ���� �ʴ´�.
    (������ ������ �翡 ���� �ٸ����� �Ϲ������� ���������� ����� ���ϴ°� ����)
    
    1) select �� �������� (��Į�� ��������)
        �������� ����� �ϳ� �Ǵ� �����Լ��� ��ģ ���� ������ ���ϵǾ� �Ѵ�.
    2) from �� ��������  (�ζ��κ� ��������)
        �������� ����� �ϳ��� ���̺�� ���ϵǾ� �Ѵ�.
    *3) where �� ��������  (Nested ��������)
        ������, ������ �� ������� ���� �����ϴ�
        
*/
--empno�� 7499�� ����� ������ ������ ������ ���� ���
select * from emp where job=(select job from emp 
                            where EMPNO=7499);
                            
-- empno�� 7654�� ����� job�� �����ϰ� sal�� ���� ����� ���� �� ���
select*from emp 
where job=(select job from emp where EMPNO=7654)
    and sal > (select sal from emp where EMPNO=7654);
    
--from������ ���� �������� ����
--��ü emp�߿� ���� ���� ������ ���� ���

select * from emp order by sal asc ;

select * from (select * from emp order by sal asc )where rownum=1;

--�μ��� ���� ���� ������ ���� ���
select deptno,min(sal) from emp group by deptno;
select el.empno, el.ename, el.sal, e2.* 
from emp el
    join (select deptno, min(sal) from emp group by depno) e2 
    on el.sal=e2.sal;
    
    --�޿��� ��� �ݾ׺��� ���� ��� ��� ���
    select ename,sal from emp
    where sal > (select avg(sal) from emp);

