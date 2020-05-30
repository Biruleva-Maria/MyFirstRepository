BEGIN;

CREATE TABLE shop (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 city varchar(100) NOT NULL,
 street varchar(100) NOT NULL,
 house varchar(20) NOT NULL,
 date_start date NOT NULL UNIQUE,
 date_finish varchar(10)
);

CREATE TABLE employee (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 surname varchar(255) NOT NULL,
 middle_name varchar(10),
 phone_number varchar(255) NOT NULL UNIQUE,
 email varchar(255) NOT NULL UNIQUE,
 date_birthday date NOT NULL UNIQUE
);

CREATE TABLE shop_employee (
 id serial PRIMARY KEY,
 shop_id integer REFERENCES shop (id),
 employee_id integer REFERENCES employee (id),
 date_start date NOT NULL UNIQUE,
 date_finish varchar(10),
 working_day varchar(255) NOT NULL,
 weekend varchar(255) NOT NULL
);

CREATE TABLE product (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL UNIQUE
);

CREATE TABLE property (
 id serial PRIMARY KEY,
 product_id integer REFERENCES product (id),
 cotegory varchar(100) NOT NULL,
 descriptoin varchar(100) NOT NULL
);

CREATE TABLE departament (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL UNIQUE
);

CREATE TABLE client (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 surname varchar(255) NOT NULL,
 middle_name varchar(10),
 phone_number varchar(255) NOT NULL UNIQUE,
 email varchar(255) NOT NULL UNIQUE,
 number_card integer NOT NULL UNIQUE
);

CREATE TABLE buy (
 id serial PRIMARY KEY,
 shop_id integer REFERENCES shop (id),
 product_id integer REFERENCES product (id),
 client_id integer REFERENCES client (id),
 amount_spent varchar(255) NOT NULL
);

CREATE TABLE warehouse (
 id serial PRIMARY KEY,
 product_id integer REFERENCES product (id),
 count integer NOT NULL
);

CREATE TABLE supplier (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 phone varchar(20) NOT NULL UNIQUE,
 email varchar(100) NOT NULL UNIQUE
);

CREATE TABLE supplier_shop_product (
 id serial PRIMARY KEY,
 shop_id integer REFERENCES shop (id),
 employee_id integer REFERENCES employee (id),
 supplier_id integer REFERENCES supplier (id),
 price integer NOT NULL,
 count integer NOT NULL
);

CREATE TABLE division (
 id serial PRIMARY KEY,
 name varchar(255) NOT NULL,
 description varchar(100) NOT NULL,
 date_start date NOT NULL
);

CREATE TABLE stock (
 id serial PRIMARY KEY,
 product_id integer REFERENCES product (id),
 cotegory varchar(100) NOT NULL,
 descriptoin varchar(100) NOT NULL
);

CREATE TABLE department_employee (
 id serial PRIMARY KEY,
 division_id integer REFERENCES shop (id),
 employee_id integer REFERENCES employee (id),
 date_start date NOT NULL UNIQUE,
 date_finish varchar(10),
 working_day varchar(255) NOT NULL,
 weekend varchar(255) NOT NULL
);

END;