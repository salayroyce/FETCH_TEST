
--make sure someone wasnt created in the future, or born in the future
--only questions is the default birthday acceptable or not
-- why do the dates have a z at the end? data quality issue
--also makes sure that there is only one entry per id

select 
count(ID) as ID_count,
count(distinct ID) as ID_DCOUNT,
max(created_date) as max_cdate,
min(created_date) as min_cdate,
max(birth_date) as max_bdate,
min(birth_date) as min_bdate
from SB_PRDCT_INSGHT.USER_TAKEHOME;

select 
language_ from SB_PRDCT_INSGHT.USER_TAKEHOME
group by 1;

--gender doesnt seem to be a drop down/limited. Open field responses tend to create data issues with too many possible responses
-- non binary for example is spelt correctly both times but wont be grouped becasue of different cases and underscore vs hyphen
select 
gender from SB_PRDCT_INSGHT.USER_TAKEHOME
group by 1;


--data quality issue if there is supposed to be multiple records of the same receipt id

select count(receipt_id) rec_count,
count(distinct receipt_id) rec_dcount
from SB_PRDCT_INSGHT.TRANSACTION_TAKEHOME;

--some scan dates dont match the purchase date
--there are missing barcodes for some purchases
--and there are missing final sale prices, as well as text and decimals in the quanitity fields which make no sense
select *
from SB_PRDCT_INSGHT.TRANSACTION_TAKEHOME;


--there are 111 barcodes that are just brand and manufacturers and not a category of products
select 
count(*)
from SB_PRDCT_INSGHT.PRODUCTS_TAKEHOME
where category_1 is null

--there are over 4000 products without a barcode
select 
count(*)
from SB_PRDCT_INSGHT.PRODUCTS_TAKEHOME
where barcode is null

--there are over 226 thousand products without a brand or a manufacturer
select 
count(*)
from SB_PRDCT_INSGHT.PRODUCTS_TAKEHOME
where manufacturer  is null and brand is null




---Nerds, Dove and unknown are leading the way with 6 purchases each out of 144 for the most popular, then there is a tie with a bunch of brands at 4 purchases each
Select 
brand,
count(receipt_id) as purchases
from SB_PRDCT_INSGHT.TRANSACTION_TAKEHOME t1
inner join SB_PRDCT_INSGHT.PRODUCTS_TAKEHOME t2
on t1.barcode = t2.barcode
inner join SB_PRDCT_INSGHT.USER_TAKEHOME t3
on t1.user_id = t3.id
where birth_date < '2004-04-25' 
group by 1
order by 2


---Nerds and dove both are leadin brands with a mixture of other brands coming next.
Select  
brand,
count(receipt_id) as purchases
from SB_PRDCT_INSGHT.TRANSACTION_TAKEHOME t1
inner join SB_PRDCT_INSGHT.PRODUCTS_TAKEHOME t2
on t1.barcode = t2.barcode
inner join SB_PRDCT_INSGHT.USER_TAKEHOME t3
on t1.user_id = t3.id
where CREATED_DATE < '2023-10-25' 
group by 1
order by 2 desc



-- Tostitos is the leading brand in the DIPS and SALSA category
Select 
brand,
count(receipt_id)
from SB_PRDCT_INSGHT.TRANSACTION_TAKEHOME t1
inner join SB_PRDCT_INSGHT.PRODUCTS_TAKEHOME t2
on t1.barcode = t2.barcode
where category_2 = 'Dips & Salsa'
group by 1
order by 2 desc





