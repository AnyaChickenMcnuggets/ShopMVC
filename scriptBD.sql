-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.category
(
    id integer NOT NULL DEFAULT nextval('category_id_seq'::regclass),
    name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT category_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.image
(
    id integer NOT NULL DEFAULT nextval('image_id_seq'::regclass),
    file_name character varying(255) COLLATE pg_catalog."default",
    product_id integer NOT NULL,
    CONSTRAINT image_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.orders
(
    id integer NOT NULL DEFAULT nextval('orders_id_seq'::regclass),
    date_time timestamp(6) without time zone,
    final_price real NOT NULL,
    "number" character varying(255) COLLATE pg_catalog."default",
    status smallint,
    person_id integer NOT NULL,
    CONSTRAINT orders_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.person
(
    id integer NOT NULL DEFAULT nextval('person_id_seq'::regclass),
    login character varying(100) COLLATE pg_catalog."default",
    password character varying(100) COLLATE pg_catalog."default",
    role character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT person_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.product
(
    id integer NOT NULL DEFAULT nextval('product_id_seq'::regclass),
    date_time timestamp(6) without time zone,
    description text COLLATE pg_catalog."default" NOT NULL,
    price real NOT NULL,
    seller character varying(255) COLLATE pg_catalog."default" NOT NULL,
    title text COLLATE pg_catalog."default" NOT NULL,
    warehouse character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_id integer NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (id),
    CONSTRAINT uk_qka6vxqdy1dprtqnx9trdd47c UNIQUE (title)
);

CREATE TABLE IF NOT EXISTS public.product_cart
(
    id integer NOT NULL DEFAULT nextval('product_cart_id_seq'::regclass),
    person_id integer,
    product_id integer,
    quantity integer,
    CONSTRAINT product_cart_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.product_order
(
    id integer NOT NULL DEFAULT nextval('product_order_id_seq'::regclass),
    orders_id integer,
    price real NOT NULL,
    product_id integer,
    quantity integer NOT NULL,
    CONSTRAINT product_order_pkey PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.image
    ADD CONSTRAINT fkgpextbyee3uk9u6o2381m7ft1 FOREIGN KEY (product_id)
    REFERENCES public.product (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT fk1b0m4muwx1t377w9if3w6wwqn FOREIGN KEY (person_id)
    REFERENCES public.person (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.product
    ADD CONSTRAINT fk1mtsbur82frn64de7balymq9s FOREIGN KEY (category_id)
    REFERENCES public.category (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.product_cart
    ADD CONSTRAINT fkhpnrxdy3jhujameyod08ilvvw FOREIGN KEY (product_id)
    REFERENCES public.product (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.product_cart
    ADD CONSTRAINT fksgnkc1ko2i1o9yr2p63ysq3rn FOREIGN KEY (person_id)
    REFERENCES public.person (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.product_order
    ADD CONSTRAINT fkh73acsd9s5wp6l0e55td6jr1m FOREIGN KEY (product_id)
    REFERENCES public.product (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.product_order
    ADD CONSTRAINT fknxb19amwrevbigam8p6n0h12s FOREIGN KEY (orders_id)
    REFERENCES public.orders (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;