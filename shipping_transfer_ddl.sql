DROP TABLE IF EXISTS public.shipping_transfer;

CREATE TABLE public.shipping_transfer (
	transfer_type_id BIGINT NOT NULL,
	transfer_type varchar(30) NULL,
	transfer_model varchar(30) NULL,
	shipping_transfer_rate numeric(14, 3) NULL,
	CONSTRAINT shipping_transfer_pkey PRIMARY KEY (transfer_type_id)
);
