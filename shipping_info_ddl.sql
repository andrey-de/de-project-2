DROP TABLE IF EXISTS public.shipping_info;

CREATE TABLE public.shipping_info (
	shippingid BIGINT NOT NULL PRIMARY KEY,
	vendorid BIGINT NULL,
	payment_amount numeric(14, 2) NULL,
	shipping_plan_datetime timestamp NULL,
	transfer_type_id BIGINT NULL,
	shipping_country_id BIGINT NULL,
	agreementid BIGINT NULL,
	FOREIGN KEY (transfer_type_id) REFERENCES public.shipping_transfer(transfer_type_id) ON UPDATE CASCADE,
	FOREIGN KEY (shipping_country_id) REFERENCES public.shipping_country_rates(shipping_country_id) ON UPDATE CASCADE,
	FOREIGN KEY (agreementid) REFERENCES public.shipping_agreement(agreementid) ON UPDATE CASCADE
);
