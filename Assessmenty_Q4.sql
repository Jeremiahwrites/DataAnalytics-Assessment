/*Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction 
value, calculate: 
● Account tenure (months since signup) 
● Total transactions 
● Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * 
avg_profit_per_transaction) 
● Order by estimated CLV from highest to lowest */

/*Approach:
- Calculated tenure as months since the user’s signup date.
- Counted total transactions from `savings_savingsaccount` */

create table transaction_data as
select 
	owner_id,
    sum(confirmed_amount) as total_transaction
from savings_savingsaccount
group by 1;

create table user_tenure as 
select 
	id as customer_id,
	CONCAT(first_name,' ',last_name) AS name,
    timestampdiff(month, date_joined, current_date) as tenure_months
from users_customuser;

create table Customer_Lifetime_Value_Estimation as
select 
	customer_id,
    name,
    tenure_months,
    coalesce(total_transaction, 0) as total_transactions,
    round(((total_transaction/tenure_months)*12*0.001)/100.0,2) as estimated_clv
from user_tenure
left join transaction_data on user_tenure.customer_id=transaction_data.owner_id;

select* 
from customer_lifetime_value_estimation
order by estimated_clv desc;


    