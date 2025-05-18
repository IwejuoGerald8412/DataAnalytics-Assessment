-- Account Inactivity Alert
-- Identifies active accounts with no transactions in the last year

SELECT 
    p.id AS plan_id,
    p.owner_id,
    IF(p.is_a_fund = 1, 'Investment', 'Savings') AS type,
    DATE(MAX(s.created_on)) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(s.created_on)) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    p.amount > 0  -- Active accounts only
GROUP BY 
    p.id, p.owner_id, p.is_a_fund
HAVING 
    last_transaction_date IS NULL 
    OR DATEDIFF(CURRENT_DATE, last_transaction_date) > 365
ORDER BY 
    inactivity_days DESC;
