-- create table dataa
-- (customer_id text,
-- name text,
-- age text,
-- email text,
-- city text,
-- signup_date	text,
-- salary int
-- );



select * from dataa;


--inspect data

select count(*) from dataa;

select * from dataa limit 10;

--inspect table structure

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'dataa';


-- missing values

select * from dataa;

select
	count(*)- count(customer_id) as missing_customer_id,
	count(*)- count(name) as missing_name,
	count(*)- count(age) as missing_age,
	count(*)- count(email) as missing_email,
	count(*)- count(city) as missing_city,
	count(*)- count(signup_date) as missing_signup_date,
	count(*)- count(salary) as missing_salary
from dataa;


-- identify missing data

select * from dataa
where age::int<0 or age::int>=100;

--change all the outlier to null
begin;

update dataa
set age = null
where age:: int <0 or age::int >100;

commit;

--change all the null values using mean

update dataa
set age = round((select avg(age::int) from dataa where age is not null))
where age is null;

select age from dataa
where age is null;


-- for missing salary
UPDATE dataa
SET salary = (
    SELECT AVG(salary)
    FROM dataa
    WHERE salary IS NOT NULL
)
WHERE salary IS NULL;

--for missing names

UPDATE dataa
SET name = 'Unknown'
WHERE name IS NULL;


-- find duplicates

select * from dataa;

with cte as(
select * ,row_number()over(partition by customer_id,email) as rn
from dataa
)
select * from cte 
where rn>1;

--removing duplicates
WITH cte AS (
    SELECT ctid,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY signup_date DESC) AS rn
    FROM dataa
)
DELETE FROM dataa
WHERE ctid IN (
    SELECT ctid FROM cte WHERE rn > 1
);


--using ctid because there is no unique identifyer rows i.e no primary key so we use ctid

--remove spaces
update dataa
set name = trim(name);

update dataa
set email = trim(email);

update dataa
set city = trim(city);

--standardize text

update dataa
set name = initcap(name);

update dataa
set city = initcap(city);

--change data types
select * from dataa;

alter table dataa
alter column customer_id type integer using customer_id::integer;


alter table dataa
alter column age type integer using age :: integer;

alter table dataa
alter column salary type numeric using salary :: numeric;

alter table dataa
alter column signup_date type date using signup_date :: date;

--for email validation

select * from dataa
where email not like '%@%.%';

SELECT *
FROM dataa
WHERE email LIKE '%gmail.com'
AND email NOT LIKE '%@%';


--update @ where missing

UPDATE dataa
SET email = REPLACE(email, 'gmail.com', '@gmail.com')
WHERE email LIKE '%gmail.com'
AND email NOT LIKE '%@%';


select * from dataa
where email not like '%@%';

-- change all the email 

update dataa
set email = null
where email like 'invalid_email';


-- checking if there is no future entry

SELECT * 
FROM dataa
WHERE signup_date > CURRENT_DATE;


select * from dataa






