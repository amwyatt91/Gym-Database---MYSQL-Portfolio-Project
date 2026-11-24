CREATE PROCEDURE DD_locations()
BEGIN
    INSERT INTO Locations (location_id, name, address, city, state, zip_code)
    SELECT seed.location_id, seed.name, seed.address,
           seed.city, seed.state, seed.zip_code
    FROM (
        SELECT 1 AS location_id, 'Northside Fitness' AS name,
               '100 Sample Avenue' AS address, 'Chicago' AS city,
               'IL' AS state, 60614 AS zip_code
        UNION ALL
        SELECT 2, 'West Loop Fitness', '200 Demo Street',
               'Chicago', 'IL', 60607
        UNION ALL
        SELECT 3, 'Lakeshore Fitness', '300 Example Drive',
               'Chicago', 'IL', 60657
    ) AS seed
    WHERE NOT EXISTS (
        SELECT 1
        FROM Locations AS existing
        WHERE existing.location_id = seed.location_id
    );
END