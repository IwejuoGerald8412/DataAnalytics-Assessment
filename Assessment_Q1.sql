-- High-Value Customers with Multiple Products
-- This query finds custumers with at least one funded savings and one funded investment plan

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT s.id) AS savings_count,
    COUNT(DISTINCT p.id) AS investment_count,
    SUM(s.confirmed_amount) / 100.0 AS total_deposits  -- Convert from kobo to naira
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
JOIN 
    plans_plan p ON u.id = p.owner_id AND p.is_regular_savings = 0 AND p.is_a_fund = 1
WHERE 
    s.confirmed_amount > 0  -- Funded savings account
    AND p.amount > 0  -- Funded investment plan
GROUP BY 
    u.id, u.first_name, u.last_name
HAVING 
    COUNT(DISTINCT s.id) >= 1  -- At least one savings account
    AND COUNT(DISTINCT p.id) >= 1  -- At least one investment plan
ORDER BY 
    total_deposits DESC;
