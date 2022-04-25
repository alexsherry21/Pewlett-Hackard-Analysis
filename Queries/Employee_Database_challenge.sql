select e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
into retirement_titles
from employees as e
inner join titles as ti
	on (e.emp_no = ti.emp_no)
where (birth_date between '1952-01-01' and '1955-12-31')
order by emp_no;	
	
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, title DESC;

select count(title), title
into retiring_titles
from unique_titles
group by title
order by count(title) desc;

select distinct on (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
into mentorship_eligibility
from employees as e
	inner join dept_emp as de
		on (e.emp_no = de.emp_no)
	inner join titles as ti
		on (e.emp_no = ti.emp_no)
where (de.to_date = '9999-01-01')
and (e.birth_date between '1965-01-01' and '1965-12-31')
order by e.emp_no;

select count(title)
from unique_titles
where title in ('Senior Engineer', 'Senior Staff', 'Technique Leader', 'Manager')
;

select count(title)
from unique_titles
where title in ('Senior Engineer', 'Engineer', 'Assistant Engineer');

select count(title)
from unique_titles;

select count(title)
from mentorship_eligibility;

select title, count(title)
from mentorship_eligibility
group by title;

select count(title)
from mentorship_eligibility
where title in ('Senior Engineer', 'Engineer', 'Assistant Engineer');

select count(emp_no)
from titles
where to_date = '9999-01-01';
