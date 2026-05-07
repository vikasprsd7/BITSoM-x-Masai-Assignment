# SQL Answers

## Q1 Count transactions by status
### Query
  SELECT 
    status, 
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY status;


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

## Q5 Find merchants with chargeback ratio above 1%
### Query

SELECT 
    t.merchant_name,
    SUM(CASE WHEN t.status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS chargeback_ratio_percent
FROM transactions t
GROUP BY t.merchant_name
HAVING (SUM(CASE WHEN t.status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) > 1
ORDER BY chargeback_ratio_percent DESC;

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
