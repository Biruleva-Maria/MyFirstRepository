BEGIN;

CREATE TABLE shop (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 city varchar(100) NOT NULL,
 street varchar(100) NOT NULL,
 house varchar(20) NOT NULL,
 date_start date(10) NOT NULL UNIQUE,
 date_finish varchar(10)
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE employee (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 surname varchar(255) NOT NULL,
 middle_name varchar(10),
 phone_number varchar(255) NOT NULL UNIQUE,
 email varchar(255) NOT NULL UNIQUE,
 date_birthday date(10) NOT NULL UNIQUE,
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE shop_employee (
 id serial PRIMARY KEY,
 shop_id integer REFERENCES shop (id),
 employee_id integer REFERENCES employee (id),
 date_start date(10) NOT NULL UNIQUE,
 date_finish varchar(10),
 working_day varchar(255) NOT NULL,
 weekend varchar(255) NOT NULL,
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE product (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL UNIQUE
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE property (
 id serial PRIMARY KEY,
 product_id integer REFERENCES product (id),
 cotegory varchar(100) NOT NULL,
 descriptoin varchar(100) NOT NULL
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE departament (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL UNIQUE
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE client (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 surname varchar(255) NOT NULL,
 middle_name varchar(10),
 phone_number varchar(255) NOT NULL UNIQUE,
 email varchar(255) NOT NULL UNIQUE,
 number_card integer(10) NOT NULL UNIQUE
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE buy (
 id serial PRIMARY KEY,
 shop_id integer REFERENCES shop (id),
 product_id integer REFERENCES product (id),
 client_id integer REFERENCES client (id),
 amount_spent varchar(255) NOT NULL
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE warehouse (
 id serial PRIMARY KEY,
 product_id integer REFERENCES product (id),
 count integer(100) NOT NULL
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE supplier (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 phone varchar(20) NOT NULL UNIQUE,
 email varchar(100) NOT NULL UNIQUE,
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE supplier_shop_product (
 id serial PRIMARY KEY,
 shop_id integer REFERENCES shop (id),
 employee_id integer REFERENCES employee (id),
 supplier_id integer REFERENCES supplier (id),
 price integer(10) NOT NULL,
 count integer(10) NOT NULL
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE division (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 description varchar(100) NOT NULL,
 date_start date(10) NOT NULL
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE stock (
 id serial PRIMARY KEY,
 product_id integer REFERENCES product (id),
 cotegory varchar(100) NOT NULL,
 descriptoin varchar(100) NOT NULL
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

CREATE TABLE department_employee (
 id serial PRIMARY KEY,
 division_id integer REFERENCES shop (id),
 employee_id integer REFERENCES employee (id),
 date_start date(10) NOT NULL UNIQUE,
 date_finish varchar(10),
 working_day varchar(255) NOT NULL,
 weekend varchar(255) NOT NULL,
);

/*
INSERT INTO supplier (name, city, street, house, phone, email)
VALUES
*/

COMMIT;