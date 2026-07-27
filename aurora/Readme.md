# AWS EC2 PostgreSQL Setup Guide

This guide provides the commands to install the PostgreSQL client on an AWS EC2 instance running Amazon Linux 2023 (AML2023) X86, configure the database connection string, and create a basic tasks table.

## 1. Install Postgres Client

Run the following command to install the PostgreSQL 15 client and server packages:

```bash
# Install Postgres Client on EC2 Instance AML2023 X86
sudo dnf install postgresql15.x86_64 postgresql15-server -y
```

## 2. Connection String URL

Use the following formats to connect to your remote PostgreSQL database (such as AWS RDS):

### Generic Format
```text
postgresql://[user[:password]@][netloc][:port][/[dbname][?param1=value1&...]
```

### Example AWS RDS Connection String
```text
postgresql://postgres:mypassword@mydb-instance-1.cv1x0r3utzcm.ca-central-1.rds.amazonaws.com:5432/mydatabase
```

## 3. Database Schema

Connect to your database instance and run the following SQL script to initialize the `tasks` table:

```sql
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    due_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```
