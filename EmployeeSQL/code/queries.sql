-- Q1 Data Analysis - List the employee number, last name, first name, sex, and salary of each employee
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex,
(SELECT salaries.salary FROM salaries WHERE employees.emp_no = salaries.emp_no)					
FROM employees;

-- Q2 Data Analysis - List the first name, last name, and hire date for the employees who were hired in 1986
SELECT employees.first_name, employees.last_name,  employees.hire_date,
FROM employees WHERE DATE_PART('year', employees.hire_date) = 1986;

-- Q3 Data Analysis - List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT departments.dept_no, departments.dept_name, employees.emp_title_id,
employees.last_name, employees.first_name
FROM dept_emp
LEFT JOIN employees ON employees.emp_no = dept_emp.emp_no
LEFT JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE employees.emp_title_id LIKE 'm%';

-- Q4 Data Analysis - List the department number for each employee along with that employee’s employee number, last name, first name, and department name
CREATE VIEW all_emp AS
(SELECT employees.emp_no, employees.emp_title_id, employees.birth_date,employees.last_name,
 employees.first_name,employees.sex, employees.hire_date,departments.dept_name,departments.dept_no 
 FROM dept_emp 
 LEFT JOIN employees ON employees.emp_no = dept_emp.emp_no 
 LEFT JOIN departments ON departments.dept_no = dept_emp.dept_no);

SELECT emp_no, last_name, first_name, dept_name FROM all_emp;

-- Q5 Data Analysis - List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B. 
SELECT employees.first_name, employees.last_name, employees.sex 
FROM employees
WHERE employees.first_name = 'Hercules' AND employees.last_name LIKE 'B%';

-- Q6 Data Analysis - List each employee in the Sales department, including their employee number, last name, and first name.
CREATE VIEW sales_dpt AS (SELECT emp_no, last_name, first_name, dept_name
FROM all_dept_emp);

SELECT * FROM sales_dpt WHERE dept_name = 'Sales';
-- we will use the view - 'sales_dpt' for the next question as well

-- Q7 Data Analysis - List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT * FROM sales_dpt WHERE dept_name IN ('Sales', 'Development');

-- Q8 Data Analysis - List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name)
SELECT employees.last_name, COUNT(employees.last_name) AS freq_count
FROM employees 
GROUP BY employees.last_name
ORDER BY freq_count DESC;