Create Database QuickPay;
use QuickPay;

CREATE TABLE transactions (
    transaction_id VARCHAR(10) PRIMARY KEY,
    transaction_date DATE,
    merchant_name VARCHAR(100),
    raw_amount DECIMAL(15,2),
    currency VARCHAR(10),
    status VARCHAR(50),
    risk_score_updated INT,
    gateway_region VARCHAR(50),
    user_id VARCHAR(10),
    payment_method VARCHAR(50)
);

INSERT INTO transactions 
(transaction_id, transaction_date, merchant_name, raw_amount, currency, status, risk_score_updated, gateway_region, user_id, payment_method)
VALUES
('T001',STR_TO_DATE('01-03-2026','%d-%m-%Y'),'Alpha Mart',420000,'INR','Captured',62,'APAC','U001','UPI'),
('T002',STR_TO_DATE('01-03-2026','%d-%m-%Y'),'Alpha Mart',210000,'INR','Captured',55,'NOT FOUND','U002','Card'),
('T003',STR_TO_DATE('01-03-2026','%d-%m-%Y'),'Beta Stores',510000,'INR','Captured',71,'APAC','U003','NetBanking'),
('T004',STR_TO_DATE('02-03-2026','%d-%m-%Y'),'Beta Stores',160000,'INR','Failed E05 Timeout',68,'APAC','U004','Card'),
('T005',STR_TO_DATE('02-03-2026','%d-%m-%Y'),'Alpha Mart',390000,'INR','Captured',58,'NOT FOUND','U001','UPI'),
('T006',STR_TO_DATE('02-03-2026','%d-%m-%Y'),'Beta Stores',275000,'INR','Captured',64,'NOT FOUND','U005','Wallet'),
('T007',STR_TO_DATE('02-03-2026','%d-%m-%Y'),'Alpha Mart',450000,'INR','Chargeback',83,'APAC','U006','Card'),
('T008',STR_TO_DATE('03-03-2026','%d-%m-%Y'),'Beta Stores',340000,'INR','Captured',59,'NOT FOUND','U007','UPI'),
('T009',STR_TO_DATE('03-03-2026','%d-%m-%Y'),'Alpha Mart',125000,'INR','Captured',46,'APAC','U002','Wallet'),
('T010',STR_TO_DATE('03-03-2026','%d-%m-%Y'),'Beta Stores',610000,'INR','Captured',77,'NOT FOUND','U003','Card'),
('T011',STR_TO_DATE('03-03-2026','%d-%m-%Y'),'Alpha Mart',195000,'INR','Failed E05 Timeout',61,'NOT FOUND','U008','UPI'),
('T012',STR_TO_DATE('04-03-2026','%d-%m-%Y'),'Beta Stores',250000,'INR','Captured',61,'APAC','U009','Card'),
('T013',STR_TO_DATE('04-03-2026','%d-%m-%Y'),'Alpha Mart',310000,'INR','Captured',54,'APAC','U010','UPI'),
('T014',STR_TO_DATE('04-03-2026','%d-%m-%Y'),'Beta Stores',470000,'INR','Captured',73,'APAC','U001','NetBanking'),
('T015',STR_TO_DATE('04-03-2026','%d-%m-%Y'),'Alpha Mart',130000,'INR','Captured',52,'NOT FOUND','U002','Card'),
('T016',STR_TO_DATE('05-03-2026','%d-%m-%Y'),'Beta Stores',220000,'INR','Failed E05 Timeout',69,'NOT FOUND','U008','Card'),
('T017',STR_TO_DATE('05-03-2026','%d-%m-%Y'),'Beta Stores',180000,'INR','Failed E05 Timeout',72,'APAC','U008','Card'),
('T018',STR_TO_DATE('05-03-2026','%d-%m-%Y'),'Beta Stores',145000,'INR','Chargeback',86,'APAC','U008','UPI'),
('T019',STR_TO_DATE('05-03-2026','%d-%m-%Y'),'Alpha Mart',260000,'INR','Failed E05 Timeout',67,'APAC','U008','Wallet'),
('T020',STR_TO_DATE('05-03-2026','%d-%m-%Y'),'Alpha Mart',520000,'INR','Captured',75,'APAC','U005','UPI'),
('T021',STR_TO_DATE('06-03-2026','%d-%m-%Y'),'Beta Stores',330000,'INR','Captured',63,'NOT FOUND','U006','Card'),
('T022',STR_TO_DATE('06-03-2026','%d-%m-%Y'),'Alpha Mart',410000,'INR','Captured',60,'APAC','U007','UPI'),
('T023',STR_TO_DATE('01-03-2026','%d-%m-%Y'),'City Pharma',5200,'EUR','Captured',42,'EU','U003','Card'),
('T024',STR_TO_DATE('02-03-2026','%d-%m-%Y'),'Eco Home',6100,'EUR','Chargeback',65,'EU','U004','Card'),
('T025',STR_TO_DATE('03-03-2026','%d-%m-%Y'),'City Pharma',2800,'EUR','Captured',38,'EU','U005','Wallet'),
('T026',STR_TO_DATE('05-03-2026','%d-%m-%Y'),'Eco Home',3300,'EUR','Failed E05 Timeout',44,'EU','U006','NetBanking'),
('T027',STR_TO_DATE('01-03-2026','%d-%m-%Y'),'Delta Travels',7200,'USD','Captured',49,'US','U007','Card'),
('T028',STR_TO_DATE('02-03-2026','%d-%m-%Y'),'Delta Travels',3100,'USD','Captured',41,'US','U008','Card'),
('T029',STR_TO_DATE('04-03-2026','%d-%m-%Y'),'Delta Travels',2500,'USD','Chargeback',58,'US','U009','Wallet'),
('T030',STR_TO_DATE('06-03-2026','%d-%m-%Y'),'Delta Travels',1800,'USD','Failed E05 Timeout',47,'US','U010','UPI');

CREATE TABLE currency_rates (
    rate_date DATE,
    currency VARCHAR(10),
    usd_rate DECIMAL(10,4),
    PRIMARY KEY (rate_date, currency)
);

INSERT INTO currency_rates (rate_date, currency, usd_rate)
VALUES
(STR_TO_DATE('01-03-2026','%d-%m-%Y'),'INR',0.0119),
(STR_TO_DATE('01-03-2026','%d-%m-%Y'),'EUR',1.08),
(STR_TO_DATE('01-03-2026','%d-%m-%Y'),'USD',1),
(STR_TO_DATE('02-03-2026','%d-%m-%Y'),'INR',0.012),
(STR_TO_DATE('02-03-2026','%d-%m-%Y'),'EUR',1.09),
(STR_TO_DATE('02-03-2026','%d-%m-%Y'),'USD',1),
(STR_TO_DATE('03-03-2026','%d-%m-%Y'),'INR',0.0121),
(STR_TO_DATE('03-03-2026','%d-%m-%Y'),'EUR',1.08),
(STR_TO_DATE('03-03-2026','%d-%m-%Y'),'USD',1),
(STR_TO_DATE('04-03-2026','%d-%m-%Y'),'INR',0.012),
(STR_TO_DATE('04-03-2026','%d-%m-%Y'),'EUR',1.07),
(STR_TO_DATE('04-03-2026','%d-%m-%Y'),'USD',1),
(STR_TO_DATE('05-03-2026','%d-%m-%Y'),'INR',0.0118),
(STR_TO_DATE('05-03-2026','%d-%m-%Y'),'EUR',1.09),
(STR_TO_DATE('05-03-2026','%d-%m-%Y'),'USD',1),
(STR_TO_DATE('06-03-2026','%d-%m-%Y'),'INR',0.0119),
(STR_TO_DATE('06-03-2026','%d-%m-%Y'),'EUR',1.08),
(STR_TO_DATE('06-03-2026','%d-%m-%Y'),'USD',1);

CREATE TABLE merchants (
    merchant_id VARCHAR(10) PRIMARY KEY,
    merchant_name VARCHAR(100),
    account_manager VARCHAR(100),
    merchant_category VARCHAR(50),
    default_region VARCHAR(20)
);

INSERT INTO merchants (merchant_id, merchant_name, account_manager, merchant_category, default_region)
VALUES
('M001','Alpha Mart','Aisha Khan','Grocery','APAC'),
('M002','Beta Stores','Rohan Mehta','Electronics','APAC'),
('M003','City Pharma','Elena Rossi','Healthcare','EU'),
('M004','Delta Travels','Marcus Lee','Travel','US'),
('M005','Eco Home','Nina Weber','Home','EU');

CREATE TABLE users (
    user_id VARCHAR(10) PRIMARY KEY,
    user_name VARCHAR(100),
    signup_date DATE,
    user_region VARCHAR(50),
    risk_tier VARCHAR(20)
);

INSERT INTO users (user_id, user_name, signup_date, user_region, risk_tier)
VALUES
('U001','Aarav Shah',STR_TO_DATE('10-01-2026','%d-%m-%Y'),'India','medium'),
('U002','Meera Iyer',STR_TO_DATE('18-01-2026','%d-%m-%Y'),'India','low'),
('U003','Kabir Jain',STR_TO_DATE('22-01-2026','%d-%m-%Y'),'India','medium'),
('U004','Sofia Rossi',STR_TO_DATE('01-02-2026','%d-%m-%Y'),'Italy','low'),
('U005','Vikram Nair',STR_TO_DATE('04-02-2026','%d-%m-%Y'),'India','medium'),
('U006','Riya Gupta',STR_TO_DATE('08-02-2026','%d-%m-%Y'),'India','high'),
('U007','Noah Kim',STR_TO_DATE('12-02-2026','%d-%m-%Y'),'Singapore','medium'),
('U008','Ishaan Verma',STR_TO_DATE('15-02-2026','%d-%m-%Y'),'India','high'),
('U009','Emma Brooks',STR_TO_DATE('20-02-2026','%d-%m-%Y'),'USA','medium'),
('U010','Liam Carter',STR_TO_DATE('25-02-2026','%d-%m-%Y'),'USA','low');

SELECT * FROM transactions;
SELECT * FROM merchants;
SELECT * FROM users;
SELECT * FROM currency_rates;

-- Q1
SELECT 
    status, 
    COUNT(*) AS transaction_count
FROM transactions
GROUP BY status;

-- Q2
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

-- Q3
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
-- Q4
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

-- Q5
SELECT 
    t.merchant_name,
    SUM(CASE WHEN t.status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS chargeback_percent
FROM transactions t
GROUP BY t.merchant_name
HAVING (SUM(CASE WHEN t.status = 'Chargeback' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) > 1
ORDER BY chargeback_percent DESC;

-- Q6
SELECT 
    gateway_region,
    AVG(risk_score_updated) AS avg_risk_score,
    COUNT(*) AS txn_count
FROM transactions
GROUP BY gateway_region
HAVING AVG(risk_score_updated) > 50
   AND COUNT(*) > 20
ORDER BY avg_risk_score DESC;

-- Q7
SELECT 
    user_id,
    DATE_FORMAT(transaction_date, '%d-%m-%Y') AS txn_date,
    COUNT(*) AS failed_or_chargeback_count
FROM transactions
WHERE status IN ('Failed E05 Timeout', 'Chargeback')
GROUP BY user_id, txn_date
HAVING COUNT(*) >= 3
ORDER BY failed_or_chargeback_count DESC, txn_date;

-- Q8
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
