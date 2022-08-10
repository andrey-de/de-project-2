TRUNCATE TABLE public.shipping_agreement CASCADE;

INSERT INTO public.shipping_agreement (agreementid, agreement_number, agreement_rate, agreement_commission)
SELECT agreement[1]::BIGINT AS agreementid,
	   agreement[2]::varchar(30) AS agreement_number,
	   agreement[3]::numeric(14, 2) AS agreement_rate,
	   agreement[4]::numeric(14, 2) AS agreement_commission
FROM(
SELECT DISTINCT regexp_split_to_array(vendor_agreement_description, ':+') AS agreement
FROM shipping s
) AS vad
;
