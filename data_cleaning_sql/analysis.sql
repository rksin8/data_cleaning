
-- Analysis to answer 5 question

select * from survey
order by salary desc

-- 1. Which industry pays the most?

select distinct industry, avg(salary)::int/1000 as salary
	from survey
group by 1
order by salary desc
limit 10

-- 2. How does salary increase given years of experience?

select distinct domain_work_experience, avg(salary)::int as salary
	from survey
group by 1
order by 2 desc

-- 3. How do salaries compare for the same role in different locations?

select distinct country, avg(salary)::int as salary
	from survey
where job_title ilike '%manager%'
group by 1
order by 2 desc
limit 10

-- 4. How much do salaries differ by gender and years of experience?

select distinct gender, domain_work_experience, avg(salary)::int as salary
	from survey
group by 1,2
order by 3 desc
limit 8

-- 5. How do factors like race and education level correlate with salary?
select distinct education, race, avg(salary)::int as salary
	from survey
group by 1,2
order by 3 desc
limit 10

