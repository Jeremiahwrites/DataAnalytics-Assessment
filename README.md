
---

## Per-Question Explanations
  1. Project Overview: The project: is designed to measure your 
  ability to work with relational databases by writing SQL queries to solve business problems. The 
  assessment will test your knowledge of data retrieval, aggregation, joins, subqueries, and data 
  manipulation across multiple tables. The assessment is designed to evaluate both technical SQL skills and
  problem-solving methodology.
  2. Context: the database contains the following tables:
     
    ● users_customuser: customer demographic and contact information 
  
    ● savings_savingsaccount: records of deposit transactions 
  
    ● plans_plan: records of plans created by customers 
  
    ● withdrawals_withdrawal:  records of withdrawal transactions
   

### **Assessment_Q1.sql**  
**Task:** Identify high-value customers who have both a funded savings and investment plan.  

**Approach:**  
- Joined `users_customuser`, `savings_savingsaccount`, and `plans_plan` using `owner_id`.
- Filtered savings accounts where `confirmed_amount > 0` and plans where `is_a_fund = 1 AND confirmed_amount > 0`.
- Grouped by `owner_id` and counted distinct products.
- Summed up total deposits from savings.
- Sorted by total deposits in descending order.

**Challenges:**  
De-duplicating customers with multiple savings or investment records required careful aggregation.

---

### **Assessment_Q2.sql**  
**Task:** Analyze transaction frequency and categorize customers.

**Approach:**  
- Extracted the transaction date from `savings_savingsaccount`.
- Grouped transactions per customer per month using `DATE_TRUNC('month', transaction_date)` or equivalent.
- Calculated the average transactions per customer.
- Applied frequency categories based on thresholds:
  - High: ≥10/month
  - Medium: 3–9/month
  - Low: ≤2/month

**Challenges:**  
Ensuring monthly averages were accurately normalized across customers with varying account ages.

---

### **Assessment_Q3.sql**  
**Task:** Flag accounts with no inflow in the last 365 days.

**Approach:**  
- Retrieved latest transaction date per account from both `savings_savingsaccount` and `plans_plan`.
- Filtered to include only active accounts.
- Calculated days since the last transaction using `CURRENT_DATE - last_transaction_date`.
- Selected accounts where this duration exceeded 365 days.

**Challenges:**  
Aligning time zones and null-safe comparison logic to avoid excluding valid accounts.

---

### **Assessment_Q4.sql**  
**Task:** Estimate Customer Lifetime Value (CLV).

**Approach:**  
- Calculated tenure as months since the user’s signup date.
- Counted total transactions from `savings_savingsaccount`.
- Ordered results by estimated CLV in descending order.

**Challenges:**  
Accurately deriving tenure from `date_joined` and handling edge cases where tenure is zero.

---

## Notes

- All transaction amounts are stored in **kobo**, so conversion to **naira** is handled where necessary by dividing by 100.
- `owner_id` in savings and plans tables references `id` in `users_customuser`.
- Used CTEs (Common Table Expressions) and proper joins for clarity and modularity.

---

## How to Use

To test each SQL query:
1. Load the provided database into your SQL engine (e.g., PostgreSQL or MySQL).
2. Open each `.sql` file and execute the query.
3. Verify that the output matches the expected format.

---

## Challenges Encountered

- Handling monetary value units (kobo vs naira) accurately.
- Ensuring query performance when aggregating large transaction tables.
- Designing flexible date-based queries (e.g., for tenure and inactivity).

---

## Final Thoughts

This assessment was a valuable opportunity to demonstrate my SQL proficiency across realistic business scenarios. The problems required a balance of logic, optimization, and business understanding, which I enjoyed applying throughout.

---


  


