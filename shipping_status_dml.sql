TRUNCATE TABLE public.shipping_status CASCADE;

INSERT INTO public.shipping_status (shippingid, status, state, shipping_start_fact_datetime, shipping_end_fact_datetime)
WITH
sid AS (SELECT s.shippingid,
               MAX(s.state_datetime) AS state_datetime,
               MAX(CASE
	               WHEN s.state = 'booked' THEN state_datetime
	           END) AS shipping_start_fact_datetime,
	           MAX(CASE
		           WHEN s.state = 'recieved' THEN state_datetime
		       END) AS shipping_end_fact_datetime
		FROM (SELECT shippingid, state_datetime, state FROM shipping) AS s
		GROUP BY shippingid)

SELECT sid.shippingid AS shippingid,
       sh.status AS status,
       sh.state AS state,
       sid.shipping_start_fact_datetime AS shipping_start_fact_datetime,
       sid.shipping_end_fact_datetime AS shipping_end_fact_datetime
FROM sid
LEFT JOIN (SELECT shippingid, state_datetime, status, state FROM public.shipping) sh ON sid.shippingid = sh.shippingid AND sid.state_datetime = sh.state_datetime
;
