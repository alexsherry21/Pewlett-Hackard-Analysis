-- creating tables for PH-EmployeeDB
create table departments(
	dept_no varchar(4) not null,
	dept_name varchar(40) not null,
	primary key(dept_no),
	unique(dept_name));
	
create table employees(
	emp_no int not null,
	birth_date date not null,
	first_name varchar not null,
	last_name varchar not null,
	gender varchar not null,
	hire_date date not null,
	primary key (emp_no));	

create table dept_emp(
	emp_no int not null,
	dept_no varchar not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key(emp_no, dept_no));
	
create table dept_manager(
	dept_no varchar not null,
	emp_no int not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key(emp_no, dept_no));	
	
create table salaries(
	emp_no int not null,
	salary int not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no),
	primary key(emp_no));
	
create table titles(
	emp_no int not null,
	title varchar not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no));
	
select * from departments;
drop table departments cascade;
drop table employees cascade;
drop table dept_emp cascade;
drop table dept_manager cascade;
drop table salaries cascade;
drop table titles cascade;

--retirement eligibility
select first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');


--number of employees retiring
select count(first_name)
from employees
where (birth_date between'1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');