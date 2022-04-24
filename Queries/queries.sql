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
drop table retirement_info;
drop table current_emp;

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

--create a new table for retiring employees
select emp_no, first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');
--check table
select * from retirement_info;

--joining departments and dept_manager tables
select d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
from departments as d
inner join dept_manager as dm
on d.dept_no = dm.dept_no;

--joining retirement_info and dept_emp tables
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where de.to_date = ('9999-01-01');

select * from current_emp;

-- employee count by department number
select count(ce.emp_no), de.dept_no
into dept_count
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

select e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
into emp_info
from employees as e
inner join salaries as s
on (e.emp_no = s.emp_no)
inner join dept_emp as de
on (e.emp_no = de.emp_no)
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31')
and (de.to_date = '9999-01-01');

--list of managers per department
select dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
into manager_info
from dept_manager as dm
	inner join departments as d
		on (dm.dept_no = d.dept_no)
	inner join current_emp as ce
		on (dm.emp_no = ce.emp_no);
		
select ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
--into dept_info
from current_emp as ce
inner join dept_emp as de
on (ce.emp_no = de.emp_no)
inner join departments as d
on(de.dept_no = d.dept_no);

select ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
--into sales_emp
from current_emp as ce
inner join dept_emp as de
on (ce.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no)
where d.dept_no = 'd007';

select ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
--into sales_dev_emp
from current_emp as ce
inner join dept_emp as de
on (ce.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no)
where d.dept_name in ('Sales', 'Development');