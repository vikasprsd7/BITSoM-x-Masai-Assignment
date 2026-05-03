# SQL Answers

## Q1 Count transactions by status
### Query
  SELECT 
    status, 
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY status;


## Q2
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

## Q3
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

## Q5
### Query

SELECT 
    t.merchant_name,
    SUM(CASE WHEN t.status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS chargeback_percent
FROM transactions t
GROUP BY t.merchant_name
HAVING (SUM(CASE WHEN t.status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) > 1
ORDER BY chargeback_percent DESC;
