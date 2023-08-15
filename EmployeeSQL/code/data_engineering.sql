-- Create tables based on available CSV datasets

CREATE TABLE titles(
	title_id VARCHAR(5) NOT NULL PRIMARY KEY,
	title VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE departments (
    dept_no VARCHAR(4) NOT NULL PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE employees (
    emp_no INT NOT NULL PRIMARY KEY,
    emp_title_id VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
	FOREIGN KEY(emp_title_id) REFERENCES titles (title_id),
	CONSTRAINT ck_sex CHECK (sex IN ('F', 'M'))
);

CREATE TABLE salaries (
    emp_no INT NOT NULL PRIMARY KEY,
    salary MONEY NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
	PRIMARY KEY (emp_no, dept_no)
);

-- Set columns in dept_emp table as foreign keys referencing respective tables
ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_employees FOREIGN KEY(emp_no)
REFERENCES employees (emp_no);
ALTER TABLE dept_emp ADD CONSTRAINT fk_dept_emp_departments FOREIGN KEY(dept_no)
REFERENCES departments (dept_no);

--Change date format to avoid date format errors
SET datestyle = mdy;

-- Import CSV Data into DATABASE
COPY titles(title_id, title)
FROM 'C:\Users\26dar\OneDrive\Desktop\Module 9 Challenge\sql-challenge\EmployeeSQL\data\titles.csv'
DELIMITER ','
CSV HEADER;

COPY departments(dept_no, dept_name)
FROM 'C:\Users\26dar\OneDrive\Desktop\Module 9 Challenge\sql-challenge\EmployeeSQL\data\departments.csv'
DELIMITER ','
CSV HEADER;

COPY employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date)
FROM 'C:\Users\26dar\OneDrive\Desktop\Module 9 Challenge\sql-challenge\EmployeeSQL\data\employees.csv'
DELIMITER ','
CSV HEADER;

COPY salaries(emp_no, salary)
FROM 'C:\Users\26dar\OneDrive\Desktop\Module 9 Challenge\sql-challenge\EmployeeSQL\data\salaries.csv'
DELIMITER ','
CSV HEADER;

COPY dept_emp(emp_no, dept_no)
FROM 'C:\Users\26dar\OneDrive\Desktop\Module 9 Challenge\sql-challenge\EmployeeSQL\data\dept_emp.csv'
DELIMITER ','
CSV HEADER;

-- 'SELECT' clause to check tables in database
SELECT * FROM titles;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM dept_emp;