CREATE DATABASE companydata_db;
USE companydata_db;

CREATE TABLE employee(
id INT PRIMARY KEY,
name VARCHAR(50),
department VARCHAR(50),
salary INT
);

INSERT INTO employee VALUES
(101,'Rohan','Marketing',42000),
(102,'Sneha','Development',55000),
(103,'Amit','Accounts',48000),
(104,'Pooja','Support',39000),
(105,'Karan','Sales',46000);

SELECT * FROM employee;

-------------------------------------------------

-- Q1: Create procedure to display all employees

DELIMITER //

CREATE PROCEDURE display_employee()

BEGIN

SELECT * FROM employee;

END //

DELIMITER ;

CALL display_employee();

-------------------------------------------------

-- Q2: Create procedure to display employee by ID

DELIMITER //

CREATE PROCEDURE employee_by_id(
IN emp_id INT
)

BEGIN

SELECT *
FROM employee
WHERE id = emp_id;

END //

DELIMITER ;

CALL employee_by_id(102);

-------------------------------------------------

-- Q3: Create procedure to count total employees

DELIMITER //

CREATE PROCEDURE total_employee()

BEGIN

SELECT COUNT(*) AS total_employees
FROM employee;

END //

DELIMITER ;

CALL total_employee();

-------------------------------------------------

-- Q4: Create procedure to display employee by department

DELIMITER //

CREATE PROCEDURE employee_department(
IN dept_name VARCHAR(50)
)

BEGIN

SELECT *
FROM employee
WHERE department = dept_name;

END //

DELIMITER ;

CALL employee_department('Development');

-------------------------------------------------

-- Q5: Create procedure to display employees
-- having salary greater than given amount

DELIMITER //

CREATE PROCEDURE salary_greater_than(
IN amount INT
)

BEGIN

SELECT *
FROM employee
WHERE salary > amount;

END //

DELIMITER ;

CALL salary_greater_than(45000);

-------------------------------------------------

-- Q6: Create procedure to insert new employee

DELIMITER //

CREATE PROCEDURE insert_employee(

IN emp_id INT,
IN emp_name VARCHAR(50),
IN emp_department VARCHAR(50),
IN emp_salary INT

)

BEGIN

INSERT INTO employee
VALUES(
emp_id,
emp_name,
emp_department,
emp_salary
);

END //

DELIMITER ;

CALL insert_employee(
106,
'Meera',
'HR',
50000
);

-------------------------------------------------

-- Q7: Create procedure to update salary

DELIMITER //

CREATE PROCEDURE update_salary(

IN emp_id INT,
IN new_salary INT

)

BEGIN

UPDATE employee
SET salary = new_salary
WHERE id = emp_id;

END //

DELIMITER ;

CALL update_salary(
101,
47000
);

-------------------------------------------------

-- Q8: Create procedure to delete employee

DELIMITER //

CREATE PROCEDURE delete_employee(
IN emp_id INT
)

BEGIN

DELETE FROM employee
WHERE id = emp_id;

END //

DELIMITER ;

CALL delete_employee(105);

-------------------------------------------------

-- Q9: Create procedure to find average salary

DELIMITER //

CREATE PROCEDURE average_salary()

BEGIN

SELECT AVG(salary) AS average_salary
FROM employee;

END //

DELIMITER ;

CALL average_salary();

-------------------------------------------------

-- Q10: Create procedure to display employee
-- having maximum salary

DELIMITER //

CREATE PROCEDURE max_salary_employee()

BEGIN

SELECT *
FROM employee
WHERE salary = (
SELECT MAX(salary)
FROM employee
);

END //

DELIMITER ;

CALL max_salary_employee();

-------------------------------------------------

SHOW PROCEDURE STATUS;
