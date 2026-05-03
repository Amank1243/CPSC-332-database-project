-- enums (We only have one, for transactionType)
create type transactionType as enum (
  'deposit',
  'withdrawal',
  'transfer',
  'payment',
  'fee',
  'interest',
  'refund'
);


------------- Queries for creating tables -------------------------

create table Customer (
  customerId int primary key,
  fullName varchar(100),
  email varchar(255),
  phoneNumber varchar(20),
  address varchar(255),
  dateCreated date
);

create table Branch (
  branchId int primary key,
  branchName varchar(100),
  location varchar(255),
  phoneNumber varchar(20)
);

create table TransactionType (
  typeId int primary key,
  typeName transaction_types
);

create table Account (
  accountId int primary key,
  customerId int,
  accountType varchar(50),
  balance decimal,
  dateopened date,
  status varchar(20),
  
-- this is saying customerId in the account table is a foreign key, and references the customerId in the customer table
-- without this, an employee can potentially input data where the customer id in the customer table does not exist when inputting data into the account table, meaning the customer does not exist rendering the data pointless and false
  foreign key (customerId) references Customer(customerid)
)


