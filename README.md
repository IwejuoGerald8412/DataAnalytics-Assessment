## DataAnalytics-assessment

This repository contains my solutions to the Data analytics assessment questions. 
Below are explanations of my approach for each question and challenges I faced.

### Question 1: High-Value Customers with Multiple Products

**Approach**:
- Joined the users table with both savings and plans tables
- Filtered for regular savings (is_regular_savings = 1) and investment plans (is_a_fund = 1)
- Only included funded accounts (confirmed_amount > 0)
- Grouped by customer and counted their products
- Converted amounts from kobo to naira by dividing by 100
- Sorted by total deposits to highlight highest-value customers

**Challenge**: Ensuring we only count distinct plans/accounts per customer and properly converting currency.

### Question 2: Transaction Frequency Analysis

**Approach**:
- Created a CTE to calculate transactions per customer per month
- Calculated average monthly transactions for each customer
- Categorized customers based on their average transaction frequency
- Aggregated results by frequency category

**Challenge**: Handling the date truncation correctly and ensuring the categorization logic was accurate.

## Question 3: Account Inactivity Alert

**Approach**:
- Created a CTE to find the most recent transaction date for each account
- Considered both savings and withdrawal transactions
- Calculated inactivity days by comparing to current date
- Filtered for accounts with no activity in the last year

**Challenge**: Properly handling NULL values for accounts with no transactions and ensuring we consider both deposit and withdrawal transactions.

### Question 4: Customer Lifetime Value (CLV) Estimation

**Approach**:
- Calculated account tenure in months
- Counted all transactions for each customer
- Applied the CLV formula with 0.1% profit assumption
- Converted amounts from kobo to naira
- Ordered by estimated CLV to show most valuable customers first

**Challenge**: Handling division by zero for new customers and ensuring the profit calculation was accurate.

### Overall Challenges
The main challenges were:
1. Understanding the database schema and relationships between tables
2. Understanding the questions and the best approach to finding the solutions
3. Properly converting currency values from kobo to naira
4. Handling edge cases like new customers with zero tenure
5. Ensuring all queries were optimized for performance
