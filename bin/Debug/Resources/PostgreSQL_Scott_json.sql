START TRANSACTION;

CREATE TABLE public.dept (
    deptno SMALLINT NOT NULL,
    dname VARCHAR(14),
    loc VARCHAR(13)
);

CREATE TABLE public.dept1 (
    deptno SMALLINT,
    dname VARCHAR(14),
    loc VARCHAR(13)
);

CREATE TABLE public.dept_emp (
    dept jsonb NOT NULL
);

CREATE TABLE public.emp (
    empno SMALLINT NOT NULL,
    ename VARCHAR(10),
    job VARCHAR(9),
    mgr SMALLINT,
    hiredate DATE,
    sal NUMERIC(7,2),
    comm NUMERIC(7,2),
    deptno SMALLINT,
    CONSTRAINT chk_sal_emp CHECK ((sal > (0)::NUMERIC))
);

CREATE TABLE public.emp_dept (
    emp jsonb NOT NULL
);

CREATE TABLE public.salary (
    employee_id SMALLINT NOT NULL,
    sal NUMERIC(7,2)
);

INSERT INTO public.dept(deptno, dname, loc) VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO public.dept(deptno, dname, loc) VALUES (100, 'ADVERT', 'RIGA');
INSERT INTO public.dept(deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO public.dept(deptno, dname, loc) VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO public.dept(deptno, dname, loc) VALUES (110, 'Management', NULL);
INSERT INTO public.dept(deptno, dname, loc) VALUES (30, 'SALES', 'CHICAGO');

INSERT INTO public.dept1(deptno, dname, loc) VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO public.dept1(deptno, dname, loc) VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO public.dept1(deptno, dname, loc) VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO public.dept1(deptno, dname, loc) VALUES (110, 'Management', 'TALLINN');
INSERT INTO public.dept1(deptno, dname, loc) VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO public.dept1(deptno, dname, loc) VALUES (100, 'Advert', NULL);

INSERT INTO public.dept_emp(dept) VALUES ('{"loc": "NEW YORK", "dname": "ACCOUNTING", "deptno": 10, "employees": [{"job": "MANAGER", "mgr": 7839, "sal": 2450.00, "comm": null, "empno": 7782, "ename": "CLARK", "hiredate": "1981-06-09"}, {"job": "PRESIDENT", "mgr": null, "sal": 5000.00, "comm": null, "empno": 7839, "ename": "KING", "hiredate": "1981-11-17"}, {"job": "CLERK", "mgr": 7782, "sal": 1300.00, "comm": null, "empno": 7934, "ename": "MILLER", "hiredate": "1982-01-23"}]}');
INSERT INTO public.dept_emp(dept) VALUES ('{"loc": "DALLAS", "dname": "RESEARCH", "deptno": 20, "employees": [{"job": "MANAGER", "mgr": 7839, "sal": 2975.00, "comm": null, "empno": 7566, "ename": "JONES", "hiredate": "1981-04-02"}, {"job": "ANALYST", "mgr": 7566, "sal": 3000.00, "comm": null, "empno": 7788, "ename": "SCOTT", "hiredate": "1982-12-09"}, {"job": "CLERK", "mgr": 7788, "sal": 1100.00, "comm": null, "empno": 7876, "ename": "ADAMS", "hiredate": "1984-01-12"}, {"job": "ANALYST", "mgr": 7566, "sal": 3000.00, "comm": null, "empno": 7902, "ename": "FORD", "hiredate": "1981-12-03"}, {"job": "CLERK", "mgr": 7902, "sal": 900.00, "comm": null, "empno": 7369, "ename": "SMITH", "hiredate": "1980-12-17"}]}');
INSERT INTO public.dept_emp(dept) VALUES ('{"loc": "CHICAGO", "dname": "SALES", "deptno": 30, "employees": [{"job": "SALESMAN", "mgr": 7698, "sal": 1600.00, "comm": 300.00, "empno": 7499, "ename": "ALLEN", "hiredate": "1981-02-20"}, {"job": "SALESMAN", "mgr": 7698, "sal": 1250.00, "comm": 500.00, "empno": 7521, "ename": "WARD", "hiredate": "1981-02-22"}, {"job": "SALESMAN", "mgr": 7698, "sal": 1250.00, "comm": 1400.00, "empno": 7654, "ename": "MARTIN", "hiredate": "1981-09-28"}, {"job": "MANAGER", "mgr": 7839, "sal": 2850.00, "comm": null, "empno": 7698, "ename": "BLAKE", "hiredate": "1981-05-01"}, {"job": "SALESMAN", "mgr": 7698, "sal": 1500.00, "comm": 0.00, "empno": 7844, "ename": "TURNER", "hiredate": "1981-09-08"}, {"job": "CLERK", "mgr": 7698, "sal": 950.00, "comm": null, "empno": 7900, "ename": "JAMES", "hiredate": "1981-12-03"}]}');
INSERT INTO public.dept_emp(dept) VALUES ('{"loc": "TALLINN", "dname": "Management", "deptno": 110, "employees": []}');
INSERT INTO public.dept_emp(dept) VALUES ('{"loc": "BOSTON", "dname": "OPERATIONS", "deptno": 40, "employees": []}');
INSERT INTO public.dept_emp(dept) VALUES ('{"loc": null, "dname": "Advert", "deptno": 100, "employees": []}');

INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000.00, NULL, 20);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7876, 'ADAMS', 'CLERK', 7788, '1984-01-12', 1100.00, NULL, 20);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300.00, NULL, 10);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950.00, NULL, 30);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7944, 'BILL', 'SALESMAN', 7698, '1982-11-15', 1150.00, NULL, 30);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7989, 'JOHN', 'SMITH', 7698, '1982-10-20', 890.00, NULL, 20);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 900.00, NULL, 20);
INSERT INTO public.emp(empno, ename, job, mgr, hiredate, sal, comm, deptno) VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10);

INSERT INTO public.emp_dept(emp) VALUES ('{"job": "SALESMAN", "loc": "CHICAGO", "mgr": 7698, "sal": 1600.00, "comm": 300.00, "dname": "SALES", "empno": 7499, "ename": "ALLEN", "deptno": 30, "hiredate": "1981-02-20"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "SALESMAN", "loc": "CHICAGO", "mgr": 7698, "sal": 1250.00, "comm": 500.00, "dname": "SALES", "empno": 7521, "ename": "WARD", "deptno": 30, "hiredate": "1981-02-22"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "MANAGER", "loc": "DALLAS", "mgr": 7839, "sal": 2975.00, "comm": null, "dname": "RESEARCH", "empno": 7566, "ename": "JONES", "deptno": 20, "hiredate": "1981-04-02"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "SALESMAN", "loc": "CHICAGO", "mgr": 7698, "sal": 1250.00, "comm": 1400.00, "dname": "SALES", "empno": 7654, "ename": "MARTIN", "deptno": 30, "hiredate": "1981-09-28"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "MANAGER", "loc": "CHICAGO", "mgr": 7839, "sal": 2850.00, "comm": null, "dname": "SALES", "empno": 7698, "ename": "BLAKE", "deptno": 30, "hiredate": "1981-05-01"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "MANAGER", "loc": "NEW YORK", "mgr": 7839, "sal": 2450.00, "comm": null, "dname": "ACCOUNTING", "empno": 7782, "ename": "CLARK", "deptno": 10, "hiredate": "1981-06-09"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "ANALYST", "loc": "DALLAS", "mgr": 7566, "sal": 3000.00, "comm": null, "dname": "RESEARCH", "empno": 7788, "ename": "SCOTT", "deptno": 20, "hiredate": "1982-12-09"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "PRESIDENT", "loc": "NEW YORK", "mgr": null, "sal": 5000.00, "comm": null, "dname": "ACCOUNTING", "empno": 7839, "ename": "KING", "deptno": 10, "hiredate": "1981-11-17"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "SALESMAN", "loc": "CHICAGO", "mgr": 7698, "sal": 1500.00, "comm": 0.00, "dname": "SALES", "empno": 7844, "ename": "TURNER", "deptno": 30, "hiredate": "1981-09-08"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "CLERK", "loc": "DALLAS", "mgr": 7788, "sal": 1100.00, "comm": null, "dname": "RESEARCH", "empno": 7876, "ename": "ADAMS", "deptno": 20, "hiredate": "1984-01-12"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "ANALYST", "loc": "DALLAS", "mgr": 7566, "sal": 3000.00, "comm": null, "dname": "RESEARCH", "empno": 7902, "ename": "FORD", "deptno": 20, "hiredate": "1981-12-03"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "CLERK", "loc": "NEW YORK", "mgr": 7782, "sal": 1300.00, "comm": null, "dname": "ACCOUNTING", "empno": 7934, "ename": "MILLER", "deptno": 10, "hiredate": "1982-01-23"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "CLERK", "loc": "DALLAS", "mgr": 7902, "sal": 900.00, "comm": null, "dname": "RESEARCH", "empno": 7369, "ename": "SMITH", "deptno": 20, "hiredate": "1980-12-17"}');
INSERT INTO public.emp_dept(emp) VALUES ('{"job": "CLERK", "loc": "CHICAGO", "mgr": 7698, "sal": 950.00, "comm": null, "dname": "SALES", "empno": 7900, "ename": "JAMES", "deptno": 30, "hiredate": "1981-12-03"}');

INSERT INTO public.salary(employee_id, sal) VALUES (7566, 10000.00);

ALTER TABLE ONLY public.dept
    ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);

ALTER TABLE ONLY public.dept_emp
    ADD CONSTRAINT pk_dept_emp PRIMARY KEY (dept);

ALTER TABLE ONLY public.emp
    ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

ALTER TABLE ONLY public.emp_dept
    ADD CONSTRAINT pk_emp_dept PRIMARY KEY (emp);

ALTER TABLE ONLY public.salary
    ADD CONSTRAINT salary_pkey PRIMARY KEY (employee_id);

CREATE INDEX fk_emp_dept_idx ON public.emp USING btree (deptno);

CREATE INDEX fk_emp_mgr_idx ON public.emp USING btree (mgr);

ALTER TABLE ONLY public.emp
    ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES public.dept(deptno);

ALTER TABLE ONLY public.emp
    ADD CONSTRAINT fk_emp_mgr FOREIGN KEY (mgr) REFERENCES public.emp(empno);
    
COMMIT;