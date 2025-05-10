# Advanced SQL Queries for AirBnB Database

This directory contains SQL scripts with advanced queries for the AirBnB database project.

## Files

- `joins_queries.sql`: Collection of SQL queries demonstrating various JOIN operations
- `subqueries.sql`: Collection of SQL queries demonstrating various subquery techniques
- `aggregations_and_window_functions.sql`: Collection of SQL queries demonstrating aggregations and window functions

## Queries in `joins_queries.sql`

### 1. INNER JOIN Query
Retrieves all bookings and the respective users who made those bookings. This query demonstrates how to connect booking data with user information.

```sql
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    Booking b
INNER JOIN 
    User u ON b.user_id = u.user_id
ORDER BY 
    b.start_date DESC;
```

### 2. LEFT JOIN Query
Retrieves all properties and their reviews, including properties that have no reviews yet. This query demonstrates how to include all records from the left table (Property) regardless of whether they have matching records in the joined tables.

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night,
    r.review_id,
    r.rating,
    r.comment,
    u.first_name AS reviewer_first_name,
    u.last_name AS reviewer_last_name
FROM 
    Property p
LEFT JOIN 
    Review r ON p.property_id = r.property_id
LEFT JOIN 
    User u ON r.user_id = u.user_id
ORDER BY 
    p.property_id, r.created_at DESC;
```

### 3. FULL OUTER JOIN Query
Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user. This comprehensive join ensures no data is missed regardless of relationship status.

```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM 
    User u
FULL OUTER JOIN 
    Booking b ON u.user_id = b.user_id
ORDER BY 
    u.user_id, b.start_date DESC;
```

## Queries in `subqueries.sql`

### 1. Non-correlated Subquery
Retrieves all properties where the average rating is greater than 4.0. This query demonstrates how to use a subquery in the WHERE clause that operates independently of the outer query.

```sql
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night
FROM 
    Property p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            Review r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    )
ORDER BY 
    p.property_id;
```

### 2. Correlated Subquery
Finds users who have made more than 3 bookings. This query demonstrates how to use a subquery that references the outer query, executing once for each row processed by the outer query.

```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    User u
WHERE 
    3 < (
        SELECT 
            COUNT(b.booking_id)
        FROM 
            Booking b
        WHERE 
            b.user_id = u.user_id
    )
ORDER BY 
    u.user_id;
```

## Queries in `aggregations_and_window_functions.sql`

### 1. Aggregation with GROUP BY
Calculates the total number of bookings made by each user using the COUNT function and GROUP BY clause. This query demonstrates how to aggregate data to get summary statistics per user.

```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY 
    total_bookings DESC;
```

### 2. Window Functions for Ranking
Uses window functions (RANK and ROW_NUMBER) to rank properties based on the total number of bookings they have received. This query demonstrates how to perform analytics operations that maintain row-level details while also providing aggregate information.

```sql
SELECT 
    p.property_id,
    p.name,
    p.location,
    p.price_per_night,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_row_number
FROM 
    Property p
LEFT JOIN 
    Booking b ON p.property_id = b.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.price_per_night
ORDER BY 
    total_bookings DESC;
```

## Usage

These queries can be executed against the AirBnB database to perform complex data retrieval operations. Each query demonstrates different SQL techniques and their practical applications in retrieving meaningful data from the database.

## Key Concepts

- **INNER JOIN**: Returns records that have matching values in both tables
- **LEFT JOIN**: Returns all records from the left table and matching records from the right table
- **FULL OUTER JOIN**: Returns all records when there is a match in either the left or right table
- **Non-correlated Subquery**: A subquery that can be executed independently of the outer query
- **Correlated Subquery**: A subquery that references columns from the outer query and must be re-evaluated for each row processed by the outer query
- **Aggregation Functions**: Functions like COUNT, SUM, AVG that calculate a single value from a set of values
- **GROUP BY**: Clause used to group rows that have the same values in specified columns
- **Window Functions**: Functions that perform calculations across a set of table rows related to the current row
- **RANK**: Window function that assigns a rank to each row within a partition of a result set
- **ROW_NUMBER**: Window function that assigns a sequential integer to each row