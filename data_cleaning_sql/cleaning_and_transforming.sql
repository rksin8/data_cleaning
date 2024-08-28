
-- Total number of observation - 28062
select count(*) from survey;


-- View top 10 rows
select * from survey limit 10;


-- drop columns
alter table survey
drop column job_context,
drop column income_context;

-- inconsistent column names
-- rename column name and join using _

alter table survey rename "Timestamp" to timestamp;
alter table survey rename "Job title" to job_title;
alter table survey rename "Annual Salary" to salary; -- we have only one type of salary
alter table survey rename "additional compensation" to additional_salary_compensation;
alter table survey rename "other currency" to other_currency_unit;
alter table survey rename "overall work experience" to total_work_experience;
alter table survey rename "field work experience" to domain_work_experience;
alter table survey rename "highest  education" to education;


select * from survey limit 10;




-- Trim
update survey 
set timestamp = trim(timestamp),
	age = trim(age),
	industry= trim(industry), 
	job_title = trim(job_title),
	additional_salary_compensation = trim(additional_salary_compensation),
	currency = replace(trim(currency),',',''), -- replace , with ''
	other_currency_unit = trim(other_currency_unit),
	country=trim(country),
	state = trim(state),
	total_work_experience=trim(total_work_experience),
	domain_work_experience = trim(domain_work_experience),
	education = trim(education),
	gender = trim(gender),
	race=trim(race);
	
update survey 
set industry = initcap(industry),
job_title = initcap(job_title);

--update survey 
--set job_title = initcap(job_title);

select race, count(*) from survey
group by 1
order by 2 desc;
	

-- Academia
select * from survey
where industry ilike '%Academi%';

update survey
set industry='Academia'
where industry ilike '%Academi%';

--admin
select * from survey
where industry ilike '%Admin%' 
order by industry

update survey
set industry='Administration'
where industry ilike '%Admin%'


-- Aerospace 
select * from survey
where industry ilike '%Aeros%' 
order by industry;

update survey
set industry='Aerospace'
where industry ilike '%Aeros%'; 


-- Animal
select * from survey
where industry ilike '%animal%' 
order by industry;

update survey
set industry='Animal Care'
where industry ilike '%animal%'; 

-- Apparel 
update survey
set industry='Apparel '
where industry ilike '%Apparel%'; 

-- 'Agriculture'
select * from survey
where industry ilike '%agri%' 
order by industry;
	
update survey
set industry='Agriculture'
where industry ilike '%agri%'; 

	
-- Archaeology
update survey
set industry='Archaeology'
where industry ilike '%archaeo%';

-- Architecture
update survey
set industry='Architecture'
where industry ilike '%architec%';

update survey
set industry='Archives'
where industry ilike '%archive%';

-- e commerce
select * from survey
where industry ilike '%e-comm%' 
order by industry
	
update survey
set industry='E-commerce'
where industry ilike '%e-comm%' or industry ilike '%ecomme%' or  industry ilike '%e comme%'

-- Zoo 
update survey
set industry='Zoo'
where industry ilike '%Zoo%';  

-- Winery 
update survey
set industry='Winery'
where industry ilike '%wine%';  

-- Auto 
update survey
set industry='Automotive'
where industry ilike '%auto%';  

-- Food
update survey
set industry='Food'
where industry ilike '%food%';  

update survey
set industry='Biotech'
where industry ilike '%biotech%' or industry ilike '%bitech%';

update survey
set industry='Beauty'
where industry ilike '%beauty%';

update survey
set industry='Chemical'
where industry ilike '%chemical%';

update survey
set industry='Funeral Services'
where industry ilike '%Funeral%';


-- Energy sector
select * from survey
where industry ilike '%oil%' or industry ilike '%energy%';

update survey
set industry= 'Energy'
where industry ilike '%oil%' or industry ilike '%energy%'; 


-- Health sector
select * from survey
where industry ilike '%environ%' or industry ilike '%env.%';

update survey
set industry='Environmental'
where industry ilike '%environ%' or industry ilike '%env.%';
	

-- Health sector
update survey
set industry='Health'
where industry ilike '%health%' or industry ilike '%gym%' or industry ilike '%fitness%';


update survey
set industry='Child'
where industry ilike '%Child%';


update survey
set industry='Consumer Goods'
where industry ilike '%consumer%';
	
select * from survey
where industry ilike '%consumer%';

---

-- run this group by for all columns to check any abnormal entries 
select race, count(*) from survey
group by 1
order by 2 desc;


-- age: No missing values or special like: N/A, Na,


-- industry:
-- No missing values or special like: N/A, Na,

-- job_title
select * from survey
where job_title ilike 'N/A' or job_title ilike 'Na' 
	or job_title ilike '%No Official%'
	or job_title ilike '-';

-- delete where job_title '-'
delete from survey
where job_title ilike 'N/A' or job_title ilike 'Na' 
	or job_title ilike '%No Official%'
	or job_title ilike '-';



-- N/A, Na, No Official title is treated as missing values
update survey
set job_title=null
where job_title ilike 'N/A' or job_title ilike 'Na' or job_title ilike '%No Official%';

--  salary: No missing values or special like: N/A, Na,

-- currency: No missing values or special like: N/A, Na,

-- country
select * from survey
where country ilike 'N/A' or country ilike 'na';

-- city
select * from survey
where city ilike 'N/A' or city ilike 'na' or city ilike '%remote%';

update survey
set city='Remote'
where city ilike 'N/A' or city ilike 'na' or city ilike '%remote%';

-- gender
select * from survey
where gender  ilike '%prefer%';

update survey
set gender='Prefer not to answer'
where gender  ilike '%prefer%';


-- race -- all good

--Check missing values 
select * from survey
where timestamp is null
	or age is null
	or industry is null 
	or job_title is null
--	or additional_salary_compensation is null -> NULL expected in this column and is OK
	or currency is null
--	or other_currency_unit is null, -> NULL expected in this column and is OK
	or country is null
--	or state is null -> NULL expected in this column and is OK, only for US 
	or total_work_experience is null
	or domain_work_experience is null
	or education is null
	or gender is null
	or race is null;

-- total missing records: 532

-- Delete missing values
delete from survey
where timestamp in (select timestamp from survey
where timestamp is null
	or age is null
	or industry is null 
	or job_title is null
--	or additional_salary_compensation is null -> NULL expected in this column and is OK
	or currency is null
--	or other_currency_unit is null, -> NULL expected in this column and is OK
	or country is null
--	or state is null -> NULL expected in this column and is OK, only for US 
	or total_work_experience is null
	or domain_work_experience is null
	or education is null
	or gender is null
	or race is null) and industry in (select industry from survey
where timestamp is null
	or age is null
	or industry is null 
	or job_title is null
--	or additional_salary_compensation is null -> NULL expected in this column and is OK
	or currency is null
--	or other_currency_unit is null, -> NULL expected in this column and is OK
	or country is null
--	or state is null -> NULL expected in this column and is OK, only for US 
	or total_work_experience is null
	or domain_work_experience is null
	or education is null
	or gender is null
	or race is null)

-- Recheck and Verify missing values
select * from survey
where timestamp is null
	or age is null
	or industry is null 
	or job_title is null
	or additional_salary_compensation is null --> NULL expected in this column and is OK 
	or currency is null
--	or other_currency_unit is null, -> NULL expected in this column and is OK
	or country is null
--	or state is null -> NULL expected in this column and is OK, only for US 
	or total_work_experience is null
	or domain_work_experience is null
	or education is null
	or gender is null
	or race is null;

-- No missing values now
-- run this group by for all columns to check any abnormal entries 
select country, count(*) from survey
group by 1
order by 1 desc;

-- US, U.S., USA, United States, use, Us, U.S.A, us, America, U.s.

-- UK United Kingdom, U.K. 

-- Australis, australi

-- new zealan, NZ

select upper(replace(country,'.','')) from survey

select job_title, salary, count(*) 
from survey
group by job_title, salary
order by salary asc

update survey
set country = upper(replace(country,'.',''));

select country from survey
where country ilike '%US%' or country ilike '%STATE%' or country ilike 'U S%' or country ilike '%UNIT___S%'

select country from survey
where country ilike '%BRITAIN%' 
	or  country ilike '%ENGLAN_%'
	or  country ilike '%Kin%'
	or country ilike '%UK%'
	or country ilike '%LONDON%'
	or country ilike '%TLAND%'
	or country ilike '%IRE%LAND%'


update survey
set country='US'
where country ilike '%US%' or country ilike '%STATES%' or country ilike 'U S%' or country ilike '%UNIT___S%'


update survey
set country='NEW ZEALAND'
where country ilike '%NEW%' or  country ilike '%NZ%'

update survey
set country='UK'
where country ilike '%BRITAIN%' 
	or  country ilike '%ENGLAN_%'
	or  country ilike '%Kin_dom%'
	or country ilike '%UK%'
	or country ilike '%LONDON%'
	or country ilike '%TLAND%'
	or country ilike '%IRE%LAND%'
    or country ilike '%WALE%'


select country from survey
where country ilike '%CAN%' 
	
update survey
set country='CANADA'
where country ilike '%CAN%' or country ilike '%NADA%' 


select country from survey
where length(country) >20 or length(country) < 2

update survey
set country='Remote'
where length(country) >20 or length(country) < 2

-- Recheck
select country, count(*) from survey
group by 1
order by 2 desc;

---- convert salary to US dollar unit
select count(*) from survey

update survey
set other_currency_unit = upper(other_currency_unit);

update survey
set other_currency_unit = 'PLN'
where currency ilike 'Other' and other_currency_unit ilike '%Polish%'
	

select currency, other_currency_unit, country from survey
	where currency ilike 'Other' and other_currency_unit ilike '%PESO%'

select race, count(*) from survey
group by 1
order by 2 desc


-- update currency
select currency, other_currency_unit, country from survey
where currency is null and country='MALAYSIA' --country='US'

update survey
set other_currency_unit = 'MYR'
where currency is null and country='MALAYSIA'

update survey
set currency = other_currency_unit 
where currency is null
	
update survey
set currency = other_currency_unit 
where currency ilike 'Other' and currency is not null

update survey
set currency = 'AUD'
where currency = 'AUD/NZD' 

update survey
set additional_salary_compensation = 0
where additional_salary_compensation is null

-- choosing top 20 currency records


-- only 17 records ---so delete it 
select  currency from survey
where length(currency) >3 or length(currency) <3

	
delete from survey
where currency in (
select  currency from survey
where length(currency) >3 or length(currency) <3
)

-- delete unsupported currency code -- 11 record deleted 
delete from survey
where currency in ('ARN','NGN','ARS','TTD','SAR','LKR','NTD');

---Now we have clean data, just need to currency conversion
select * from survey limit 10;
select * from currency_conversion

update survey
set currency = 'AUD'



update survey
set salary = replace(salary,',','');

update survey
set salary = replace(salary,' ','') ;

select * from survey
where salary=6000070000



-- check abnormal high or low salary
	
select
	salary::bigint/1000 as salary,
	rank() over (order by salary::bigint asc)
from survey

-- delete abnormal salary: DELETE 471
delete from survey
where salary::bigint > 500000 or salary::bigint < 20000 

	
--select max(replace(salary,',','')::bigint) from survey limit 10


update survey
set salary_usd = salary_usd
from (select ((salary + additional_salary_compensation) * cc.conversion_factor) as salary_usd
from survey s
left join currency_conversion cc on s.currency = cc.currency_code
) a
where a.salary_usd is not null

-- create new column for salary in usd
ALTER TABLE survey 
add COLUMN salary_usd bigint;



ALTER TABLE survey ALTER COLUMN salary TYPE bigint USING (NULLIF(salary, '')::bigint);
ALTER TABLE survey ALTER COLUMN additional_salary_compensation TYPE bigint 
	USING (NULLIF(additional_salary_compensation, '')::bigint);

SELECT pg_typeof(salary) FROM survey;

-- check for duplicate
select industry, job_title, count(*)
from survey
group by 1,2
order by 2, 3 desc


select * from survey
