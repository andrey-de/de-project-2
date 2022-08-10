TRUNCATE TABLE public.shipping_country_rates CASCADE;

CREATE SEQUENCE shipping_country_rates_sequence
START 1;

INSERT INTO public.shipping_country_rates (shipping_country_id, shipping_country, shipping_country_base_rate)
SELECT nextval('shipping_country_rates_sequence')::BIGINT AS shipping_country_id,
shipping_country,
shipping_country_base_rate
FROM shipping s
GROUP BY (shipping_country, shipping_country_base_rate)
;

DROP SEQUENCE shipping_country_rates_sequence;
