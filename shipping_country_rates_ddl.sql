DROP TABLE IF EXISTS public.shipping_country_rates;

CREATE TABLE public.shipping_country_rates (
	shipping_country_id SERIAL NOT NULL PRIMARY KEY,
	shipping_country text NULL,
	shipping_country_base_rate numeric(14, 3) NULL
);
