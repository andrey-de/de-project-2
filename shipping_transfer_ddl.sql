DROP TABLE IF EXISTS public.shipping_transfer;

CREATE TABLE public.shipping_transfer (
	transfer_type_id SERIAL NOT NULL PRIMARY KEY,
	transfer_type varchar(30) NULL,
	transfer_model varchar(30) NULL,
	shipping_transfer_rate numeric(14, 3) NULL
);
