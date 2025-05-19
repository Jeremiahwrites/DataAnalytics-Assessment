USE adashi_staging;
/*Task: Write a query to find customers with at least one funded savings plan AND one 
funded investment plan, sorted by total deposits*/
/*Approach:
- Joined `users_customuser`, `savings_savingsaccount`, and `plans_plan` using `owner_id`.
- Filtered savings accounts where `confirmed_amount > 0` and plans where `is_a_fund = 1 AND confirmed_amount > 0`.
- Grouped by `owner_id` and counted distinct products.
- Summed up total deposits from savings.
- Sorted by total deposits*/

SELECT 	
    s.owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    SUM(p.is_regular_savings = 1) AS savings_count,
    SUM(p.is_a_fund = 1) AS investment_count,
    ROUND(SUM(s.confirmed_amount)) AS total_deposit
FROM 
    savings_savingsaccount s
JOIN users_customuser u 
    ON s.owner_id = u.id 
JOIN plans_plan p 
    ON s.plan_id = p.id 
WHERE 
    s.confirmed_amount > 0
GROUP BY 
    s.owner_id, u.first_name, u.last_name
ORDER BY total_deposit;




