# Banking Database Project

## Project Overview

This project is a PostgreSQL banking database designed to model the core operations of a small banking system. The database stores information about customers, bank branches, employees, customer accounts, transaction types, and bank transactions.

The project includes:

- Database schema creation
- Custom enum type
- Primary key and foreign key constraints
- Check constraints
- Junction table for many-to-many relationships
- Indexes for faster lookups
- Data seeding
- Trigger for automatic balance updates
- View for simplified customer account reporting
- Read, update, and delete queries

The database was designed to demonstrate relational database concepts such as normalization, referential integrity, constraints, joins, views, triggers, and query operations.

---

## Database Theme

The database represents a banking system where:

- Customers can own bank accounts.
- Customers can be connected to multiple branches.
- Branches can have multiple customers.
- Employees work at specific branches.
- Accounts can have many transactions.
- Each transaction has a transaction type, such as deposit, withdrawal, payment, fee, interest, or refund.
- Account balances can be updated automatically when new transactions are inserted.

---

## Technologies Used

- PostgreSQL
- Supabase
- SQL
- PL/pgSQL

---

## How to run it for yourself
Open up a new project in supabase. Paste the following files inorder, into the sql editor:
- 001_init.sql
- 002_seed_data.sql

You now have a database with data. Now run the queries in the 003_queries_examples file, preferably in the order of
- triggers
- views
- queries

You can also run your own queries and mess around with it

Enjoy!