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

-- Data is viewed in the table editor in supabase

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

-- Some notes: Accountid must be unique as specified by it being a primary key.
--  account.customerId depends on customer.customerid, hence why the data is inserted after
-- 
insert into account (accountid, customerid, accounttype, balance, dateopened, status)
values
  (101, 1, 'checking', 2400.00, '2026-05-01', 'active'),
  (102, 1, 'savings', 8000.00, '2026-05-02', 'active'),
  (103, 2, 'savings', 2300.00, '2026-05-02', 'active'),
  (104, 3, 'savings', 10000.00, '2026-05-03', 'active'),
  (105, 4, 'checking', 10.00, '2026-05-03', 'suspended');

  
------------------------------- Data for employee -------------------------------

-- Note that the employee id's are unique and the branch id's already exist in the branch data created above
insert into employee (employeeid, branchid, fullname, jobtitle, email, phonenumber, hiredate)
values
  (201, 1, 'Tony Soprano', 'branch manager', 'tony.sop@bank.com', '555-800-1001', '2024-01-15'),
  (202, 2, 'Jennifer Melfi', 'bank teller', 'jenny.@bank.com', '555-800-1002', '2024-03-10'),
  (203, 3, 'Carmela Soprano', 'loan officer', 'carmela.@bank.com', '555-800-2001', '2024-02-20'),
  (204, 4, 'Saul Goodman', 'bank teller', 'b4stLowyah.@bank.com', '555-800-3001', '2024-04-05'),
  (205, 4, 'Jimmy McGill', 'assistant manager', 'slippinJimmy.@bank.com', '555-800-4001', '2024-05-12');


------------------------------- Data for customerbranch (junction table) -------------------------------
-- Notice all values exist already in customer.customerid and branch.branchid. Any data which does not exist already will fail due to the foreign key constraint
insert into customerbranch (customerid, branchid)
values
  (1, 1),
  (1, 2),
  (2, 1),
  (3, 3),
  (4, 2),
  (4, 4);

------------------------------- Data for bank transaction -------------------------------
-- The data for bank transaction is last because it depends on account and transactiontype
-- type id refers to the transaction type table, which has all possible transaction types listed from 1-7
-- account id refers to account.accountid, and must match said ids
  insert into banktransaction (transactionid, accountid, typeid, amount, description, transactiondate)
values
  (301, 101, 1, 500.00, 'cash deposit', '2026-05-01'),
  (302, 101, 2, 100.00, 'atm cash withdrawal', '2026-05-02'),
  (303, 102, 4, 25.00, 'income tax payment', '2026-05-03'),
  (304, 103, 4, 75.00, 'rent payment', '2026-05-03'),
  (305, 104, 1, 1000.00, 'paycheck deposit', '2026-05-04'),
  (306, 105, 5, 15.00, 'maintenance fee', '2026-05-04'),
  (307, 101, 4, 200.00, 'rent payment', '2026-05-05');
  
