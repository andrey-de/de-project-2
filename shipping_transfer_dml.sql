TRUNCATE TABLE public.shipping_transfer CASCADE;

CREATE SEQUENCE shipping_transfer_sequence
START 1;

INSERT INTO public.shipping_transfer (transfer_type_id, transfer_type, transfer_model, shipping_transfer_rate)
SELECT nextval('shipping_transfer_sequence')::BIGINT AS transfer_type_id,
       std_array[1]::varchar(30) AS transfer_type,
	   std_array[2]::varchar(30) AS transfer_model,
	   shipping_transfer_rate
FROM(
SELECT DISTINCT regexp_split_to_array(shipping_transfer_description, ':') AS std_array,
				shipping_transfer_rate
FROM shipping s
) AS std
;

DROP SEQUENCE shipping_transfer_sequence;
