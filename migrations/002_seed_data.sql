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

------------------------------- Data for customers -------------------------------
insert into customer (customerid, fullname, email, phonenumber, address, datecreated)
values
  (1, 'Lebron James', 'lebron.@email.com', '123-345-7890', '123 Main St, Springfield', '2026-05-01'),
  (2, 'Theo Von', 'Theo.@email.com', '123-345-7890', '456 Oak Ave, Springfield', '2026-05-01'),
  (3, 'Derrick Rose', 'dRose.@email.com', '123-345-7890', '789 Main St, Riverton', '2026-05-02'),
  (4, 'Tyler Blevins', 'tyler@email.com', '123-345-7890', '123 Cedar Ln, Riverton', '2026-05-02');