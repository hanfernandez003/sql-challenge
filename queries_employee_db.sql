-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE department (
    dept_id TEXT   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    CONSTRAINT pk_department PRIMARY KEY (
        dept_id
     )
);

CREATE TABLE position_title (
    title_id TEXT   NOT NULL,
    title_name VARCHAR   NOT NULL,
    CONSTRAINT pk_position_title PRIMARY KEY (
        title_id
     )
);

CREATE TABLE employee (
    emp_id INTEGER   NOT NULL,
    title_id VARCHAR   NOT NULL,
    birth_date VARCHAR   NOT NULL,
    first_name VARCHAR   NOT NULL,
    last_name VARCHAR   NOT NULL,
    sex VARCHAR   NOT NULL,
    hire_date VARCHAR   NOT NULL,
    CONSTRAINT pk_employee PRIMARY KEY (
        emp_id
     )
);

CREATE TABLE dept_employee (
    emp_id INTEGER   NOT NULL,
    dept_id VARCHAR   NOT NULL
);

CREATE TABLE manager (
    dept_id TEXT   NOT NULL,
    emp_id INTEGER   NOT NULL,
    CONSTRAINT pk_manager PRIMARY KEY (
        emp_id
     )
);

CREATE TABLE salary (
    emp_id INTEGER   NOT NULL,
    salary_amount DECIMAL   NOT NULL,
    CONSTRAINT pk_salary PRIMARY KEY (
        emp_id
     )
);

ALTER TABLE employee ADD CONSTRAINT fk_employee_title_id FOREIGN KEY(title_id)
REFERENCES position_title (title_id);

ALTER TABLE dept_employee ADD CONSTRAINT fk_dept_employee_emp_id FOREIGN KEY(emp_id)
REFERENCES employee (emp_id);

ALTER TABLE dept_employee ADD CONSTRAINT fk_dept_employee_dept_id FOREIGN KEY(dept_id)
REFERENCES department (dept_id);

ALTER TABLE manager ADD CONSTRAINT fk_manager_dept_id FOREIGN KEY(dept_id)
REFERENCES department (dept_id);

ALTER TABLE manager ADD CONSTRAINT fk_manager_emp_id FOREIGN KEY(emp_id)
REFERENCES employee (emp_id);

ALTER TABLE salary ADD CONSTRAINT fk_salary_emp_id FOREIGN KEY(emp_id)
REFERENCES employee (emp_id);

--QUERIES to answer questions from Homework

--1.List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT e.emp_id AS "Employee Number", e.last_name, e.first_name, e.sex, s.salary_amount
FROM employee AS e
LEFT JOIN salary AS s 
ON e.emp_id = s.emp_id
ORDER BY e.emp_id ASC
	
	 
--2.List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, 
TO_DATE(hire_date,'MM/DD/YYYY') AS "Hire Date"
FROM employee
WHERE extract( year FROM TO_DATE(hire_date,'MM/DD/YYYY')) = 1986
 

--3.List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT d.dept_id, d.dept_name, m.emp_id, e.last_name, e.first_name
FROM department AS d
LEFT JOIN manager AS m 
ON d.dept_id = m.dept_id
LEFT JOIN employee AS e 
ON m.emp_id = e.emp_id
ORDER BY d.dept_id ASC


--4.List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT e.emp_id AS "Employee Number", e.last_name, e.first_name, d.dept_name
FROM employee AS e
LEFT JOIN dept_employee AS de
ON e.emp_id = de.emp_id
LEFT JOIN department AS d
ON de.dept_id = d.dept_id
ORDER BY e.emp_id ASC

--5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employee
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'


--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT e.emp_id AS "Employee Number", e.last_name, e.first_name, d.dept_name AS "Department Name"
FROM employee AS e
LEFT JOIN dept_employee AS de
ON e.emp_id = de.emp_id
LEFT JOIN department AS d
ON de.dept_id = d.dept_id
WHERE d.dept_name = 'Sales'


--7.List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_id AS "Employee Number", e.last_name, e.first_name, d.dept_name AS "Department Name"
FROM employee AS e
LEFT JOIN dept_employee AS de
ON e.emp_id = de.emp_id
LEFT JOIN department AS d
ON de.dept_id = d.dept_id
WHERE d.dept_name IN ('Sales','Development')

--8.In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, 
COUNT(last_name) AS "Number of Employees with this Last Name"
FROM employee
GROUP BY last_name
ORDER BY "Number of Employees with this Last Name" DESC
