SELECT 
    skills,
    job_title_short,
    ROUND(AVG(salary_year_avg),2) AS Salary_avg
FROM 
    skills_dim sd
INNER JOIN
    skills_job_dim sj ON sd.skill_id= sj.skill_id
INNER JOIN
    job_postings_fact jf ON sj.job_id=jf.job_id
WHERE
    jf.job_title_short = 'Data Analyst' AND
    salary_year_avg is NOT NULL
GROUP BY
    skills,
    jf.job_title_short
ORDER BY Salary_avg DESC
LIMIT 5;
