/*Task: Find all active accounts (savings or investments) with no transactions in the last 1 
year (365 days)*/

/*Approach: 
- Retrieved latest transaction date per account from both `savings_savingsaccount` and `plans_plan`.
- Filtered to include only active accounts.
- Calculated days since the last transaction using `CURRENT_DATE - last_transaction_date`.
- Selected accounts where this duration exceeded 365 days.*/

create table all_account as
SELECT 	
	s.id as plan_id,
    s.owner_id,
    s.transaction_date,
    p.is_regular_savings AS savings_type,
    p.is_a_fund AS investment_type
FROM 
    savings_savingsaccount s
JOIN plans_plan p 
    ON s.plan_id = p.id;
    
alter table all_account
add column type varchar(20)
generated always as (
	case 
		when savings_type = 1 then 'Savings'
        when investment_type = 0 then 'Investment'
	end);
#select* from all_account

create table latest_transaction as
select 
	plan_id,
	owner_id,
    type,
    max(transaction_date) as last_transaction_date
from all_account
group by 1,2,3;

select 
	plan_id,
	owner_id,
    type,
    last_transaction_date,
    datediff(current_date, last_transaction_date) as inactivity_days
from latest_transaction
where last_transaction_date < current_date - interval 365 day;

