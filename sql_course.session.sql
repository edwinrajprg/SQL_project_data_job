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