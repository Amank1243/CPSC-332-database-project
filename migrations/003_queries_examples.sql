-- Minimum requirement:

--     Include TRIGGER: at least 1 trigger
--     Include VIEW: at least 1 view
--     Include READ (SELECT): at least 6 queries including JOINs
--     Include UPDATE: at least 6 queries
--     Include DELETE: at least 6 queries

-- Total minimum: 19 queries.

-- Each query must include a short comment describing what it does 

-------------------------------------- Triggers -----------------------------------------------

-------------------------------------- Views -----------------------------------------------

-------------------------------------- Reads -----------------------------------------------

-- Calculates the balance of accounts. Shows the full name, customerid, and balance
-- Useful if an employee suspects that the database is incorrectly calculating the balance of customers in account
select c.fullname, a.customerid ,SUM(bt.amount) as balance
from customer c 
inner join account a on a.customerid = c.customerid
inner join banktransaction bt on bt.accountid = a.accountid
group by c.fullname, a.customerid;

-------------------------------------- Updates -----------------------------------------------
-- Update bank transaction amount to have a swapped sign depending on whether or not money is being taken away or given to the account
update banktransaction bt
set amount = case
when bt.typeid in (1, 6, 7) and (bt.amount < 0) then bt.amount * -1 
when bt.typeid in (2,3,4,5) and (bt.amount > 0) then bt.amount * -1
else bt.amount
end; 
-- Deletes
