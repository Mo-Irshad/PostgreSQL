-- Identifiying top paying data analyst role skills remotely
SELECT 
    jf.job_title_short,
    cd.name,
    sd.skills, 
    jf.job_location,
    jf.salary_year_avg
FROM 
    job_postings_fact jf
LEFT JOIN
    company_dim cd ON jf.company_id = cd.company_id
INNER JOIN
    skills_job_dim sj ON jf.job_id = sj.job_id
INNER JOIN
    skills_dim sd ON sj.skill_id = sd.skill_id 
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;

-- Same answer using CTEs

WITH top_paying_jobs AS(
    SELECT 
        job_id,
        jf.job_title_short,
        cd.name,
        jf.job_location,
        jf.salary_year_avg
    FROM 
        job_postings_fact jf
    LEFT JOIN
        company_dim cd ON jf.company_id = cd.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
)
SELECT 
    tj.job_title_short,
    tj.name,
    skills,
    tj.job_location,
    tj.salary_year_avg 
FROM 
    top_paying_jobs tj
INNER JOIN
    skills_job_dim sj ON tj.job_id = sj.job_id
INNER JOIN
    skills_dim sd ON sj.skill_id = sd.skill_id
LIMIT 10;