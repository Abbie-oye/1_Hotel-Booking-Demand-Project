create database EDA_with_sql;

create table hotel_bookings (
hotel text,
is_canceled boolean,
canceled_status text,
lead_time int,
arrival_date_year int,
arrival_date_month text,
arrival_date_week_number int,
arrival_date_day_of_month int,
stays_in_weekend_nights int,
stays_in_week_nights int,
adults int,
children int,
babies int,
total_guest int,
meal text,
country text,
market_segment text,
distribution_channel text,
is_repeated_guest boolean,
repeated_status text,
previous_cancelations int,
previous_bookings_not_canceled int,
reserved_room_type text,
assigned_room_type text,
booking_changes int,
deposit_type text,
agent int,
company int,
days_in_waiting_list int,
days_waiting_grouping text,
customer_type text,
adr numeric(8,2),
required_car_parking_spaces text,
total_of_special_requests int,
reservation_status text,
reservation_status_date date
);

copy hotel_bookings
from 'C:\Program Files\PostgreSQL\18\data\hotel_booking_cleaned.csv'
delimiter ','
csv header;

select * from hotel_bookings;

create table hotel_bookings_original as
select * from hotel_bookings;

select * from hotel_bookings;

-- Bookings per hotel type
select 
	hotel, 
	count(*)as total_bookings
from hotel_bookings_copy
group by hotel;

-- Cancellation rate (%) per customer type
select customer_type, 
count (*) as total_bookings,
sum(is_canceled :: int) as total_canceled,
round(sum(is_canceled :: int):: numeric / count(*) * 100, 2) as cancellation_rate_pct
from hotel_bookings
group by customer_type
order by cancellation_rate_pct desc;

-- Lead time & Cancellation relationship among customer type
select
	customer_type
	is_canceled,
	count(*) as total_booking,
	round(avg(lead_time),2) as avg_lead_time
from hotel_bookings
group by customer_type, is_canceled
order by customer_type, is_canceled;

-- Rate of Repeated Guest to First-Time Guest
select
	repeated_status,
	count(*) as total_bookings,
	round(count(*) * 100/ sum(count(*)) over(),2) as is_repeated_rate_pct
from hotel_bookings
group by repeated_status
order by total_bookings desc;

-- By customer type
select
	customer_type,
	repeated_status,
	count(*) as total_bookings,
	round(count(*) * 100/ sum(count(*)) over(),2) as is_repeated_rate_pct
from hotel_bookings
group by customer_type,repeated_status
order by customer_type, total_bookings desc;

-- ADR by ADR by hotel & market segment
select
	hotel,
	market_segment,
	round(avg(adr),2) as avg_adr
from hotel_bookings
where adr>0
group by hotel, market_segment
order by hotel,avg_adr desc;

-- ADR variation across years
select
	arrival_date_year,
	round(avg(adr), 2) as avg_adr,
	round(percentile_cont(0.5) within group (order by adr)::numeric, 2) as median_adr
from hotel_bookings
where adr > 0
group by arrival_date_year
order by arrival_date_year;

-- ADR monthly variation across years
select
	arrival_date_year,
	arrival_date_month,
	round(avg(adr), 2) as avg_adr,
	round(percentile_cont(0.5) within group (order by adr)::numeric, 2) as median_adr
from hotel_bookings
where adr > 0
group by arrival_date_year, arrival_date_month
order by
    arrival_date_year,
    to_date(arrival_date_month, 'Month');
