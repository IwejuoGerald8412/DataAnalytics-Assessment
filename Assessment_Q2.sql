-- Transaction Frequency Analysis
-- This query categorizes customers by their transaction frequency

WITH monthly_transactions AS (
    -- Calculate transaction counts per customer per month
    SELECT 
        s.owner_id,
        DATE_FORMAT(s.created_on, '%Y-%m-01') AS month,
        COUNT(*) AS transaction_count
    FROM 
        savings_savingsaccount s
    GROUP BY 
        s.owner_id, DATE_FORMAT(s.created_on, '%Y-%m-01')
)
SELECT 
    CASE 
        WHEN avg_monthly_transactions >= 10 THEN 'High Frequency'
        WHEN avg_monthly_transactions >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(DISTINCT owner_id) AS customer_count,
    ROUND(AVG(avg_monthly_transactions), 1) AS avg_transactions_per_month
FROM (
    -- Calculate average monthly transactions per customer
    SELECT 
        owner_id,
        AVG(transaction_count) AS avg_monthly_transactions
    FROM 
        monthly_transactions
    GROUP BY 
        owner_id
) AS customer_stats
GROUP BY 
    frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;
