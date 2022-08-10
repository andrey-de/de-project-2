# Проект 2

**Описание проекта:** Используя имеющиеся данные сделать миграцию в отдельные логические таблицы, а затем собрать на них витрину данных.

**Цель проекта:** Создать таблицы `shipping_country_rates`, `shipping_agreement`, `shipping_transfer`, `shipping_info` и `shipping_status`. Заполнить их данными. Создать представление `shipping_datamart`.

**Исходные данные:** таблица `shipping`

## Выполнение проекта

## 1. Создание и заполнение таблицы `shipping_country_rates`

Создадим таблицу `shipping_country_rates` со следующими полями:  

| Поле | Формат | Ключи | Источник данных | Сущность |  
|------|--------|-------------|-----------------|---|  
| shipping_country_id | BIGINT | PK | shipping_country_rates_sequence | созданный id |
| shipping_country | text |  | public.shipping (shipping_country) | страна доставки |
| shipping_country_base_rate | numeric(14, 3) |  | public.shipping (shipping_country_base_rate) | налог на доставку в страну в процентах от стоимости товара

Скрипт создания таблицы: `shipping_country_rates_ddl.sql`  
Cкрипт наполнения данными: `shipping_country_rates_dml.sql`


## 2. Создание и заполнение таблицы `shipping_agreement`

Создадим таблицу `shipping_agreement` со следующими полями:  

| Поле | Формат | Ключи | Источник данных | Сущность |   
|------|--------|-------|-----------------|----------|  
| agreementid | BIGINT | PK | public.shipping (vendor_agreement_description) | id договора |
| agreement_number | varchar(30) |  | public.shipping (vendor_agreement_description) | номер договора в бухгалтерии |
| agreement_rate | numeric(14, 2) |  | public.shipping (vendor_agreement_description) | ставка налога за стоимость доставки товара для вендора |
| agreement_commission | numeric(14, 2) |  | public.shipping (vendor_agreement_description) | комиссия - доля в платеже, являющаяся доходом компании от сделки |

Скрипт создания таблицы: `shipping_agreement_ddl.sql`  
Cкрипт наполнения данными: `shipping_agreement_dml.sql`

## 3. Создание и заполнение таблицы `shipping_transfer`

Создадим таблицу `shipping_transfer` со следующими полями:  

| Поле | Формат | Ключи | Источник данных | Сущность |  
|------|--------|-------|-----------------|----------|  
| transfer_type_id | BIGINT | PK | shipping_transfer_sequence | cозданный id |
| transfer_type | varchar(30) |  | public.shipping (shipping_transfer_description) | тип доставки |
| transfer_model | varchar(30) |  | public.shipping (shipping_transfer_description) | модель доставки |
| shipping_transfer_rate | numeric(14, 2) |  | public.shipping (shipping_transfer_rate) | процент стоимости доставки для вендора |

Скрипт создания таблицы: `shipping_transfer_ddl.sql`  
Cкрипт наполнения данными: `shipping_transfer_dml.sql`

## 4. Создание и заполнение таблицы `shipping_info`

Создадим таблицу `shipping_info` со следующими полями:  

| Поле | Формат | Ключи | Источник данных | Сущность |   
|------|--------|-------|-----------------|----------|  
| shippingid | BIGINT | PK | public.shipping (shippingid) | уникальный идентификатор доставки |
| vendorid | BIGINT |  | public.shipping (vendorid) | уникальный идентификатор вендора |
| payment_amount | numeric(14, 2) |  | public.shipping (payment_amount) | сумма платежа |
| shipping_plan_datetime | timestamp |  | public.shipping (shipping_plan_datetime) | плановая дата доставки |
| transfer_type_id | BIGINT | FK | public.shipping_transfer (transfer_type_id) | id из таблицы shipping_transfer |
| shipping_country_id | BIGINT | FK | public.shipping_country_rates (shipping_country_id) | id из таблицы shipping_country_rates |
| agreementid | BIGINT | FK | public.shipping_agreement (agreementid) | id из таблицы shipping_agreement |

Скрипт создания таблицы: `shipping_info_ddl.sql`  
Cкрипт наполнения данными: `shipping_info_dml.sql`

## 5. Создание и заполнение таблицы `shipping_status`

Создадим таблицу `shipping_status` со следующими полями:  

| Поле | Формат | Ключи | Источник данных | Сущность |
|------|--------|-------|-----------------|----------|  
| shippingid | BIGINT | PK | public.shipping (shippingid) | уникальный идентификатор доставки |
| status | text |  | public.shipping (status) | текущий статус доставки |
| state | text |  | public.shipping (state) | текущее состояние доставки |
| shipping_start_fact_datetime | timestamp |  | public.shipping (state_datetime) | время начала доставки |
| shipping_end_fact_datetime | timestamp |  | public.shipping (state_datetime) | время окончания доставки |

Скрипт создания таблицы: `shipping_status_ddl.sql`  
Cкрипт наполнения данными: `shipping_status_dml.sql`

## 6. Создание представления `shipping_datamart`

Создадим представление `shipping_datamart` со следующими полями:  

| Поле | Источник данных | Сущность |
|------|-----------------|----------|  
| shippingid | public.shipping_status(shippingid) | уникальный идентификатор доставки |
| vendorid | public.shipping_status(vendorid) | уникальный идентификатор вендора |
| transfer_type | public.shipping_transfer(transfer_type) | уникальный идентификатор вендора |
| full_day_at_shipping | public.shipping_status(shipping_start_fact_datetime, shipping_end_fact_datetime) | количество полных дней, в течение которых длилась доставка |
| is_delay | public.shipping_status(shipping_end_fact_datetime), public.shipping(shipping_plan_datetime) | статус, показывающий просрочена ли доставка |
| is_shipping_finish | public.shipping_status(status) | статус, показывающий, что доставка завершена |
| delay_day_at_shipping | public.shipping_status(shipping_end_fact_datetime), public.shipping(shipping_plan_datetime) | количество дней, на которые была просрочена доставка |
| payment_amount | public.shipping_info(payment_amount) | сумма платежа пользователя |
| vat | public.shipping_info(payment_amount), public.shipping_country_rates(shipping_country_base_rate), public.shipping_agreement(agreement_rate), public.shipping_transfer(shipping_transfer_rate) | итоговый налог на доставку |
| profit | public.shipping_info(payment_amount),  public.shipping_agreement(agreement_commission) | итоговый доход компании с доставки |

Скрипт создания представления: `shipping_datamart_view.sql`  

