DROP TABLE IF EXISTS public.shipping_agreement;

CREATE TABLE public.shipping_agreement (
	agreementid BIGINT NOT NULL PRIMARY KEY,
	agreement_number varchar(30) NULL,
	agreement_rate numeric(14, 3) NULL,
	agreement_commission numeric(14, 3) NULL
);
