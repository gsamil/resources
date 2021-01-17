
CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

-- Find all employees
SELECT * FROM employee;

-- Find all clients
SELECT * FROM client;

-- Find all employees ordered by salary
SELECT * FROM employee ORDER BY salary;
SELECT * FROM employee ORDER BY salary DESC;

-- Find all employees ordered by sex then name
SELECT * FROM employee ORDER BY sex, first_name, last_name;

 -- Find the first 5 employees in the table
 SELECT * FROM employee LIMIT 5;

-- Find the first and last names of all employees
SELECT employee.first_name, employee.last_name FROM employee;

-- Find the forname and surnames of all employees
SELECT first_name AS forname, last_name AS surname FROM employee;

-- Find out all the different genders
SELECT DISTINCT sex FROM employee;

# SQL functions

-- Find the number of employees
SELECT count(emp_id) FROM employee;

-- Find how many employees have superviser (NULL is not counted)
SELECT count(super_id) FROM employee;

-- Find the number of female employees born after 1970
SELECT count(emp_id) FROM employee WHERE sex = 'F' AND birth_day > '1970-01-01';

-- Find the average of all employees salaries
SELECT avg(salary) FROM employee;

-- Find the sum of all employees salaries
SELECT sum(salary) FROM employee;

-- Find out how many males and how many females there are (aggregation)
SELECT count(sex), sex FROM employee GROUP BY sex;

-- Find the total sales of each salesman
SELECT  emp_id, sum(total_sales) FROM works_with GROUP BY emp_id;

-- Find how much is spent on each client
SELECT  client_id, sum(total_sales) FROM works_with GROUP BY client_id;

# Wildcards

-- Find any client who are LLC
SELECT * FROM client WHERE client_name LIKE '%LLC';

-- Find any branch suppliers who are in the label business
SELECT * FROM branch_supplier WHERE supplier_name LIKE '% Label%';

-- Find any employee born in october
SELECT * FROM employee WHERE birth_day LIKE '____-10%';

# Unions

-- Find a list of employee and brach names
SELECT first_name AS new_list FROM employee UNION SELECT branch_name FROM branch;

# Joins

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

-- Find all branches and the names of their managers (inner join)
SELECT employee.emp_id, employee.first_name, branch.branch_name 
FROM employee 
JOIN branch 
ON employee.emp_id = branch.mgr_id;

-- Find all branches and the names of their managers (LEFT JOIN - include all rows from employee table )
SELECT employee.emp_id, employee.first_name, branch.branch_name 
FROM employee 
LEFT JOIN branch 
ON employee.emp_id = branch.mgr_id;

-- Find all branches and the names of their managers (RIGHT JOIN - include all rows from branch table )
SELECT employee.emp_id, employee.first_name, branch.branch_name 
FROM employee 
RIGHT JOIN branch 
ON employee.emp_id = branch.mgr_id;

-- FULL OUTER JOIN : include both tables

# nested queries

-- Find names OF ALL employees who have sold OVER 30k to a single client
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
	SELECT works_with.emp_id
	FROM works_with
	WHERE works_with.total_sales > 30000
);

-- Find all clients wha are handled by the branch that Michael Scott manages (assume you know Michael's ID)
SELECT client.client_name
FROM client
WHERE client.branch_id = (
	SELECT branch.branch_id
	FROM branch
	WHERE branch.mgr_id = 102
	LIMIT 1
);

# on delete

-- look at the branch table
DELETE FROM employee
WHERE emp_id = 102;

SELECT * FROM branch;

-- look at the branch_supplier table (branch_id is part of the primary key, cannot be NULL)

DELETE FROM branch
WHERE branch_id = 2;

SELECT * FROM branch_supplier;

# triggers

CREATE TABLE trigger_test (
	message varchar(100)
)

-- in sql command line :
-- >> use beaver

-- >> delimiter $$
-- >> CREATE
-- >> 	TRIGGER my_trigger BEFORE INSERT
-- >> 	ON employee
-- >> 	FOR EACH  ROW BEGIN 
-- >> 		INSERT INTO trigger_test values('add new employee');
-- >> 	END$$
-- >> delimiter ;

INSERT INTO employee VALUES(109, 'Oscar', 'Martinez', '1968-06-15', 'M', 60000, 106, 3);

-- >> delimiter $$
-- >> CREATE
-- >> 	TRIGGER my_trigger1 BEFORE INSERT
-- >> 	ON employee
-- >> 	FOR EACH  ROW BEGIN 
-- >> 		INSERT INTO trigger_test values(NEW.first_name);
-- >> 	END$$
-- >> delimiter ;

INSERT INTO employee VALUES(110, 'Kevin', 'Malone', '1958-06-15', 'M', 42000, 106, 3);

-- >> delimiter $$
-- >> CREATE
-- >> 	TRIGGER my_trigger2 BEFORE INSERT
-- >> 	ON employee
-- >> 	FOR EACH  ROW BEGIN 
-- >> 		IF NEW.sex = 'M' THEN
-- >> 			INSERT INTO trigger_test values('added male employee');
-- >> 		ELSEIF NEW.sex = 'F' THEN
-- >> 			INSERT INTO trigger_test values('added female employee');
-- >> 		ELSE
-- >> 			INSERT INTO trigger_test values('added other employee');
-- >> 		END IF;
-- >> 	END$$
-- >> delimiter ;

INSERT INTO employee VALUES(111, 'Pam', 'Beesly', '1958-06-15', 'F', 42000, 106, 3);

-- >> 	TRIGGER my_trigger2 BEFORE/AFTER INSERT/UPDATE/DELETE

SELECT * FROM trigger_test; 

-- >> 	DROP TRIGGER my_trigger
