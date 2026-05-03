-- enums (We only have one, for transactionType)
create type transaction_type as enum (
  'deposit',
  'withdrawal',
  'transfer',
  'payment',
  'fee',
  'interest',
  'refund'
);

-- notes
-- not null means that no null values are allowed, meaning that the customer must have all of these attributes
-- 

------------- Queries for creating tables -------------------------

create table Customer (
  customerId int primary key,
  fullName varchar(100) not null,
  email varchar(255) not null unique,
  phoneNumber varchar(20) not null,
  address varchar(255) not null,
  dateCreated date not null
);

create table Branch (
  branchId int primary key,
  branchName varchar(100) not null,
  location varchar(255) not null,
  phoneNumber varchar(20) not null
);

create table TransactionType (
  typeId int primary key,
  typeName transaction_type not null unique -- We want transaction_type to be unique because the transactionType table is meant to be a lookup table which references all the possible transaction types, meaning duplicates are redundant
);

create table Account (
  accountId int primary key,
  customerId int not null,
  accountType varchar(50) not null,
  balance decimal not null,
  dateopened date not null,
  status varchar(20) not null,
  
-- this is saying customerId in the account table is a foreign key, and references the customerId in the customer table
-- without this, an employee can potentially input data where the customer id in the customer table does not exist when inputting data into the account table, meaning the customer does not exist rendering the data pointless and false
  -- The constraint for the foreign key is called a foreign key restraint. It enforces data integrity by making sure nothing will cause the tables to break with the linkage caused by the foreign key
  constraint fk_account_customer
    foreign key (customerId) references Customer(customerid)
  constraint check_balance_is_not_negative
    check (balance >= 0), -- check is used to limit values which can be placed in columns
  constraint check_account_status
    check (status in ('active', 'closed', 'suspended'))
);

create table employee (
  employeeid int primary key,
  branchid int not null,
  fullname varchar(100) not null,
  jobtitle varchar(50) not null,
  email varchar(255) not null unique,
  phonenumber varchar(20) not null,
  hiredate date not null,
  constraint fk_employee_branch -- foreign key constraint
    foreign key (branchid) references branch(branchid)
);

create table banktransaction (
  transactionid int primary key,
  accountid int not null,
  typeid int not null,
  amount decimal not null,
  description varchar(300),
  transactiondate timestamp not null,
  constraint fk_transaction_account
    foreign key (accountid) references account(accountid),
  constraint fk_transaction_type
    foreign key (typeid) references transactiontype(typeid),
  constraint check_transaction_amount_is_positive
    check (amount > 0)
);




