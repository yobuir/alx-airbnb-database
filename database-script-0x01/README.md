# Database Schema

## Description

This directory contains the SQL script used to define the database schema for the Airbnb clone project. It includes all entity definitions, constraints, and performance indexes.

## Files

- `schema.sql`: Contains the SQL DDL statements to create tables, keys, constraints, and indexes.

## Tables

- `User`
- `Property`
- `Booking`
- `Payment`
- `Review`
- `Message`

## Features

- Enforced data integrity via primary and foreign key constraints.
- Use of appropriate data types.
- Indexed frequently queried fields for performance.

## How to Run

Run the script in a PostgreSQL-compatible SQL environment:

```bash
psql -U your_user -d your_database -f schema.sql
