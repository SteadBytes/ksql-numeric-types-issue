CREATE TABLE public.numeric_val (
    id serial PRIMARY KEY,
    a_value numeric(100,20) NOT NULL,
    write_date timestamp NOT NULL DEFAULT now()
);

INSERT INTO numeric_val (a_value) VALUES (123.4);

CREATE TABLE public.decimal_val (
    id serial PRIMARY KEY,
    a_value decimal(100,20) NOT NULL,
    write_date timestamp NOT NULL DEFAULT now()
);

INSERT INTO decimal_val (a_value) VALUES (123.4);


CREATE TABLE public.integer_val (
    id serial PRIMARY KEY,
    a_value integer NOT NULL,
    write_date timestamp NOT NULL DEFAULT now()
);

INSERT INTO integer_val (a_value) VALUES (123);

CREATE TABLE public.real_val (
    id serial PRIMARY KEY,
    a_value real NOT NULL,
    write_date timestamp NOT NULL DEFAULT now()
);

INSERT INTO real_val (a_value) VALUES (123.4);

CREATE TABLE public.double_val (
    id serial PRIMARY KEY,
    a_value double precision NOT NULL,
    write_date timestamp NOT NULL DEFAULT now()
);

INSERT INTO double_val (a_value) VALUES (123.4);