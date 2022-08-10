TRUNCATE TABLE public.shipping_info CASCADE;


INSERT INTO public.shipping_info (shippingid, vendorid, payment_amount, shipping_plan_datetime, transfer_type_id, shipping_country_id, agreementid)
SELECT s.shippingid AS shippingid,
       s.vendorid AS vendorid,
       s.payment_amount AS payment_amount,
       s.shipping_plan_datetime AS shipping_plan_datetime,
       st.transfer_type_id AS transfer_type_id,
       scr.shipping_country_id AS shipping_country_id,
       s.agreementid
FROM(
SELECT DISTINCT shippingid,
	   vendorid,
	   payment_amount,
	   shipping_plan_datetime,
	   (regexp_split_to_array(shipping_transfer_description, ':+'))[1] AS transfer_type,
	   (regexp_split_to_array(shipping_transfer_description, ':+'))[2] AS transfer_model,
	   shipping_country,
	   (regexp_split_to_array(vendor_agreement_description, ':+'))[1]::BIGINT AS agreementid
FROM shipping
) AS s
LEFT JOIN public.shipping_transfer st ON s.transfer_type = st.transfer_type AND s.transfer_model = st.transfer_model
LEFT JOIN public.shipping_country_rates scr ON s.shipping_country = scr.shipping_country
;
