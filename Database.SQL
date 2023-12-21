Create Table Gas_Stations(
	name VARCHAR(30),
	location VARCHAR(30),

	constraint station_name_pk Primary Key(name)
);

Create Table Warrantor(
	name VARCHAR(50),
	SSN CHAR,
	phone INT,
	Type_of_guarantee VARCHAR(20)

	constraint Warr_id_pk Primary Key(SSN)
);

Create Table Employee(
	fname VARCHAR(15),
	lname VARCHAR(15),
	SSN CHAR,
	phone INT,
	Hire_Date Date DEFAULT sysdate,
	Salary INT,
	Warrantor_id CHAR,
	Station_name VARCHAR(30),

	constraint emp_ssn_pk Primary Key(SSN),
	
	Foreign key(Warrantor_id) references Warrantor(SSN)
	ON DELETE SET NULL 			ON UPDATE CASCADE,
	Foreign key(Station_name) references Gas_Stations(name)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);


Create Table Supplier(
	Provider_name VARCHAR(20),
	price_per_liter INT,

	constraint provider_name_pk Primary Key(provider_name)
);

Create Table Truck(
	employee_ssn CHAR,
	Driver_license CHAR,
	license_plate INT,
	Station_name VARCHAR(30),
	
	constraint license_plate_pk Primary Key(license_plate),
		
	Foreign key(employee_ssn) references Employee(SSN)
	ON DELETE SET NULL 			ON UPDATE CASCADE,

	Foreign key(Station_name) references Gas_Stations(name)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);

Create Table Tank(
	gas_type VARCHAR(20),
	capacity INT,

	Supervisor_ssn CHAR,
	Station_name VARCHAR(30),

	constraint gas_type_pk Primary Key(gas_type),
	
	Foreign key(Supervisor_ssn) references Employee(SSN)
	ON DELETE SET NULL 			ON UPDATE CASCADE
	Foreign key(Station_name) references Gas_Stations(name)
	ON DELETE SET NULL 			ON UPDATE CASCADE

);


create Table Foreign_provider(
	provider_id INT,
	Foreign_provider_name VARCHAR(30),
	price_per_liter INT,
	
	constraint provider_id_pk primary key(provider_id),
);

Create Table TSupply(
	Provider_name VARCHAR(20),
	license_plate INT,
	gas_type VARCHAR(20),
	destination VARCHAR(50),
	quantity INT,

	Primary Key(Provider_name, license_plate, gas_type),

	foreign key(Provider_name) references Supplier(Provider_name)
	ON DELETE SET NULL 			ON UPDATE CASCADE,
	foreign key(license_plate) references Truck(license_plate)
	ON DELETE SET NULL 			ON UPDATE CASCADE,
	foreign key(gas_type) references Tank(gas_type)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);

Create Table FSupply(
	provider_id INT,
	gas_type VARCHAR(20),
	quantity INT,

	Primary Key(provider_id, gas_type),

	foreign key(provider_id) references Foreign_provider(provider_id)
	ON DELETE SET NULL 			ON UPDATE CASCADE,
	foreign key(gas_type) references Tank(gas_type)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);

Create Table Counter(
	Counter_id INT,
	employee_ssn CHAR,
	gas_type VARCHAR(20),
	MNF VARCHAR(20),
	Station_name VARCHAR(30),
	
	
	constraint counter_id_pk Primary Key(Counter_id),

	Foreign key(employee_ssn) references Employee(SSN)
	ON DELETE SET NULL 			ON UPDATE CASCADE,
	
	Foreign key(gas_type) references Tank(gas_type)
	ON DELETE SET NULL 			ON UPDATE CASCADE,

	Foreign key(Station_name) references Gas_Stations(name)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);

Create Table Cashier(
	Cashier_id INT,
	Counter_id INT,
	current_value INT,
	previous_value INT,
	Cash INT,
	deferred_money INT,
	Post_Date DATE DEFAULT sysdate,

	Receiver_id CHAR,
	Station_name VARCHAR(30),


	constraint Cashier_id_pk Primary Key(Cashier_id),

	Foreign key(Receiver_id) references Employee(SSN)
	ON DELETE SET NULL 			ON UPDATE CASCADE,

	Foreign key(Counter_id) references Counter(Counter_id)
	ON DELETE SET NULL 			ON UPDATE CASCADE,

	Foreign key(Station_name) references Gas_Stations(name)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);


Create Table Bill(
	Bill_id INT,
	fname VARCHAR(15),
	lname VARCHAR(15),
	quantity INT,
	price INT,
	Bill_Date Date DEFAULT sysdate,
	Counter_id INT,
	
	constraint bill_id_pk Primary Key(Bill_id),

	Foreign key(Counter_id) references Counter(Counter_id)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);


Create Table Mini_market(

	trade_mark VARCHAR(40),
	Worker_id INT,
	Station_name VARCHAR(30),


	constraint trade_mark_pk Primary key(trade_mark),

	Foreign key(Worker_id) references Employee(SSN)
	ON DELETE SET NULL 			ON UPDATE CASCADE,

	Foreign key(Station_name) references Gas_Stations(name)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);

Create Table Product(
	Barcode_number CHAR,
	name VARCHAR(40),
	Price INT,
	trade_mark VARCHAR(40),
	
 	constraint Barcode_number_pk Primary key(Barcode_number),

	Foreign key(trade_mark) references Mini_market(trade_mark)
	ON DELETE SET NULL 			ON UPDATE CASCADE
);
