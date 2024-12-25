CREATE DATABASE production_db;
USE production_db;

-- Finance Team
CREATE TABLE finance_team (
    fi_id INT AUTO_INCREMENT PRIMARY KEY,
    fi_phno TEXT, 
    assigned_budget DECIMAL(10,2),
    team_name VARCHAR(255)
);

-- Director
CREATE TABLE director (
    d_id INT AUTO_INCREMENT PRIMARY KEY,
    d_name VARCHAR(255),
    d_age INT,
    d_phno TEXT,
    d_email TEXT,
    project VARCHAR(255)
);

-- finance_update
create table finance_update(
before_update_assigned_budget int,
 after_update_assigned_budget int,
 before_update_fi_phno bigint,
 after_updated_fi_phno bigint,
 before_update_team_name varchar(255),
 after_update_team_name varchar(255)
 );


select * from director;
select * from finance_team;
select * from finance_update;
