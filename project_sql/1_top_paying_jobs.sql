-- Identifiying top paying data analyst role remotely
SELECT 
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
LIMIT 10;