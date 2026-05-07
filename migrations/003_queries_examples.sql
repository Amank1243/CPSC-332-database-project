-- Minimum requirement:

--     Include TRIGGER: at least 1 trigger
--     Include VIEW: at least 1 view
--     Include READ (SELECT): at least 6 queries including JOINs
--     Include UPDATE: at least 6 queries
--     Include DELETE: at least 6 queries

-- Total minimum: 19 queries.

-- Each query must include a short comment describing what it does 

-------------------------------------- Triggers -----------------------------------------------

-- Automatically updates the account balance whenever a new transaction is inserted.
-- Uses the signed amount directly (positive = credit, negative = debit).
create or replace function update_account_balance()
returns trigger as $$
begin
  update account
  set balance = (
    select coalesce(sum(bt.amount), 0)  -- We are adding the amounts from each bank transaction all up, and using coalesce to avoid getting null. We will get 0 instead if given
    from banktransaction bt
    where bt.accountid = new.accountid
  )

  where account.accountid = new.accountid;
  return new;
end;
$$ language plpgsql;

create trigger trg_update_balance
after insert on bankTransaction
for each row
execute function update_account_balance();
-- Some limitations of the trigger is that it only works on inserts. It would've been cool to include a working balance which works on updates and deletes

-------------------------------------- Views -----------------------------------------------

-- Creates a view that shows customers with their account information.
create or replace view customer_account_summary as
select c.customerid, c.fullname, c.email, a.accountid, a.accounttype, a.balance, a.status
from customer c
inner join account a on c.customerid = a.customerid;

-------------------------------------- Reads -----------------------------------------------

-- Calculates the balance of accounts. Shows the full name, customerid, and balance.
-- Useful if an employee suspects that the database is incorrectly calculating the balance of customers in account.
select c.fullname, a.customerid, sum(bt.amount) as balance
from customer c
inner join account a on a.customerid = c.customerid
inner join bankTransaction bt on bt.accountid = a.accountid
group by c.fullname, a.customerid;

-- Shows customer account details using the customer account summary view.
select *
from customer_account_summary;

-- Shows each customer and the branches they are connected to.
select c.fullname, b.branchname, b.location
from customer c
inner join customerbranch cb on c.customerid = cb.customerid
inner join branch b on cb.branchid = b.branchid;

-- Shows transactions with customer names and transaction type names.
select bt.transactionid, c.fullname, tt.typename, bt.amount, bt.description
from bankTransaction bt
inner join account a on bt.accountid = a.accountid
inner join customer c on a.customerid = c.customerid
inner join transactiontype tt on bt.typeid = tt.typeid;

-- Shows employees and the branch where each employee works.
select e.fullname, e.jobtitle, b.branchname, b.location
from employee e
inner join branch b on e.branchid = b.branchid;

-- Shows accounts that currently have a negative balance.
select c.fullname, a.accountid, a.accounttype, a.balance
from customer c
inner join account a on c.customerid = a.customerid
where a.balance < 0;

-- Shows total transaction count and net amount per account.
select a.accountid, c.fullname, a.accounttype,
       count(bt.transactionid) as total_transactions,
       sum(bt.amount) as net_amount
from account a
inner join customer c on a.customerid = c.customerid
left join bankTransaction bt on a.accountid = bt.accountid
group by a.accountid, c.fullname, a.accounttype;

-- Shows all deposit transactions with the customer name and date.
select c.fullname, bt.transactionid, bt.amount, bt.transactiondate
from bankTransaction bt
inner join account a on bt.accountid = a.accountid
inner join customer c on a.customerid = c.customerid
inner join transactiontype tt on bt.typeid = tt.typeid
where tt.typename = 'deposit'
order by bt.transactiondate;

-- Shows customers who are not linked to any branch.
select c.customerid, c.fullname, c.email
from customer c
left join customerbranch cb on c.customerid = cb.customerid
where cb.branchid is null;

-- Shows each branch alongside how many employees work there.
select b.branchname, b.location, count(e.employeeid) as employee_count
from branch b
left join employee e on b.branchid = e.branchid
group by b.branchid, b.branchname, b.location
order by employee_count desc;

-- Shows the most recent transaction for each account.
select a.accountid, c.fullname, tt.typename,
       bt.amount, bt.transactiondate
from bankTransaction bt
inner join account a on bt.accountid = a.accountid
inner join customer c on a.customerid = c.customerid
inner join transactiontype tt on bt.typeid = tt.typeid
where bt.transactiondate = (
  select max(bt2.transactiondate)
  from bankTransaction bt2
  where bt2.accountid = bt.accountid
);

-- Shows suspended accounts along with their most recent transaction.
select c.fullname, a.accountid, a.balance,
       bt.amount as last_amount, bt.description, bt.transactiondate
from account a
inner join customer c on a.customerid = c.customerid
inner join bankTransaction bt on a.accountid = bt.accountid
where a.status = 'suspended'
  and bt.transactiondate = (
    select max(bt2.transactiondate)
    from bankTransaction bt2
    where bt2.accountid = a.accountid
  );

-------------------------------------- Updates -----------------------------------------------

-- Updates bank transaction amounts to have the correct sign depending on transaction type.
-- Deposits, interest, and refunds should be positive. Withdrawals, transfers, payments, and fees should be negative.
update bankTransaction bt
set amount = case
  when bt.typeid in (1, 6, 7) and (bt.amount < 0) then bt.amount * -1
  when bt.typeid in (2, 3, 4, 5) and (bt.amount > 0) then bt.amount * -1
  else bt.amount
end;

-- Updates a customer's phone number.
update customer
set phonenumber = '555-111-2222'
where customerid = 1;

-- Updates one account status to suspended.
update account
set status = 'suspended'
where accountid = 103;

-- Promotes an employee to branch manager.
update employee
set jobtitle = 'branch manager'
where employeeid = 204;

-- Updates the phone number for a branch.
update branch
set phonenumber = '555-900-9999'
where branchid = 1;

-- Reactivates a previously suspended account.
update account
set status = 'active'
where accountid = 105;

-------------------------------------- Deletes -----------------------------------------------

-- Deletes a specific transaction by id.
delete from bankTransaction
where transactionid = 306;

-- Deletes all transactions for a specific account before closing it.
delete from bankTransaction
where accountid = 105;

-- Removes a specific customer-branch association.
delete from customerbranch
where customerid = 1 and branchid = 5;

-- Removes all customer associations for a specific branch.
delete from customerbranch
where branchid = 4;

-- Deletes a specific employee from the records.
delete from employee
where employeeid = 205;

-- Deletes all accounts with a closed status.
delete from account
where status = 'closed';