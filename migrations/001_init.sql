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

