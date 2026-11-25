# Gym Database — MySQL Portfolio Project

An in-progress MySQL project that models a gym with multiple locations.
I'm building it in stages to practice relational database design, stored
procedures, and SQL reporting.

## Current progress

- Designed seven tables for locations, members, memberships, payments,
  classes, class registrations, and employees.
- Created and ran a stored procedure to seed three gym locations.
- Drafted six additional seed procedures. The next milestone is to run
  and verify the complete dataset from a fresh database.

## Run locally

Open the scripts in MySQL Workbench and run them in this order:

1. [`01_create_schema.sql`](/01_create_schema.sql) creates `gym_db_sample`
   and its tables. Run this on a MySQL instance where the database name
   is available.
2. [`02_seed_locations.sql`](/02_seed_locations.sql) creates the
   location seed procedure.
3. [`03_seed_gym_data.sql`](/03_seed_gym_data.sql) creates the remaining
   seed procedures.
4. [`04_load_sample_data.sql`](/04_load_sample_data.sql) calls all seven
   procedures in dependency order.

Check the location data:

```sql
SELECT location_id, name, city, state
FROM gym_db_sample.Locations
ORDER BY location_id;
```

The location seed contains three fictional Chicago gyms: Northside Fitness,
West Loop Fitness, and Lakeshore Fitness.

## Design notes

- Location IDs are fixed in the sample data so members, classes, and employees
  can reference the same locations across runs.
- `Memberships.member_id` is unique, so the current schema allows one
  membership row per member. Supporting membership history would require
  revisiting that constraint.
- The payment seed reads both the member ID and the price from the
  associated membership.

## Next milestones

- Verify the full setup and check that running the seed calls twice leaves
  the sample row counts unchanged.
- Add reporting queries for membership counts by location, collected revenue,
  and class attendance.

 ## Database administration exercises

- [Payment integrity audit and migration](/05_payment_integrity_demo.sql)
  demonstrates how a composite foreign key prevents payments from referencing
  another member's membership. Run the sections in order on a fresh, seeded
  test database. The final insert is expected to fail with MySQL error 1452.
