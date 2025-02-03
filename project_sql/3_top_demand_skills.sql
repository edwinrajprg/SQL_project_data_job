SELECT 
        ss.skills,
        COUNT(*) as demand
 FROM   job_postings_fact j
 INNER JOIN skills_job_dim s on j.job_id = s.job_id
 INNER JOIN skills_dim ss on ss.skill_id = s.skill_id
 WHERE job_title_short = 'Data Analyst'
 GROUP BY   skills
 ORDER BY   demand DESC
 LIMIT 5;

    