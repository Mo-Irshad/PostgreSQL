SELECT 
    skills,
    job_title_short,
    COUNT(skills) AS demand
FROM 
    skills_dim sd
INNER JOIN
    skills_job_dim sj ON sd.skill_id= sj.skill_id
INNER JOIN
    job_postings_fact jf ON sj.job_id=jf.job_id
WHERE
    jf.job_title_short = 'Data Analyst' AND
    jf.job_work_from_home = True
GROUP BY
   jf.job_title_short,
   sd.skills
ORDER BY demand DESC
LIMIT 5;
