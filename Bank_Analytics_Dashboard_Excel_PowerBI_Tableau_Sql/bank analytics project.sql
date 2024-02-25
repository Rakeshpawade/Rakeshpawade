use excelr;
select*from finance1;
select*from finance2;
----------------------------------------------------------------------------------------------------------------------------------
# KPI 1 Year wise loan amount Stats

SELECT 
    Year(issue_d) AS issue_years,
    SUM(loan_amnt) AS total_amount
FROM
    finance1
GROUP BY issue_years
ORDER BY total_amount DESC;
-----------------------------------------------------------------------------------------------------------------------------
# with All year total :- 

SELECT issue_years, SUM(total_amount) AS total_amount
FROM (
    SELECT Year(issue_d) AS issue_years, SUM(loan_amnt) AS total_amount
    FROM finance1
    GROUP BY issue_years
    UNION ALL
    SELECT 'All Years' AS issue_years, SUM(loan_amnt) AS total_amount
    FROM finance1
) combined
GROUP BY issue_years
ORDER BY issue_years;

-----------------------------------------------------------------------------------------------------------------------------

#KPI 2 Grade and sub grade wise revol_bal
Select f1.grade, f1.sub_grade, sum(f2.revol_bal) as revolving_bal
from finance1 as f1 inner join finance2 as f2
on f1.id = f2.id
group by f1.grade, f1.sub_grade
order by f1.grade;

----------------------------------------------------------------------------------------------------------------------------

#KPI 3 Total Payment for Verified Status Vs Total Payment for Non Verified Status

select f1.verification_status, sum(f2.total_pymnt) as total_payment
from finance1 as f1 inner join finance2 as f2
on f1.id = f2.id
group by f1.verification_status;

-----------------------------------------------------------------------------------------------------------------------------

## Specific with respect to Verified status and non verified status

SELECT
    f1.verification_status,
    SUM(f2.total_pymnt) AS total_payment
FROM
    finance1 AS f1
INNER JOIN
    finance2 AS f2
ON
    f1.id = f2.id
WHERE
    f1.verification_status = 'Verified'
    OR f1.verification_status = 'Not Verified'
GROUP BY
    f1.verification_status;
  
-----------------------------------------------------------------------------------------------------------------------------  
    
 # KPI 4 State wise and last_credit_pull_d wise loan status

SELECT
    f1.addr_state AS State,
    f2.last_credit_pull_d AS Last_Credit_Pull_D,
    f1.loan_status AS LoanStatus,
    COUNT(*) AS LoanCount
FROM
    finance1 AS f1
JOIN
    finance2 AS f2
ON
    f1.id = f2.id
GROUP BY
    f1.addr_state, f2.last_credit_pull_d, f1.loan_status
ORDER BY
    f1.addr_state, f2.last_credit_pull_d, f1.loan_status;
    
----------------------------------------------------------------------------------------------------------------------------
    
 # KPI 5 Home ownership Vs last payment date stats
select Year(issue_d) as payment_year, month(issue_d) as payment_month, f1.home_ownership, count(f1.home_ownership) as home_ownership
from finance1 as f1 inner join finance2 as f2
on f1.id = f2.id
WHERE home_ownership IN ('rent', 'mortgage', 'own')
group by payment_year,payment_month,home_ownership
order by payment_year,home_ownership desc;  

------------------------------------------------------------------------------------------------------------------------------

## year wise 
select Year(issue_d) payment_year, f1.home_ownership, count(f1.home_ownership) as home_ownership
from finance1 as f1 inner join finance2 as f2
on f1.id = f2.id
WHERE home_ownership IN ('rent', 'mortgage', 'own')
group by payment_year,f1.home_ownership
order by payment_year,home_ownership desc;

---------------------------------------------------------------------------------------------------------------------------

#### Last payment year vs homeownership

select year(f2.last_pymnt_d) last_payment_year, f1.home_ownership, count(f1.home_ownership) home_ownership
from finance1 as f1 inner join finance2 as f2
on f1.id = f2.id
WHERE f2.last_pymnt_d IS NOT NULL 
AND TRIM(f2.last_pymnt_d) <> '' AND
home_ownership IN ('rent', 'mortgage', 'own')
AND SUBSTRING(f2.last_pymnt_d, -4) IS NOT NULL
group by last_payment_year,  f1.home_ownership
order by last_payment_year, home_ownership desc;

SELECT a.id,a.home_ownership,b.last_pymnt_d
FROM finance1 as a 
join finance2 as b on a.id = b.id;

       
