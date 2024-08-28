
-- create a new database for data cleaning
create database employee_survey;


-- Table: Create table

-- DROP TABLE IF EXISTS survey;

CREATE TABLE IF NOT EXISTS survey
(
    "Timestamp" varchar,
    Age varchar,
    Industry varchar,
    "Job title" varchar,
    job_context varchar,
    "Annual Salary" varchar,
    "additional compensation" varchar,
    currency varchar,
	"other currency"varchar,
	 income_context varchar,
    country varchar,
    state varchar,
    City varchar,
    "overall work experience" varchar,
    "field work experience" varchar,
    "highest  education" varchar,
    gender varchar,
    race varchar
);
select * from survey limit 5;