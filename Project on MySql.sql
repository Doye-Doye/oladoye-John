use class_db;
-- 1.	Create a column called salary_range from the employee table using case statement.
-- The salary_range will have three groups named – minimum salary, which is salary less than 60k.
-- Medium salary; which is salary b/w 60k and 90k. High salary, which is more than 90k.
select * from employees;
select e.first_name, e.last_name, e.gender, e.position, e.salary,
case when salary < 60000 then 'minimum salary'
when salary between 60000 and 90000 then 'medium salary'
when salary > 90000 then 'high salary' end as salary_range
from employees e join department d on e.dept_id = d.dept_id;

-- 2.	Add the newly created column to the employee table.
-- HINT: (Remove the ‘select’ and ‘from table’ statements).
set sql_safe_updates = 0;
alter table employees add column salary_range VARCHAR (20);
update employees set salary_range = 
case when salary < 60000 then 'minimum salary'
when salary between 60000 and 90000 then 'medium salary'
when salary > 90000 then 'high salary' end;

-- 3.Find the first ten rows of the titanic dataset sorted by pclass in descending order
select * from titanic;
select * from titanic order by Pclass desc limit 10; -- GOOD

-- 4.Find the number of passengers in each class sorted by pclass in ascending order.

SELECT PCLASS, COUNT(*) AS NO_OF_PASSENGERS FROM TITANIC
GROUP BY PCLASS ORDER BY PCLASS;
-- 5.Find the average fare paid by passengers in each class.

SELECT PCLASS, avg(FARE) AS AVERAGEFARE FROM titanic
group by PCLASS;
-- 6.Find the name of the passenger with the highest fare.
select name from titanic where fare = 
(select max(fare) from titanic);-- GOOD
-- there three passenger with 512.3292 whic is the highest fare

-- 7.Find the name of the passenger with the least age among people who did not survive.
select name from titanic where age =
(select min(age) from titanic where survived = 0);-- GOOD

-- 8.Find the number of passengers who paid more than the average fare.
select count(*) as more_avg from titanic where fare >
(select avg(fare) from titanic);-- GOOD

-- 9.Find the name, age and fare of the oldest passenger who didn’t survive
select name, age, fare from titanic where age =
(select max(age) from titanic where survived = 0);-- GOOD

-- 10.Find the name and age of the youngest male passenger survived in first class.
select name, age from titanic where age =
(select min(age) from titanic where sex = 'male' and survived = 1 and pclass = 3);

 -- 11.Select all passengers who travelled in a cabin that was not shared by other passengers, 
 -- their ‘Embarked’ is S and their age between 30 and 50.
 
 SELECT * FROM titanic WHERE Embarked ='S' and age between 30 and 50 and cabin NOT IN
 (SELECT CABIN FROM TITANIC GROUP BY CABIN HAVING COUNT(*)>1);