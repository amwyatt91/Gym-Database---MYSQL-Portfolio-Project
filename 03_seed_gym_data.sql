CREATE PROCEDURE DD_members()
BEGIN
    INSERT INTO Members (
        member_id, location_id, first_name, last_name, email,
        phone, dob, join_date, current_status
    )
    SELECT s.member_id, s.location_id, s.first_name, s.last_name, s.email,
           s.phone, s.dob, s.join_date, s.current_status
    FROM (
        SELECT 101 AS member_id, 1 AS location_id, 'Maya' AS first_name,
               'Chen' AS last_name, 'maya.chen@example.com' AS email,
               '312-555-0101' AS phone, '1994-04-18' AS dob,
               '2025-01-06' AS join_date, 1 AS current_status
        UNION ALL
        SELECT 102, 2, 'Jordan', 'Reed', 'jordan.reed@example.com',
               '312-555-0102', '1988-09-23', '2025-01-10', 1
        UNION ALL
        SELECT 103, 3, 'Elena', 'Torres', 'elena.torres@example.com',
               '312-555-0103', '1997-02-11', '2025-01-15', 0
    ) AS s
    WHERE NOT EXISTS (
        SELECT 1 FROM Members AS m WHERE m.member_id = s.member_id
    );
END

CREATE PROCEDURE DD_memberships()
BEGIN
    INSERT INTO Memberships (
        membership_id, member_id, membership_type, start_date,
        end_date, price, mem_status
    )
    SELECT s.membership_id, s.member_id, s.membership_type, s.start_date,
           s.end_date, s.price, s.mem_status
    FROM (
        SELECT 201 AS membership_id, 101 AS member_id,
               'Basic Monthly' AS membership_type, '2025-01-06' AS start_date,
               NULL AS end_date, 35.00 AS price, 'Active' AS mem_status
        UNION ALL
        SELECT 202, 102, 'Premium Monthly', '2025-01-10', NULL, 60.00, 'Active'
        UNION ALL
        SELECT 203, 103, 'One Month Pass', '2025-01-15', '2025-02-14',
               45.00, 'Expired'
    ) AS s
    WHERE NOT EXISTS (
        SELECT 1 FROM Memberships AS m WHERE m.membership_id = s.membership_id
    );
END

CREATE PROCEDURE DD_payments()
BEGIN
    INSERT INTO Payments (
        payment_id, member_id, membership_id, amount, payment_date,
        pay_method, pay_status, transaction_ref
    )
    SELECT s.payment_id, m.member_id, m.membership_id, m.price,
           s.payment_date, s.pay_method, s.pay_status, s.transaction_ref
    FROM (
        SELECT 301 AS payment_id, 201 AS membership_id,
               '2025-01-06' AS payment_date, 'Credit Card' AS pay_method,
               'Paid' AS pay_status, 900301 AS transaction_ref
        UNION ALL
        SELECT 302, 202, '2025-01-10', 'Debit Card', 'Paid', 900302
        UNION ALL
        SELECT 303, 203, '2025-01-15', 'Credit Card', 'Paid', 900303
        UNION ALL
        SELECT 304, 201, '2025-02-06', 'Credit Card', 'Failed', 900304
    ) AS s
    INNER JOIN Memberships AS m ON m.membership_id = s.membership_id
    WHERE NOT EXISTS (
        SELECT 1 FROM Payments AS p WHERE p.payment_id = s.payment_id
    );
END

CREATE PROCEDURE DD_classes()
BEGIN
    INSERT INTO Classes (
        class_id, location_id, class_name, instructor,
        start_time, class_duration, capacity
    )
    SELECT s.class_id, s.location_id, s.class_name, s.instructor,
           s.start_time, s.class_duration, s.capacity
    FROM (
        SELECT 401 AS class_id, 1 AS location_id, 'Morning Yoga' AS class_name,
               'Sam Patel' AS instructor, '07:00:00' AS start_time,
               '45 minutes' AS class_duration, 18 AS capacity
        UNION ALL
        SELECT 402, 2, 'Strength Circuit', 'Avery Brooks', '18:00:00',
               '50 minutes', 16
        UNION ALL
        SELECT 403, 3, 'Indoor Cycling', 'Taylor Morgan', '17:30:00',
               '45 minutes', 20
    ) AS s
    WHERE NOT EXISTS (
        SELECT 1 FROM Classes AS c WHERE c.class_id = s.class_id
    );
END

CREATE PROCEDURE DD_registrations()
BEGIN
    INSERT INTO Class_Registrations (reg_id, class_id, member_id, reg_date, attendance)
    SELECT s.reg_id, s.class_id, s.member_id, s.reg_date, s.attendance
    FROM (
        SELECT 501 AS reg_id, 401 AS class_id, 101 AS member_id,
               '2025-01-20' AS reg_date, 'Attended' AS attendance
        UNION ALL
        SELECT 502, 402, 102, '2025-01-21', 'No Show'
        UNION ALL
        SELECT 503, 403, 103, '2025-01-22', 'Attended'
        UNION ALL
        SELECT 504, 401, 102, '2025-02-03', 'Cancelled'
    ) AS s
    WHERE NOT EXISTS (
        SELECT 1 FROM Class_Registrations AS r WHERE r.reg_id = s.reg_id
    );
END

CREATE PROCEDURE DD_employees()
BEGIN
    INSERT INTO Employees (
        employee_id, location_id, first_name, last_name,
        emp_role, email, hire_date, current_status
    )
    SELECT s.employee_id, s.location_id, s.first_name, s.last_name,
           s.emp_role, s.email, s.hire_date, s.current_status
    FROM (
        SELECT 601 AS employee_id, 1 AS location_id, 'Sam' AS first_name,
               'Patel' AS last_name, 'Instructor' AS emp_role,
               'sam.patel@example.com' AS email, '2024-05-13' AS hire_date,
               TRUE AS current_status
        UNION ALL
        SELECT 602, 2, 'Avery', 'Brooks', 'Instructor',
               'avery.brooks@example.com', '2024-06-03', TRUE
        UNION ALL
        SELECT 603, 3, 'Taylor', 'Morgan', 'Instructor',
               'taylor.morgan@example.com', '2024-07-22', TRUE
        UNION ALL
        SELECT 604, 1, 'Cameron', 'Lee', 'Front Desk',
               'cameron.lee@example.com', '2024-08-12', FALSE
    ) AS s
    WHERE NOT EXISTS (
        SELECT 1 FROM Employees AS e WHERE e.employee_id = s.employee_id
    );
END