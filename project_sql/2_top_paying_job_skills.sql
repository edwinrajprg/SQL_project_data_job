WITH top_paying_job AS(
    SELECT  job_id,
            c.company_id,
            job_title_short,
            salary_year_avg,
            name as company_name
    FROM    job_postings_fact j
    LEFT JOIN company_dim c on j.company_id = c.company_id
    WHERE
            job_title_short = 'Data Analyst' AND
            job_location = 'Anywhere' AND
            salary_year_avg is NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10)

SELECT *
FROM top_paying_job j
INNER JOIN skills_job_dim s ON j.job_id = s.job_id
INNER JOIN skills_dim ss ON ss.skill_id = s.skill_id
ORDER BY salary_year_avg DESC