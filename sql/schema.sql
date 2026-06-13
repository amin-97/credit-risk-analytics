DROP TABLE IF EXISTS fact_loans CASCADE;
DROP TABLE IF EXISTS dim_grade CASCADE;
DROP TABLE IF EXISTS dim_borrower CASCADE;
DROP TABLE IF EXISTS dim_loan_terms CASCADE;
DROP TABLE IF EXISTS dim_date CASCADE;
DROP TABLE IF EXISTS dim_geography CASCADE;

CREATE TABLE dim_grade (
    grade_key      SERIAL PRIMARY KEY,
    grade          VARCHAR(2)  NOT NULL,
    sub_grade      VARCHAR(3)  NOT NULL,
    UNIQUE (grade, sub_grade)
);

CREATE TABLE dim_borrower (
    borrower_key         SERIAL PRIMARY KEY,
    home_ownership       VARCHAR(20),
    emp_length           VARCHAR(20),
    verification_status  VARCHAR(20),
    UNIQUE (home_ownership, emp_length, verification_status)
);

CREATE TABLE dim_loan_terms (
    terms_key   SERIAL PRIMARY KEY,
    term        VARCHAR(15),
    purpose     VARCHAR(30),
    UNIQUE (term, purpose)
);

CREATE TABLE dim_date (
    date_key    SERIAL PRIMARY KEY,
    issue_d     VARCHAR(10),
    issue_year  INT,
    issue_month INT,
    issue_quarter INT,
    UNIQUE (issue_d)
);

CREATE TABLE dim_geography (
    geo_key     SERIAL PRIMARY KEY,
    addr_state  VARCHAR(2),
    UNIQUE (addr_state)
);

CREATE TABLE fact_loans (
    loan_id      BIGSERIAL PRIMARY KEY,
    grade_key    INT REFERENCES dim_grade(grade_key),
    borrower_key INT REFERENCES dim_borrower(borrower_key),
    terms_key    INT REFERENCES dim_loan_terms(terms_key),
    date_key     INT REFERENCES dim_date(date_key),
    geo_key      INT REFERENCES dim_geography(geo_key),
    loan_amnt    NUMERIC(12,2),
    int_rate     NUMERIC(6,3),
    installment  NUMERIC(10,2),
    annual_inc   NUMERIC(14,2),
    dti          NUMERIC(7,2),
    revol_util   NUMERIC(7,2),
    default_flag INT NOT NULL
);