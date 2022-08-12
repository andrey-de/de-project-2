DROP TABLE IF EXISTS public.shipping_status;

CREATE TABLE public.shipping_status (
	shippingid BIGINT NOT NULL PRIMARY KEY,
	status text NULL,
	state text NULL,
	shipping_start_fact_datetime timestamp NULL,
	shipping_end_fact_datetime timestamp NULL
);
