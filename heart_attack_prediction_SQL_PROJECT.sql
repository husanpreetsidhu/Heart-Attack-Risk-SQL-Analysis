#--------------------------------------------------HEART ATTACK RISK -------------------------------------------------
CREATE DATABASE heart_attack;
USE heart_attack;
select * from heart_attack_prediction_india;
select count(*) from heart_attack_prediction_india;
select avg(age) from heart_attack_prediction_india;
select gender, count(gender) from heart_attack_prediction_india
group by gender;
select max(state_name) from heart_attack_prediction_india;
select state_name, count(*) as patients
from heart_attack_prediction_india 
group by state_name
order by patients desc;
select * from heart_attack_prediction_india
where age>50;
select * from heart_attack_prediction_india
where cholesterol_level>200;  
select state_name , count(heart_attack_risk) from heart_attack_prediction_india
group by state_name;
select state_name , count(*) from heart_attack_prediction_india
group by state_name;
select gender,avg(cholesterol_level) from heart_attack_prediction_india
group by gender ;


SELECT
    Diabetes,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN Obesity = 'Yes' THEN 1 ELSE 0 END) AS Obese_Patients
FROM heart_attack_prediction_india
GROUP BY Diabetes;


select heart_attack_risk, age_group from heart_attack_prediction_india
order by heart_attack_risk desc ;


#-----------Which age group has highest heart attack risk?-----------------------------------------------------------
select case
      when age<30 then "young"
      when age between 30 and 50 then "adult"
      else "senior"
      end as age_group,count(*) as risk_patients from heart_attack_prediction_india
where heart_attack_risk="high" 
group by age_group
order by risk_patients desc 
limit 1;
      
      
#-------------------------Find states where heart attack risk is more than average.-----------------------------------
select state_name, avg(heart_attack_risk) from heart_attack_prediction_india 
group by state_name having avg(heart_attack_risk)>
(select avg(heart_attack_risk) from heart_attack_prediction_india);


#-----------------------------Level 2 – GROUP BY & Aggregate Functions (10 Questions)-------------------------------

# Q11. Count patients in each state.

select state_name, count(*) from heart_attack_prediction_india
group by state_name ;

# Q12. Find average cholesterol level by gender.

select gender , avg(cholesterol_level) from heart_attack_prediction_india
group by gender;

# Q13. Find average LDL level by state.

select state_name, avg(LDL_level) from heart_attack_prediction_india
group by state_name;

# Q14. Find average HDL level by gender.

select gender , avg(hdl_level) from heart_attack_prediction_india 
group by gender;

#Q15 Find the average HDL level for each state and display only states
# where average HDL is greater than the overall average HDL.
select state_name,avg(hdl_level) as avg_hdl
from heart_attack_prediction_india
group by state_name
having avg(hdl_level)>(
           select avg(hdl_level)
           from heart_attack_prediction_india
);

#Q16 Find the average cholesterol for each age group:
select case 
	   when age<30 then "young"
       when age between 30 and 50 then "adult"
       else "senior"
	end as age_group,
    AVG(cholesterol_level) AS avg_cholesterol
from heart_Attack_prediction_india 
group by age_group 
order by avg_cholesterol desc;

#Q17 Find the percentage of High Risk patients in each state.
select state_name as state,
	   count(*) as total_patients,
       sum(case 
		   when heart_attack_risk="high" then 1 
           else 0
		end ) as high_risk_patients,
	 ROUND(
        SUM(CASE
                WHEN heart_attack_risk = 'High' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
        2
    ) AS Risk_Percentage
FROM heart_attack_prediction_india
GROUP BY state_name
ORDER BY Risk_Percentage DESC;


#Find the gender-wise percentage of High Risk patients.
select gender,count(*) as total_patients,
sum( case when heart_attack_risk="High" then 1
     else 0
     end
) as high_risk_patients,
round(sum(case when heart_attack_risk="High" then 1 
else 0 
end )*100.0/count(*),2) as risk_percentage
from heart_attack_prediction_india
group by gender 
order by risk_percentage desc;


#Find patients whose cholesterol level is greater than the overall average cholesterol.
select * from heart_attack_prediction_india 
where cholesterol_level>(select avg(cholesterol_level)from heart_attack_prediction_india );


#Find patients whose LDL level is greater than the overall average LDL.
select * from heart_attack_prediction_india 
where LDL_Level>(select avg(LDL_Level )from heart_attack_prediction_india);

       
#Find states whose average cholesterol is greater than the overall average cholesterol.
select state_name,avg(cholesterol_level) as cholesterol_level from heart_attack_prediction_india 
group by state_name
having avg(cholesterol_level)>(select avg(cholesterol_level) from heart_attack_prediction_india)
order by cholesterol_level desc;


#Find patients whose age is greater than the average age of High Risk patients.
select * from heart_attack_prediction_india
where age>(select avg(age) from heart_attack_prediction_india
where heart_attack_risk ="High");


#Find patients whose cholesterol is greater than the average cholesterol of their own state.
select * from heart_attack_prediction_india
where cholesterol_level>(select avg(cholesterol_level) from heart_attack_prediction_india );


#Create a cholesterol_category: Then count patients in each category.
select case 
when cholesterol_level<200 then "Normal"
when cholesterol_level between 200 and 239 then "Borderline High"
else "high"
end as cholesterol_category,count(*) as total_patients 
from heart_attack_prediction_india 
group by cholesterol_category;


#Create an age_group and find: Age Group | Total Patients | High Risk Patients
select case 
when age<30 then "young"
when age between 30 and 50 then "adult"
else "senior"
end as age_group ,
count(*) as total_patients,
sum(case when heart_attack_risk="high" then 1
else 0 
end ) as high_risk_patients
from heart_attack_prediction_india
group by age_group ;



#Create a risk_score: 0–1→ Low Risk 2–3 → Medium Risk  4→ High Risk
select 
    patient_id, 
    diabetes, 
    obesity, 
    smoking, 
    cholesterol_level, 
(case when diabetes = 'yes' then 1 else 0 end +
case when obesity = 'yes' then 1 else 0 end +
case when smoking = 'yes' then 1 else 0 end + 
case when cholesterol_level > 200 then 1 else 0 end) as risk_score,
case
when (
	case when diabetes = 'yes' then 1 else 0 end +
	case when obesity = 'yes' then 1 else 0 end +
	case when smoking = 'yes' then 1 else 0 end +
	case when cholesterol_level > 200 then 1 else 0 end ) between 0 and 1
	then 'low risk'
when (
case when diabetes = 'yes' then 1 else 0 end +
case when obesity = 'yes' then 1 else 0 end +
case when smoking = 'yes' then 1 else 0 end +
case when cholesterol_level > 200 then 1 else 0 end) between 2 and 3
then 'medium risk'
else 'high risk'
end as risk_category

from heart_attack_prediction_india;


#Assign a unique row number to patients based on: highest cholesterol → lowest cholesterol

select patient_id,cholesterol_level, row_number()over(
order by cholesterol_level desc) as row_num
from heart_attack_prediction_india;


#Rank patients based on cholesterol.If two patients have the same cholesterol, they should receive the same rank.

select patient_id, cholesterol_level, rank() over (
order by cholesterol_level desc) as cholesterol_rank
from heart_attack_prediction_india;


#Rank states based on their average cholesterol.Highest average cholesterol = Rank 1.
select state_name, avg(cholesterol_level) as avg_cholesterol,
rank() over (
	order by avg(cholesterol_level) desc) as cholesterol_rank
from heart_attack_prediction_india
group by state_name
order by cholesterol_rank;


#Rank patients by cholesterol within each state.
select patient_id, state_name, cholesterol_level,
rank() over (
partition by state_name
order by cholesterol_level desc) as cholesterol_rank
from heart_attack_prediction_india;


#Find the highest cholesterol patient from every state using a window function.
select patient_id, state_name, cholesterol_level
from (select patient_id, state_name, cholesterol_level,
row_number() over (
partition by state_name
order by cholesterol_level desc) as rn
from heart_attack_prediction_india
) t
where rn = 1;


#Find the top 3 highest cholesterol patients from every state.
select patient_id, state_name, cholesterol_level
from (select patient_id, state_name, cholesterol_level,
row_number() over ( partition by state_name
	order by cholesterol_level desc) as rn
    from heart_attack_prediction_india
) t
where rn <= 3;


#Within each state, use LAG() to display: Patient Current Cholesterol Previous Patient's Cholesterol Order patients by age.
select patient_id, state_name, age,
cholesterol_level as current_cholesterol,
lag(cholesterol_level) over (
	partition by state_name
    order by age) as previous_patient_cholesterol
from heart_attack_prediction_india;


#Calculate: Current Cholesterol - Previous Cholesterol using LAG().
select patient_id, state_name, age, cholesterol_level as current_cholesterol,
    lag(cholesterol_level) over (
        partition by state_name
        order by age) as previous_cholesterol,
cholesterol_level -
    lag(cholesterol_level) over (
        partition by state_name
        order by age) as cholesterol_difference
from heart_attack_prediction_india;


#Use LEAD() to display the next patient's cholesterol level within each state.
select patient_id, state_name, age, cholesterol_level as current_cholesterol,
    lead(cholesterol_level) over (
        partition by state_name
        order by age) as next_patient_cholesterol
from heart_attack_prediction_india;


#Find the top 5 states based on High Risk percentage, but only include states having at least 100 patients.
select state_name, count(*) as total_patients,
sum( case
	when heart_attack_risk = 'high' then 1
	else 0
	end) as high_risk_patients,
    round(sum( case
		when heart_attack_risk = 'high' then 1
		else 0
		end) * 100.0 / count(*),2) as risk_percentage
from heart_attack_prediction_india
group by state_name
having count(*) >= 100
order by risk_percentage desc
limit 5;


#Find the state where the difference between: Average Cholesterol AND Average HDL is the highest.
select
    state_name,
    avg(cholesterol_level) as avg_cholesterol,
    avg(hdl_level) as avg_hdl,
    avg(cholesterol_level) - avg(hdl_level) as difference
from heart_attack_prediction_india
group by state_name
order by difference desc
limit 1;


#Find the gender + state combination having the highest High Risk percentage.
select gender, state_name, count(*) as total_patients,
sum( case
	when heart_attack_risk = 'high' then 1
	else 0
	end) as high_risk_patients,
    round(sum(case
		when heart_attack_risk = 'high' then 1
		else 0
		end) * 100.0 / count(*),2) as risk_percentage
from heart_attack_prediction_india
group by gender, state_name
order by risk_percentage desc
limit 1;


#Find patients who satisfy all three conditions:Cholesterol above overall average LDL above overall average Age above overall average
select *
from heart_attack_prediction_india
where cholesterol_level > (
    select avg(cholesterol_level)
    from heart_attack_prediction_india)
and ldl_level > (
    select avg(ldl_level)
    from heart_attack_prediction_india)
and age > (
    select avg(age)
    from heart_attack_prediction_india);


#Then rank the states based on High Risk %.
select state_name, count(*) as total_patients,
sum(case
	when heart_attack_risk = 'high' then 1
	else 0
	end) as high_risk_patients,
round( sum(case
	when heart_attack_risk = 'high' then 1
	else 0
	end) * 100.0 / count(*),2) as high_risk_percentage,
round(avg(age), 2) as avg_age,
round(avg(cholesterol_level), 2) as avg_cholesterol,
round(avg(ldl_level), 2) as avg_ldl,
rank() over (order by sum(
		case
		when heart_attack_risk = 'high' then 1
		else 0
		end) * 100.0 / count(*) desc) as risk_rank
from heart_attack_prediction_india
group by state_name
order by risk_rank;



#Create a procedure
delimiter //

create procedure get_state_analysis(in p_state_name varchar(100))
begin select
count(*) as total_patients,
round(avg(age), 2) as avg_age,
round(avg(cholesterol_level), 2) as avg_cholesterol,
 round(avg(ldl_level), 2) as avg_ldl,
 round(avg(hdl_level), 2) as avg_hdl,
sum( case
     when heart_attack_risk = 'high' then 1
	 else 0
	 end) as high_risk_patients,
round(
      sum( case
          when heart_attack_risk = 'high' then 1
		  else 0
		  end) * 100.0 / count(*), 2) as high_risk_percentage
from heart_attack_prediction_india
where state_name = p_state_name;
end //
delimiter ;
call get_state_analysis('Punjab');




#Create a procedure that accepts:genderand returns the complete analysis for that gender.

delimiter //
create procedure get_gender_analysis(in p_gender varchar(20))
begin select
count(*) as total_patients,
round(avg(age), 2) as avg_age,
round(avg(cholesterol_level), 2) as avg_cholesterol,
round(avg(ldl_level), 2) as avg_ldl,
round(avg(hdl_level), 2) as avg_hdl,
sum( case
	when heart_attack_risk = 'high' then 1
	else 0
	end) as high_risk_patients,
round(sum(case
	when heart_attack_risk = 'high' then 1
	else 0
	end) * 100.0 / count(*),2) as high_risk_percentage
from heart_attack_prediction_india
where gender = p_gender;
end //
delimiter ;
call get_gender_analysis('Female');