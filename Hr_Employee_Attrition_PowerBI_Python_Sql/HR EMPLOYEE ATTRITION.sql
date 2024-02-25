SELECT * FROM meriskill.`hr-employee-attrition`;
select*from employee_attrition;
use meriskill;

#-------------------kpis---------------------------#
select count(EmployeeNumber) as "Total Employee" 
from employee_attrition;
select Attrition,count(EmployeeNumber) as "No of employee"
from employee_attrition
where Attrition="yes" or Attrition="No"
group by Attrition;

#------------------kpis----------------------------#
select Gender,Attrition,count(EmployeeNumber) as "No Of Employee"
from employee_attrition
where Attrition="yes" or Attrition="No"
group by Gender,Attrition;

#1------employee attrition having 5+ experience in between age group of 27-35---------#

select count(*) from employee_attrition
where age between 27 and 35 and totalworkingyears > 5;
select*from employee_attrition
where age between 27 and 35 and totalworkingyears > 5;

#2------employee having max and min salary working in different dept who received less than 13% salary hike#

select*from employee_attrition
where PercentSalaryHike < 13;

select Department,max(MonthlyIncome),min(MonthlyIncome)
from employee_attrition
where PercentSalaryHike < 13
group by Department
order by max(MonthlyIncome) desc;

#3------calculate avg monthly income of all employee who worked more than 3 years whose education is medical#

select EducationField,avg(MonthlyIncome)
from employee_attrition
group by EducationField;

select EducationField,avg(MonthlyIncome)
from employee_attrition
where YearsAtCompany > 3 and EducationField = "Medical";

#4------Total no of male and female employee under attrition whose marital status is married and haven't received pramotion in the last 2 years#

select Gender,count(EmployeeNumber) as "NoOfEmployee"
from employee_attrition
where MaritalStatus= "Married" and YearsSinceLastPromotion=2 and Attrition ="Yes"
group by Gender;  

#5------employee with max performance rating but no promotion for 4 yr and above#

select max(PerformanceRating)
from employee_attrition;

select*
from employee_attrition
where PerformanceRating=(select max(PerformanceRating) from employee_attrition) and YearsSinceLastPromotion >=4;

#6------who max and min percentage salary hike#

select YearsAtCompany
from employee_attrition;

select YearsAtCompany,PerformanceRating,YearsSinceLastPromotion,max(PercentSalaryHike),min(PercentSalaryHike)
from employee_attrition
group by YearsAtCompany,PerformanceRating,YearsSinceLastPromotion
order by max(PercentSalaryHike) desc,min(PercentSalaryHike)asc;

#7------employee working overtime but given min salary hike and more than 5 yr with company and Attrition "yes"#

select min(PercentSalaryHike) from employee_attrition;

select*
from employee_attrition
where OverTime="Yes"
and PercentSalaryHike=(select min(PercentSalaryHike) from employee_attrition)
and YearsAtCompany >5
and Attrition="yes";

#8------employee working overtime but given max salary hike and less than 5 yr with company#

select max(PercentSalaryHike) from employee_attrition;

select*
from employee_attrition
where OverTime="Yes"
and PercentSalaryHike=(select max(PercentSalaryHike) from employee_attrition)
and YearsAtCompany <5;

#9------employee working No overtime but given max salary hike and less than 5 yr with company#

select*
from employee_attrition
where OverTime="No"
and PercentSalaryHike=(select max(PercentSalaryHike) from employee_attrition)
and YearsAtCompany <5;

#10------Married employee with max and min relationship satisfaction #

select MaritalStatus,max(RelationshipSatisfaction),min(RelationshipSatisfaction)
from employee_attrition
group by MaritalStatus;