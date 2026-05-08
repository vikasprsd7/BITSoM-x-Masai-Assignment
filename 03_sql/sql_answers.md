# SQL Answers

## Q1 Count transactions by status
### Query
  SELECT 
    status, 
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY status;

### Result Summary
- Out of 30 total transactions,
  - 19 were successful (captured),
  - 7 failed because of timeouts,
  - 4 ended in chargebacks.
- That means about 63% of all transactions went through successfully, while the rest show signs of risk and potential issues.

## Q2 Calculate total captured GMV by merchant
### Query
  SELECT 
    t.merchant_name,
    SUM(t.raw_amount * cr.usd_rate) AS total_captured_gmv_usd
FROM transactions t
JOIN currency_rates cr 
    ON t.currency = cr.currency 
   AND t.transaction_date = cr.rate_date
WHERE t.status = 'Captured'
GROUP BY t.merchant_name
ORDER BY total_captured_gmv_usd DESC;

### Result Summary
- **(GMV – Gross Merchandise Value) each merchant successfully captured in USD.**
  - Beta Stores is the top performer with about 33,431 USD.
  - Alpha Mart follows closely at 29,984.50 USD.
  - Delta Travels captured 10,300 USD.
  - City Pharma brought in 8,640 USD.

**Note:** **Eco Home is not included in the output because none of its transactions had a status of 'Captured'.**

## Q3 Show top 10 merchants by captured GMV
### Query
SELECT 
    t.merchant_name,
    SUM(t.raw_amount * cr.usd_rate) AS total_captured_gmv_usd
FROM transactions t
JOIN currency_rates cr 
    ON t.currency = cr.currency 
   AND t.transaction_date = cr.rate_date
WHERE t.status = 'Captured'
GROUP BY t.merchant_name
ORDER BY total_captured_gmv_usd DESC
LIMIT 10;

### Result Summary
- The result displays only 4 rows because the dataset provided **only contains 5 unique merchants in total**, and **only 4 of them have transactions with a status of 'Captured'**.

  - Beta Stores - 33,431 USD.
  - Alpha Mart - 29,984.50 USD.
  - Delta Travels - 10,300 USD.
  - City Pharma - 8,640 USD.
- Beta Stores and Alpha Mart are the biggest drivers of captured sales.

## Q4 Show daily GMV and successful transaction count
### Query
SELECT 
    DATE_FORMAT(t.transaction_date, '%d-%m-%Y') AS txn_date,
    SUM(t.raw_amount * cr.usd_rate) AS daily_captured_gmv_usd,
    COUNT(*) AS successful_txn_count
FROM transactions t
JOIN currency_rates cr 
    ON t.currency = cr.currency 
   AND t.transaction_date = cr.rate_date
WHERE t.status = 'Captured'
GROUP BY txn_date
ORDER BY txn_date;

### Result Summary
- **On March 1st, 2026:** There were 5 successful transactions that added up to about **$26,382.00**.
- **On March 5th, 2026:** Only 1 transaction succeeded, bringing in just **$6,136.00**. This weak performance was mainly because of **3 timeout failures** and **1 chargeback** that happened that day.

## Q5 Find merchants with chargeback ratio above 1%
### Query

SELECT 
    t.merchant_name,
    SUM(CASE WHEN t.status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS chargeback_ratio_percent
FROM transactions t
GROUP BY t.merchant_name
HAVING (SUM(CASE WHEN t.status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) > 1
ORDER BY chargeback_ratio_percent DESC;

### Result Summary
- Eco Home is at **critical risk** with a **50% chargeback rate**.
- Delta Travels follows with a high rate of 25%.
- Alpha Mart and Beta Stores show identical rates of 9.09%. 
- City Pharma is the **healthiest merchant** in the dataset, maintaining a **0% chargeback rate**.

## Q6 Find regions with average risk score above 50 and more than 20 transactions
### Query

SELECT 
    gateway_region,
    AVG(risk_score_updated) AS avg_risk_score,
    COUNT(*) AS txn_count
FROM transactions
GROUP BY gateway_region
HAVING AVG(risk_score_updated) > 50
   AND COUNT(*) > 20
ORDER BY avg_risk_score DESC;

### Result Summary
The query didn’t return any results because no region had enough transactions to meet the requirement of more than 20.
  - Two regions did have high average risk scores (above 50):
  - APAC scored 67.54, but it only had 13 transactions.
  - NOT FOUND scored 62.00, but it only had 9 transactions.
  - Other regions like EU and US had just 4 transactions each, and their average risk scores were below 50.
    
**NOTE:** The rule was-**average risk score > 50 AND more than 20 transactions**;and no region met both conditions.

## Q7 Find users with 3 or more failed or chargeback transactions on the same day
### Query

SELECT 
    user_id,
    DATE_FORMAT(transaction_date, '%d-%m-%Y') AS txn_date,
    COUNT(*) AS failed_or_chargeback_count
FROM transactions
WHERE status IN ('Failed E05 Timeout', 'Chargeback')
GROUP BY user_id, txn_date
HAVING COUNT(*) >= 3
ORDER BY failed_or_chargeback_count DESC, txn_date;

### Result Summary

The data points to **User U008** as a case for close attention. 
On March 5th, 2026, this user tried to make 4 transactions, but none were successful. Instead, there were 3 timeout failures and 1 chargeback.

## Q8 Show chargeback count, unique affected users, and chargeback amount by merchant
### Query

SELECT 
    t.merchant_name,
    COUNT(*) AS chargeback_count,
    COUNT(DISTINCT t.user_id) AS unique_affected_users,
    SUM(t.raw_amount * cr.usd_rate) AS total_chargeback_amount_usd
FROM transactions t
JOIN currency_rates cr 
    ON t.currency = cr.currency 
   AND t.transaction_date = cr.rate_date
WHERE t.status = 'Chargeback'
GROUP BY t.merchant_name
ORDER BY total_chargeback_amount_usd DESC;

### Result Summary
The **chargebacks during this period are spread out across different merchants**, not concentrated in one place.
  - Eco Home had the biggest financial hit, with a single chargeback worth $6,649.00.
  - Each chargeback came from a different user, which means these look like isolated cases rather than a coordinated attack by one person.
  - Alpha Mart and Beta Stores both handle a lot of transactions, but each only had 1 chargeback.
