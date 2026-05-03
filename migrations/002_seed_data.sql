---------------- Data seeding ------------
-- Use template provided by the prof's github example
-- Data must adhere to the constraints we set, being:
-- no duplicate customer emails
-- no duplicate employee emails
-- no duplicate branch phone numbers
-- no negative balances
-- no transaction amount of 0 or less
-- status must be one of 'active', 'closed', 'suspended'
-- Primary keys must all be unique

-- The order which you insert the data also matters, because some branches depend (reference) others

------------------------------- Data for customers -------------------------------
insert into customer (customerid, fullname, email, phonenumber, address, datecreated)
values
  (1, 'Lebron James', 'lebron.@email.com', '123-345-7890', '123 Main St, Springfield', '2026-05-01'),
  (2, 'Theo Von', 'Theo.@email.com', '123-345-7890', '456 Oak Ave, Springfield', '2026-05-01'),
  (3, 'Derrick Rose', 'dRose.@email.com', '123-345-7890', '789 Main St, Riverton', '2026-05-02'),
  (4, 'Tyler Blevins', 'tyler@email.com', '123-345-7890', '123 Cedar Ln, Riverton', '2026-05-02');

------------------------------- Data for branch -------------------------------
insert into branch (branchid, branchname, location, phonenumber)
values
  (1, 'north b', '100 bank st, springfield', '555-900-1000'),
  (2, 'south b', '200 market ave, riverton', '555-900-2000'),
  (3, 'east b', '300 elm st, springfield', '555-900-3000'),
  (4, 'west b', '400 lake rd, riverton', '555-900-4000');

------------------------------- Data for transaction type -------------------------------
insert into transactiontype (typeid, typename)
values
  (1, 'deposit'),
  (2, 'withdrawal'),
  (3, 'transfer'),
  (4, 'payment'),
  (5, 'fee'),
  (6, 'interest'),
  (7, 'refund');
-- Note that the typename has to match the values in our enum like we specified in the table

------------------------------- Data for account -------------------------------

-- Some notes: Accountid must be unique as specified by the constraint 'unique' in our table
--  account.customerId depends on customer.customerid, hence why the data is inserted after
-- 
insert into account (accountid, customerid, accounttype, balance, dateopened, status)
values
  (101, 1, 'checking', 2400.00, '2026-05-01', 'active'),
  (102, 1, 'savings', 8000.00, '2026-05-02', 'active'),
  (103, 2, 'savings', 2300.00, '2026-05-02', 'active'),
  (104, 3, 'savings', 10000.00, '2026-05-03', 'active'),
  (105, 4, 'checking', 10.00, '2026-05-03', 'suspended');

  