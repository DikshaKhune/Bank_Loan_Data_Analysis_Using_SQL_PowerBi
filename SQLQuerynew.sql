
--DASHBOARD 1 : SUMMARY

SELECT * FROM bank_loan_data

--Total loan applications
SELECT COUNT(id) AS total_loan_applications FROM bank_loan_data

--Total loan applications(MTD)
SELECT COUNT(id) AS MTD_total_loan_applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--Total loan applications(PMTD)
SELECT COUNT(id) AS PMTD_total_loan_applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--total loan applications(MOM)

--Formula(MTD - PMTD)/PMTD  --(TASK FOR YOURSELF)

--Total funded amount
SELECT SUM(loan_amount) AS total_funded_amount FROM bank_loan_data

--Total funded amount(MTD)
SELECT SUM(loan_amount) AS MTD_total_funded_amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--Total funded amount(PMTD) 
SELECT SUM(loan_amount) AS PMTD_total_funded_amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--total amount received
SELECT SUM(total_payment) AS total_amount_received FROM bank_loan_data

--total amount received(MTD)
SELECT SUM(total_payment) AS MTD_total_payment_received FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--total amount received(PMTD)
SELECT SUM(total_payment) AS PMTD_total_payment_received FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--average interest rate
SELECT ROUND(AVG(int_rate), 4) * 100 AS avg_int_rate FROM bank_loan_data

--avg interest rate(MTD)
SELECT ROUND(AVG(int_rate), 4) * 100 AS MTD_avg_int_rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--avg_interest rate(PMTD)
SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_avg_int_rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--avg Debt-to-Income ration(DTI)
SELECT ROUND(AVG(dti), 4) * 100 AS avg_dti FROM bank_loan_data

--avg dti (MTD)
SELECT ROUND(AVG(dti), 4) * 100 AS MTD_avg_dti FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--avg dti(PMTD)
SELECT ROUND(AVG(dti), 4) * 100 AS PMTD_avg_dti FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


SELECT loan_status FROM bank_loan_data

--Good Loan Percentage
SELECT
     (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0)
	  /
	  COUNT(id) AS Good_loan_pct
FROM bank_loan_data

--Good loan applications
SELECT COUNT(id) AS good_loan_applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good loan funded amount
SELECT SUM(loan_amount) AS good_loan_funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good loan total received amount
SELECT SUM(total_payment) AS good_loan_received_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Bad loan percentage
SELECT
     (COUNT(CASE WHEN loan_status = 'Charged off' THEN id END) * 100.0)
	  /
	  COUNT(id) AS bad_loan_pct
FROM bank_loan_data

--Bad loan applications
SELECT COUNT(id) AS bad_loan_applications FROM bank_loan_data
WHERE loan_status = 'Charged off'

--Bad loan funded amount
SELECT SUM(loan_amount) AS bad_loan_funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged off'

--Bad loan total received amount
SELECT SUM(total_payment) AS bad_loan_received_amount FROM bank_loan_data
WHERE loan_status = 'Charged off'


--Loan status grid view
SELECT
      loan_status,
	  COUNT(id) AS total_loan_applications,
	  SUM(loan_amount) AS total_funded_amount,
	  SUM(total_payment) AS total_received_amount,
	  AVG(int_rate * 100) AS interest_rate,
	  AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status

--Loan status grid view(MTD)
SELECT
     loan_status,
	 SUM(loan_amount) AS MTD_total_funded_amount,
	 SUM(total_payment) AS MTD_total_amount_received
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status

--Loan status grid view(PMTD)
SELECT
     loan_status,
	 SUM(loan_amount) AS PMTD_total_funded_amount,
	 SUM(total_payment) AS PMTD_total_amount_received
FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021
GROUP BY loan_status


--DASHBOARD 2 : OVERVIEW

--CHARTS

--Monthly trends by issue date(Line chart)
SELECT
      MONTH(issue_date) AS month_number,
	  DATENAME(MONTH, issue_date) AS month_name,
	  COUNT(id) AS total_loan_applications,
	  SUM(loan_amount) AS total_funded_amount,
	  SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY  MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--Regional analysis by states(Filled map)
SELECT
      address_state,     
	  COUNT(id) AS total_loan_applications,
	  SUM(loan_amount) AS total_funded_amount,
	  SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY  address_state
ORDER BY address_state

--loan term analysis(Donut chart)
SELECT
      term,     
	  COUNT(id) AS total_loan_applications,
	  SUM(loan_amount) AS total_funded_amount,
	  SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY  term
ORDER BY term

--Employee length analysis(Bar chart)
SELECT
      emp_length,     
	  COUNT(id) AS total_loan_applications,
	  SUM(loan_amount) AS total_funded_amount,
	  SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY  emp_length
ORDER BY emp_length

--loan purpose background(Bar chart)
SELECT
      purpose,     
	  COUNT(id) AS total_loan_applications,
	  SUM(loan_amount) AS total_funded_amount,
	  SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY  purpose
ORDER BY COUNT(id) DESC

--Home ownership analysis(Tree map)
SELECT
      home_ownership,     
	  COUNT(id) AS total_loan_applications,
	  SUM(loan_amount) AS total_funded_amount,
	  SUM(total_payment) AS total_amount_received
FROM bank_loan_data
GROUP BY  home_ownership
ORDER BY COUNT(id) DESC












