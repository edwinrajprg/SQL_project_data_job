
WITH skill_demand AS(
SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(*) as demand_count
 FROM   job_postings_fact j
 INNER JOIN skills_job_dim s on j.job_id = s.job_id
 INNER JOIN skills_dim on s.skill_id = skills_dim.skill_id
 WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg is NOT NULL
 GROUP BY   skills_dim.skill_id
), average_salary as
(SELECT skills_dim.skills,
        skills_dim.skill_id,
    COUNT(*) as skill_count,
    round(AVG(salary_year_avg),2) as avg_salary
FROM job_postings_fact j1
INNER JOIN skills_job_dim s1 on j1.job_id = s1.job_id
INNER JOIN skills_dim on s1.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
         AND salary_year_avg is NOT NULL
         AND job_location = 'Anywhere'
GROUP BY skills_dim.skill_id)

SELECT 
    skill_demand.skill_id,
    skill_demand.skills,
    demand_count,
    average_salary.avg_salary
FROM skill_demand
INNER JOIN average_salary on skill_demand.skill_id = average_salary.skill_id
WHERE demand_count >10
ORDER BY  
average_salary.avg_salary DESC,
demand_count DESC
LIMIT 25;


SELECT  ss.skill_id,
        ss.skills,
        COUNT(j.job_id) as demand_count,
        ROUND(AVG(salary_year_avg),2) as avg_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim s on j.job_id = s.job_id
INNER JOIN skills_dim ss on s.skill_id = ss.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere' 
GROUP BY ss.skill_id
HAVING COUNT(j.job_id) > 10
ORDER BY  
    avg_salary DESC,
    demand_count DESC
LIMIT 25

