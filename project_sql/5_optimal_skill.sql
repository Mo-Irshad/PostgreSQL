WITH skills_demand AS(
    SELECT 
        sd.skill_id,
        skills,
        COUNT(skills) AS demand
    FROM 
        skills_dim sd
    INNER JOIN
        skills_job_dim sj ON sd.skill_id= sj.skill_id
    INNER JOIN
        job_postings_fact jf ON sj.job_id=jf.job_id
    WHERE
        jf.job_title_short = 'Data Analyst' AND
        salary_year_avg is NOT NULL AND
        jf.job_work_from_home = True
    GROUP BY
        sd.skill_id
), average_salary AS(
    SELECT 
        sd.skill_id,
        skills,
        ROUND(AVG(salary_year_avg),2) AS Salary_avg
    FROM 
        skills_dim sd
    INNER JOIN
        skills_job_dim sj ON sd.skill_id= sj.skill_id
    INNER JOIN
        job_postings_fact jf ON sj.job_id=jf.job_id
    WHERE
        jf.job_title_short = 'Data Analyst' AND
        salary_year_avg is NOT NULL AND
        jf.job_work_from_home = True
    GROUP BY
        sd.skill_id
)
SELECT 
    skd.skill_id,
    skd.skills,
    demand,
    Salary_avg 
FROM 
    skills_demand skd
INNER JOIN average_salary ON skd.skill_id= average_salary.skill_id
ORDER BY Salary_avg DESC
LIMIT 5;
