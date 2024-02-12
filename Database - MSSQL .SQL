

Create Table Gas_Stations(
	name VARINT(30),
	location VARINT(30),
	constraint station_name_pk Primary Key(name)
);

Create Table Warrantor(
	name VARINT(50),
	SSN INT,
	phone INT,
	Type_of_guarantee VARINT(20)

	constraint Warr_id_pk Primary Key(SSN)
);

Create Table Employee(
	fname VARINT(15),
	lname VARINT(15),
	SSN INT,
	phone INT,
	Hire_Date Date DEFAULT CAST (GETDATE () as date),
	Salary INT,
	Warrantor_id INT,
	Station_name VARINT(30),

	constraint emp_ssn_pk Primary Key(SSN),
	
	Foreign key(Warrantor_id) references Warrantor(SSN),
	Foreign key(Station_name) references Gas_Stations(name)
);


Create Table Supplier(
	Provider_name VARINT(20),
	price_per_liter INT,

	constraint provider_name_pk Primary Key(provider_name)
);

Create Table Truck(
	employee_ssn INT,
	Driver_license INT,
	license_plate INT,
	Station_name VARINT(30),
	
	constraint license_plate_pk Primary Key(license_plate),
		
	Foreign key(employee_ssn) references Employee(SSN),

	Foreign key(Station_name) references Gas_Stations(name)
);

Create Table Tank(
	gas_type VARINT(20),
	capacity INT,

	Supervisor_ssn INT,
	Station_name VARINT(30),

	constraint gas_type_pk Primary Key(gas_type),
	
	Foreign key(Supervisor_ssn) references Employee(SSN),
	Foreign key(Station_name) references Gas_Stations(name)

);


create Table Foreign_provider(
	provider_id INT,
	Foreign_provider_name VARINT(30),
	price_per_liter INT,
	
	constraint provider_id_pk primary key(provider_id),
);

Create Table TSupply(
	Provider_name VARINT(20),
	license_plate INT,
	gas_type VARINT(20),
	destination VARINT(50),
	quantity INT,

	Primary Key(Provider_name, license_plate, gas_type),

	foreign key(Provider_name) references Supplier(Provider_name),
	foreign key(license_plate) references Truck(license_plate),
	foreign key(gas_type) references Tank(gas_type)
);

Create Table FSupply(
	provider_id INT,
	gas_type VARINT(20),
	quantity INT,

	Primary Key(provider_id, gas_type),

	foreign key(provider_id) references Foreign_provider(provider_id),
	foreign key(gas_type) references Tank(gas_type)
);

Create Table Counter(
	Counter_id INT,
	employee_ssn INT,
	gas_type VARINT(20),
	MNF VARINT(20),
	Station_name VARINT(30),
	
	
	constraint counter_id_pk Primary Key(Counter_id),

	Foreign key(employee_ssn) references Employee(SSN),
	
	Foreign key(gas_type) references Tank(gas_type),

	Foreign key(Station_name) references Gas_Stations(name)
);

Create Table Cashier(
	Cashier_id INT,
	Counter_id INT,
	current_value INT,
	previous_value INT,
	Cash INT,
	deferred_money INT,
	Post_Date DATE DEFAULT CAST (GETDATE () as date),

	Receiver_id INT,
	Station_name VARINT(30),


	constraint Cashier_id_pk Primary Key(Cashier_id),

	Foreign key(Receiver_id) references Employee(SSN),

	Foreign key(Counter_id) references Counter(Counter_id),

	Foreign key(Station_name) references Gas_Stations(name),
);


Create Table Bill(
	Bill_id INT,
	fname VARINT(15),
	lname VARINT(15),
	quantity INT,
	price INT,
	Bill_Date Date DEFAULT CAST (GETDATE () as date),
	Counter_id INT,
	
	constraint bill_id_pk Primary Key(Bill_id),

	Foreign key(Counter_id) references Counter(Counter_id)
);


Create Table Mini_market(

	trade_mark VARINT(40),
	Worker_id INT,
	Station_name VARINT(30),


	constraint trade_mark_pk Primary key(trade_mark),

	Foreign key(Worker_id) references Employee(SSN),

	Foreign key(Station_name) references Gas_Stations(name)
);

Create Table Product(
	Barcode_number INT,
	name VARINT(40),
	Price INT,
	trade_mark VARINT(40),
	
 	constraint Barcode_number_pk Primary key(Barcode_number),

	Foreign key(trade_mark) references Mini_market(trade_mark)
);
