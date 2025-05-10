# Database Sample Data

## Description

This directory contains SQL scripts that populate the Airbnb database with realistic test data. This data enables testing of queries, UI features, and backend logic.

## Files

- `seed.sql`: SQL INSERT statements to populate all major tables (User, Property, Booking, Payment, Review, Message).

## How to Run

Make sure you’ve already created the database schema using `schema.sql`.

Then run:

```bash
psql -U your_user -d your_database -f seed.sql
