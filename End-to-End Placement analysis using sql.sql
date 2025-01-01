use placement;
select * from package;
select * from percentage;

--1 What is the maximum package received by any student?
select MAX(salary) as max_salary from package ;
/* Insight: The maximum package of ₹50,000 can be a benchmark to assess placement performance compared to industry standards. 
If this is competitive, it reflects strong placement outcomes. 
This figure also serves as an aspirational target for students aiming for top-paying roles.*/

--2 List the distinct MBA specializations available in the database.
select distinct(specialisation) as Mba_specialisation from package ;
Insight:The MBA specializations offered, Marketing & Finance and Marketing & HR, provide students with clear options for career paths.
These choices can guide students towards fields with strong placement rates or higher packages.
Other specializations may offer unique opportunities with less competition

--3 How many students have an ssc percentage greater than 80?
select COUNT(*) as student_ssc_greater_80 from percentage where ssc_p >80;
/*Insight: This query counts the 17 students who achieved over 80% in their SSC exams, serving as a useful metric for academic strength analysis and student segmentation.
A higher count indicates a strong academic foundation, which may correlate with better placement outcomes, 
while students with high SSC scores are more likely to pursue high-salary roles or challenging specializations.*/

--4 What is the average hsc percentage for students based on placed status?
SELECT status,ROUND(AVG(hsc_p),2) as avg_hsc_placed
FROM package  
JOIN percentage 
ON package.Roll_No = percentage.Roll_No where status='Placed'  Group by status;
/*Insight: 
The average HSC percentage of placed students is 71.84, while the average for unplaced students is 57.328, highlighting the academic threshold linked to successful placements.
This insight can be used to set benchmarks for placement, suggesting that students with stronger academic backgrounds have a competitive advantage.
Additionally, it encourages students to maintain high HSC scores as part of their placement preparation.*/
Z
--5 what is the average degree percentage for students based on placement status?
SELECT status,round(AVG(degree_p),2) as degree_percentage
FROM package  
JOIN percentage 
ON package.Roll_No = percentage.Roll_No group by status;
/*The average degree percentage for placed students is 69.28, compared to 61.71 for unplaced students, offering insights into how academic performance influences placement status. 
This notable difference underscores the importance of academic consistency in securing placements.
Furthermore, if a clear trend is identified, it could indicate a minimum degree percentage target for students aiming for successful placements*/

--6 what is the average E-test percentage of placed vs. not placed students?
SELECT status,round(AVG(etest_p),2) as avg_etest_percentage
FROM package  
LEFT JOIN percentage 
ON package.Roll_No = percentage.Roll_No group by status;
/* 
This query analyzes the E-test performance of placed students, averaging 72.28, compared to unplaced students at 69.29, highlighting the correlation between aptitude test scores and placement success.
The significant difference suggests that strong aptitude skills play a crucial role in securing placements.
For unplaced students, this insight signals the need for targeted preparation to enhance their aptitude test scores.*/

--7 What is the distribution of packages received?
SELECT 
    specialisation,
    status,
    COUNT(*) AS package_count,
    CASE 
        WHEN status = 'Placed' THEN COUNT(*) * 100.0 / (SELECT SUM(salary) FROM package WHERE status = 'Placed')
        ELSE 0 
    END AS percentage
FROM package
GROUP BY specialisation, status;



;
/*This data shows a count of 69 placed students compared to 31 unplaced students, providing a clear quantification of placement success.
A high number of placed students reflects strong placement rates, while the larger count of unplaced students indicates areas where additional support may be necessary, such as interview skills or targeted training.
Additionally, tracking changes in this distribution over multiple terms or years can help identify trends, guiding focused placement strategies for specific segments with lower placement rates.*/


--- python questions---


--2 find out 3 fresher students who got maximum package
SELECT TOP 3(salary) as fresher_placed_package
FROM package  
LEFT JOIN percentage 
ON package.Roll_No = percentage.Roll_No where workex='false' order by salary desc;

--3 what is average percentage in etest of experienced students
SELECT avg(etest_p) as avg_experinced_place 
from percentage
where workex='True';
-- 4 Calculate the difference in mba and degree percentage of students
SELECT (mba_p - degree_p) as diff_of_mba_degree_p_students
FROM package  
LEFT JOIN percentage 
ON package.Roll_No = percentage.Roll_No ;
-- which degree specialization got maximum package in freshers?
SELECT TOP 1 (specialisation) as specilasation_degree_fresher
FROM package  
LEFT JOIN percentage 
ON package.Roll_No = percentage.Roll_No where workex='false' order by salary desc;


--3 what is the average percentage
SELECT TOP 3(salary) as avg_hsc_placed
FROM package  
LEFT JOIN percentage 
ON package.Roll_No = percentage.Roll_No where workex='false'
order by salary desc;

SELECT TOP 3 P.*, P1.*
FROM package P
JOIN percentage P1
ON P.Roll_No = P1.Roll_No
WHERE P1.workex = 'false'
ORDER BY P.salary DESC;

SELECT TOP 1 p.specialisation AS specilasation_degree_fresher, MAX(p.salary) AS max_salary
FROM package p
JOIN percentage p1
ON p.Roll_No = p1.Roll_No
WHERE p1.workex = 'false'
GROUP BY p.specialisation
ORDER BY max_salary DESC;


select specialisation,gender,
 max(salary) as Max_Salary,
 Min(Salary) as Min_Salary,
 avg(salary) as Avg_Salary
 from Package
 where status='Placed'
 group by specialisation,gender
 order by gender desc