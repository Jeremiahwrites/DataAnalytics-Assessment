/*Task: Calculate the average number of transactions per customer per month and 
categorize them: 
● "High Frequency" (≥10 transactions/month) 
● "Medium Frequency" (3-9 transactions/month) 
● "Low Frequency" (≤2 transactions/month)*/

/*Approach: 
- Extracted the transaction date from `savings_savingsaccount`.
- Grouped transactions per customer per month using `DATE_TRUNC('month', transaction_date)` or equivalent.
- Calculated the average transactions per customer.
- Applied frequency categories based on thresholds:
  - High: ≥10/month
  - Medium: 3–9/month
  - Low: ≤2/month*/
  
CREATE TABLE monthly_transaction AS 
SELECT
	owner_id,
    MONTH(transaction_date),
    COUNT(*) AS monthly_tx 
FROM savings_savingsaccount
GROUP BY 1,2;
     
CREATE TABLE avg_tx_per_customer AS
	SELECT 
		owner_id,  
        AVG(monthly_tx)    
        AS avg_monthly_tx   
	FROM  monthly_transaction    
    GROUP BY owner_id;
CREATE TABLE categorised   AS   
	SELECT     
		owner_id,
        CASE     
			WHEN avg_monthly_tx >= 10  THEN 'high frequency'    
            WHEN avg_monthly_tx    
            BETWEEN 3 AND 9 THEN 'medium frequency'  
            ELSE 'low frquency'   
		END AS avg_monthly_tx_category 
	FROM avg_tx_per_customer;
    
SELECT     
	avg_monthly_tx_category AS frequency_category,
	count(*)  AS customer_count, 
    ROUND(AVG(avg_monthly_tx), 1) AS avg_transaction_per_month 
FROM avg_tx_per_customer   
JOIN categorised   
USING (owner_id)
GROUP BY 1;








