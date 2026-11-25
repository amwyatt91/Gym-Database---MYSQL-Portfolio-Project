## Data Integrity and Migrations through a Payment Audit (READ ONLY, EXAMPLE OF ERROR)##
## -- Run this INSERT separately after both ALTER TABLE statements succeed. ##
## -- Expected result: MySQL error 1452 from fk_payments_membership_member. ##

USE gym_db_sample;

## READ-ONLY AUDIT ##
SELECT
	p.payment_id,
    p.member_id AS payment_member_id,
    p.membership_id,
    ms.member_id AS membership_owner_id,
    CASE
		WHEN m.member_id IS NULL THEN 'Missing Member'
        WHEN ms.membership_id IS NULL THEN 'Missing Membership'
        ELSE 'Membership belongs to another member'
	END AS integrity_issue
FROM Payments AS p
LEFT JOIN Members AS m
	ON m.member_id = p.member_id
LEFT JOIN Memberships AS ms
	ON ms.membership_id = p.membership_id
WHERE m.member_id IS NULL
	OR ms.membership_id IS NULL
    OR ms.member_id <> p.member_id
ORDER BY p.payment_id;

## INSERT 'BAD' DATA ##
START TRANSACTION;

INSERT INTO Payments (
    payment_id,
    member_id,
    membership_id,
    amount,
    payment_date,
    pay_method,
    pay_status,
    transaction_ref
)
VALUES (
    399,
    101,
    202,
    60.00,
    '2025-02-10',
    'Credit Card',
    'Paid',
    900399
);

SELECT
    p.payment_id,
    p.member_id AS payment_member_id,
    p.membership_id,
    ms.member_id AS membership_owner_id
FROM Payments AS p
JOIN Memberships AS ms
    ON ms.membership_id = p.membership_id
WHERE p.payment_id = 399;

## QUERY TO ENSURE DATA INSERT ##

SELECT
    DATABASE() AS active_database,
    (SELECT COUNT(*)
     FROM gym_db_sample.Payments
     WHERE payment_id = 399) AS test_payment_exists,
    (SELECT member_id
     FROM gym_db_sample.Memberships
     WHERE membership_id = 202) AS membership_owner;
     
SELECT payment_id, member_id, membership_id
FROM gym_db_sample.Payments
WHERE payment_id = 399;

ROLLBACK;

## ADD THE CONSTRAINTS ##
ALTER TABLE Memberships
    ADD CONSTRAINT uq_memberships_id_member
    UNIQUE (membership_id, member_id);
    
ALTER TABLE Payments
    ADD CONSTRAINT fk_payments_membership_member
    FOREIGN KEY (membership_id, member_id)
    REFERENCES Memberships (membership_id, member_id);

## RETRY MISMATCHED INSERT ##

INSERT INTO Payments (
    payment_id, member_id, membership_id, amount,
    payment_date, pay_method, pay_status, transaction_ref
)
VALUES (
    399, 101, 202, 60.00,
    '2025-02-10', 'Credit Card', 'Paid', 900399
);

