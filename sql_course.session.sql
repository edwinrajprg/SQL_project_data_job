SELECT *
FROM job_postings_fact

SELECT *
FROM skills_job_dim


CREATE TABLE january_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE febuary_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_job AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT *
FROM january_job 
WHERE
salary_year_avg > 70000
ORDER BY salary_year_avg DESC

UNION

SELECT *
FROM febuary_job 
WHERE
salary_year_avg > 70000
ORDER BY salary_year_avg DESC

UNION

SELECT *
FROM march_job 
WHERE
salary_year_avg > 70000
ORDER BY salary_year_avg DESC

SELECT * FROM(
    SELECT * 
    FROM january_job
    UNION ALL
    SELECT *
    FROM febuary_job
    UNION ALL
    SELECT *
    FROM march_job
    )
WHERE
salary_year_avg > 70000 AND
job_title_short = 'Data Analyst'
ORDER BY salary_year_avg DESC


SELECT job_id,
    COUNT(*) AS job_count
FROM january_job
GROUP BY job_id
HAVING COUNT(*) > 1

INSERT INTO january_job1(SELECT * FROM job_postings_fact
WHERE job_id = 105)

SELECT * FROM january_job
WHERE job_id = 105

DELETE FROM january_job AS a
USING january_job AS b
WHERE a.job_id = b.job_id

SELECT ROW_NUMBER() OVER (ORDER BY job_id) AS row_no,
job_id FROM january_job AS q1 (DELETE FROM january_job
WHERE row_no NOT IN (
SELECT MIN(row_no)
FROM q1))


SELECT ROW_NUMBER() OVER (ORDER BY job_id) AS row_no,
job_id FROM january_job AS q1
DELETE FROM january_job
WHERE row_no NOT IN (
SELECT MIN(row_no)
FROM q1)


SELECT ROW_NUMBER() OVER (ORDER BY job_id) AS row_no,
job_id FROM january_job

INSERT INTO january_job (row_no) 
SELECT ROW_NUMBER() OVER (ORDER BY job_id) 
AS row_no FROM january_job

DROP TABLE january_job1

SELECT * FROM
january_job1

CREATE TABLE january_job1 AS
--INSERT INTO january_job1
--SELECT ROW_NUMBER() OVER (ORDER BY job_id), 
SELECT * FROM january_job

INSERT INTO january_job1 VALUES(
ROW_NUMBER() OVER (ORDER BY job_id), 
* FROM january_job)

ALTER TABLE january_job 
ADD ROW_NUMBER() OVER (ORDER BY job_id) AS row_no INT;

DELETE FROM january_job1
WHERE row_number NOT IN (
SELECT MAX(row_number) FROM january_job1)

DELETE FROM january_job1
WHERE row_number NOT IN (
 SELECT MAX(row_number)
 FROM january_job1
 GROUP BY job_id)

SELECT job_id,
COUNT(*) AS row_count
FROM january_job1
GROUP BY job_id
HAVING COUNT(*) > 1

select *, CTID
FROM january_job1
WHERE job_id = 105

DELETE FROM january_job1
WHERE CTID NOT IN(SELECT MIN(CTID) FROM january_job1
GROUP BY job_id, company_id
HAVING COUNT(*)> 1)

SELECT band,
    COUNT(*)
FROM(SELECT job_id,
    job_title_short,
    salary_year_avg,
    NTILE(5) OVER (ORDER BY salary_year_avg DESC) AS band
FROM febuary_job
WHERE salary_year_avg IS NOT NULL)
GROUP BY band
ORDER BY band 

select * from(
select j.*,
row_number () over w as rn,
rank () over w as rank,
dense_rank () over w as drank
from january_job j
Where salary_year_avg is NOT NULL
window w as(partition by job_title_short ORDER BY salary_year_avg desc))
where rank < 3

Select *,
max(salary_year_avg) over(partition by job_title_short) as Max_salary
from january_job
Where salary_year_avg is NOT NULL

select *,
max(salary_year_avg) over(partition by job_title_short) as high_salary,
nth_value(salary_year_avg, 2) over(partition by job_title_short order by salary_year_avg desc
    range between unbounded preceding and unbounded following) as second_high_salary
from january_job
Where salary_year_avg is NOT NULL