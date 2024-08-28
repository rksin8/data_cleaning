-- Table: public.currency_conversion

-- DROP TABLE IF EXISTS public.currency_conversion;

CREATE TABLE IF NOT EXISTS public.currency_conversion
(
    currency_code character varying COLLATE pg_catalog."default",
    conversion_factor double precision
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.currency_conversion
    OWNER to postgres

select * from currency_conversion