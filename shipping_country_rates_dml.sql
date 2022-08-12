TRUNCATE TABLE public.shipping_country_rates CASCADE;

INSERT INTO public.shipping_country_rates (shipping_country, shipping_country_base_rate)
SELECT shipping_country,
       shipping_country_base_rate
FROM shipping s
GROUP BY (shipping_country, shipping_country_base_rate)
;
