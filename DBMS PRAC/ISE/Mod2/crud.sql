CREATE DATABASE production_db;
USE production_db;

-- Marketing Team
CREATE TABLE marketing_team (
    m_id INT AUTO_INCREMENT PRIMARY KEY,
    m_phno TEXT, -- Multivalued stored as comma-separated
    m_budget DECIMAL(10,2),
    m_timeframe_start DATE,
    m_timeframe_end DATE
);

-- Finance Team
CREATE TABLE finance_team (
    fi_id INT AUTO_INCREMENT PRIMARY KEY,
    fi_phno TEXT, -- Multivalued stored as comma-separated
    assigned_budget DECIMAL(10,2)
);

-- Director
CREATE TABLE director (
    d_id INT AUTO_INCREMENT PRIMARY KEY,
    d_name VARCHAR(255),
    d_age INT,
    d_phno TEXT, -- Multivalued stored as comma-separated
    d_email TEXT -- Multivalued stored as comma-separated
);

select * from finance_team;
