-- Customer Lifetime Value (CLV) Estimation
-- Calculates estimated CLV based on transaction history

SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND(
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()), 0)) * 12 * 
        (0.001 * AVG(s.confirmed_amount / 100.0)),  -- 0.1% profit per transaction in naira
        2
    ) AS estimated_clv
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
WHERE 
    s.confirmed_amount > 0  -- Only funded transactions
GROUP BY 
    u.id, u.first_name, u.last_name, u.date_joined
ORDER BY 
    estimated_clv DESC
LIMIT 1000;
