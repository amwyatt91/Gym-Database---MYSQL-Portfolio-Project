##CALL IN ORDER##
## MAKE SURE TO VERIFY AS YOU GO, CODE INCLUDED##

CALL seed_locations();

SELECT location_id, name, address, city, state, zip_code, created_at
FROM Locations
WHERE location_id IN (1, 2, 3)
ORDER BY location_id;

#####

CALL seed_members();
CALL seed_memberships();
CALL seed_payments();

SELECT
    p.payment_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name,
    ms.membership_type,
    p.amount,
    p.pay_status
FROM Payments AS p
JOIN Memberships AS ms ON ms.membership_id = p.membership_id
JOIN Members AS m ON m.member_id = p.member_id
WHERE p.payment_id BETWEEN 301 AND 304
ORDER BY p.payment_id;

#####
CALL seed_classes();
CALL seed_class_registrations();
CALL seed_employees();

SELECT
    (SELECT COUNT(*) FROM Members
     WHERE member_id BETWEEN 101 AND 103) AS members,
    (SELECT COUNT(*) FROM Memberships
     WHERE membership_id BETWEEN 201 AND 203) AS memberships,
    (SELECT COUNT(*) FROM Payments
     WHERE payment_id BETWEEN 301 AND 304) AS payments,
    (SELECT COUNT(*) FROM Classes
     WHERE class_id BETWEEN 401 AND 403) AS classes,
    (SELECT COUNT(*) FROM Class_Registrations
     WHERE reg_id BETWEEN 501 AND 504) AS registrations,
    (SELECT COUNT(*) FROM Employees
     WHERE employee_id BETWEEN 601 AND 604) AS employees;
     
	#####
    
    
