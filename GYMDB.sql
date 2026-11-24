CREATE database gym_db_sample;
USE gym_db_sample;
CREATE TABLE Locations (
	location_id INT UNIQUE NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL UNIQUE,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(2) NOT NULL,
    zip_code INT NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp
    );
CREATE TABLE Members (
	member_id int UNIQUE NOT NULL PRIMARY KEY,
    location_id int NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    dob DATE NOT NULL,
    join_date DATE NOT NULL,
    current_status INT NOT NULL,
	created_at TIMESTAMP DEFAULT current_timestamp
    );
    ALTER TABLE members ADD foreign key (location_id) references Locations(location_id);
    CREATE TABLE Memberships (
	membership_id INT UNIQUE NOT NULL PRIMARY KEY,
    member_id INT UNIQUE NOT NULL,
    membership_type VARCHAR(50) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    price DECIMAL(10, 2) NOT NULL,
    mem_status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT current_timestamp,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
    );
CREATE TABLE Payments (
	payment_id INT UNIQUE NOT NULL PRIMARY KEY,
	member_id INT NOT NULL,
	membership_id INT NOT NULL,
	amount VARCHAR(25) NOT NULL,
	payment_date DATE NOT NULL,
	pay_method VARCHAR(50) NOT NULL,
	pay_status VARCHAR(50) NOT NULL,
	transaction_ref INT UNIQUE NOT NULL
);
CREATE TABLE Classes (
	class_id INT UNIQUE NOT NULL PRIMARY KEY,
	location_id INT NOT NULL,
	class_name VARCHAR(50) NOT NULL,
	instructor VARCHAR(50) NOT NULL,
	start_time TIME NOT NULL,
	class_duration VARCHAR(25) NOT NULL,
	capacity INT NOT NULL,
	FOREIGN KEY (location_id) REFERENCES Locations(location_id)
    );
    ALTER TABLE Payments MODIFY COLUMN amount DECIMAL(10, 2);
    
    CREATE TABLE Class_Registrations (
	reg_id INT UNIQUE NOT NULL PRIMARY KEY,
    class_id INT NOT NULL,
    member_id INT NOT NULL, 
    reg_date DATE NOT NULL,
    attendance VARCHAR(50) NOT NULL,
    FOREIGN KEY (class_id) REFERENCES Classes (class_id),
    FOREIGN KEY (member_id) REFERENCES Members (member_id)
    );
    
    CREATE TABLE Employees (
	employee_id INT UNIQUE NOT NULL PRIMARY KEY,
    location_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    emp_role VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    hire_date DATE NOT NULL,
    current_status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (location_id) REFERENCES Locations (location_id)
    );
    

    
    
    
    