USE class_db;
-- 1.	Create a column called salary_range from the employee table using case statement.
-- The salary_range will have three groups named – minimum salary, which is salary less than 60k.
-- Medium salary; which is salary b/w 60k and 90k. High salary, which is more than 90k.
SELECT * FROM employees;
SELECT e.first_name, e.last_name, e.gender, e.position, e.salary,
CASE WHEN salary < 60000 THEN 'minimum salary'
WHEN salary BETWEEN 60000 AND 90000 THEN 'medium salary'
WHEN salary > 90000 THEN 'high salary' END AS salary_range
FROM employees e JOIN department d ON e.dept_id = d.dept_id;

-- 2.	Add the newly created column to the employee table.
SET sql_safe_updates = 0;
ALTER TABLE employees ADD COLUMN salary_range VARCHAR (20);
UPDATE employees SET salary_range = 
CASE WHEN salary < 60000 THEN 'minimum salary'
WHEN salary BETWEEN 60000 AND 90000 THEN 'medium salary'
WHEN salary > 90000 THEN 'high salary' END;

-- 3.Find the first ten rows of the titanic dataset sorted by pclass in descending order
SELECT * FROM titanic;
SELECT * FROM titanic ORDER BY Pclass DESC LIMIT 10;

-- 4.Find the number of passengers in each class sorted by pclass in ascending order.

SELECT pclass, COUNT(*) AS NO_OF_Passenger FROM titanic
GROUP BY pclass ORDER BY pclass;
-- 5.Find the average fare paid by passengers in each class.

SELECT pclass, ROUND(AVG(fare),2) AS averagefare FROM titanic
group by pclass;

-- 6.Find the name of the passenger with the highest fare.
SELECT name FROM titanic WHERE fare = 
(SELECT MAX(fare) FROM titanic);
-- there three passengers with 512.3292 which is the highest fare

-- 7.Find the name of the passenger with the least age among people who did not survive.
SELECT name FROM titanic WHERE age =
(SELECT MIN(age) FROM titanic WHERE survived = 0);

-- 8.Find the number of passengers who paid more than the average fare.
SELECT COUNT(*) AS more_avg FROM titanic WHERE fare >
(SELECT AVG(fare) FROM titanic);

-- 9.Find the name, age and fare of the oldest passenger who didn’t survive
SELECT name, age, fare FROM titanic WHERE age =
(SELECT MAX(age) FROM titanic WHERE survived = 0);

-- 10.Find the name and age of the youngest male passenger survived in first class.
SELECT name, age FROM titanic WHERE age =
(SELECT MIN(age) FROM titanic WHERE sex = 'male' AND survived = 1 AND pclass = 3);

 -- 11.Select all passengers who travelled in a cabin that was not shared by other passengers, 
 -- their ‘Embarked’ is S and their age between 30 and 50.
 
 SELECT * FROM titanic WHERE Embarked ='S' AND age BETWEEN 30 AND 50 AND cabin NOT IN
 (SELECT cabin FROM titanic GROUP BY cabin HAVING COUNT(*)>1);