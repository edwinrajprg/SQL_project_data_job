SELECT ss.skills,
    COUNT(*) as skill_count,
    round(AVG(salary_year_avg)::numeric) as avg_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim s on j.job_id = s.job_id
INNER JOIN skills_dim ss on s.skill_id = ss.skill_id
WHERE job_title_short = 'Data Analyst' AND
        salary_year_avg is NOT NULL
GROUP BY ss.skills
ORDER BY avg_salary DESC