TRUNCATE TABLE public.shipping_status CASCADE;


INSERT INTO public.shipping_status (shippingid, status, state, shipping_start_fact_datetime, shipping_end_fact_datetime)
WITH
sid AS (SELECT shippingid,
       MAX(state_datetime) AS state_datetime,
       (SELECT state_datetime
       FROM shipping
       WHERE shippingid = s.shippingid
       AND state = 'booked') AS shipping_start_fact_datetime,
       (SELECT state_datetime
       FROM shipping
       WHERE shippingid = s.shippingid
       AND state = 'recieved') AS shipping_end_fact_datetime
FROM shipping s
GROUP BY shippingid)

SELECT sid.shippingid AS shippingid,
       sh.status AS status,
       sh.state AS state,
       sid.shipping_start_fact_datetime AS shipping_start_fact_datetime,
       sid.shipping_end_fact_datetime AS shipping_end_fact_datetime
FROM sid
LEFT JOIN (SELECT shippingid, state_datetime, status, state FROM public.shipping) sh ON sid.shippingid = sh.shippingid AND sid.state_datetime = sh.state_datetime
;
