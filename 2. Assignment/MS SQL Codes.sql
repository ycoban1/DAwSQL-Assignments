CREATE VIEW customer_product AS
SELECT    distinct D.customer_id, D.first_name, D.last_name
FROM    product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE    A.product_id=B.product_id
AND        B.order_id = C.order_id
AND        C.customer_id = D.customer_id
AND        A.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'

CREATE VIEW first AS
SELECT    distinct D.customer_id, D.first_name, D.last_name, CAST('Yes' as varchar(10)) AS First_product
FROM    product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE    A.product_id=B.product_id
AND        B.order_id = C.order_id
AND        C.customer_id = D.customer_id
AND        A.product_name = 'Polk Audio - 50 W Woofer - Black'

CREATE VIEW second AS
SELECT    distinct D.customer_id, D.first_name, D.last_name, CAST('Yes' as varchar(10)) AS Second_product
FROM    product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE    A.product_id=B.product_id
AND        B.order_id = C.order_id
AND        C.customer_id = D.customer_id
AND        A.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'

CREATE VIEW third AS
SELECT    distinct D.customer_id, D.first_name, D.last_name, CAST('Yes' as varchar(10)) AS Third_product
FROM    product.product A, sale.order_item B, sale.orders C, sale.customer D
WHERE    A.product_id=B.product_id
AND        B.order_id = C.order_id
AND        C.customer_id = D.customer_id
AND        A.product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)'

SELECT A.customer_id, A.first_name, A.last_name, 
ISNULL (B.First_product,'No') AS First_product,
ISNULL (C.Second_product,'No') AS Second_product,
ISNULL (D.Third_product,'No') AS Third_product
FROM customer_product A
LEFT JOIN first B ON A.customer_id=B.customer_id
LEFT JOIN second C ON A.customer_id=C.customer_id
LEFT JOIN third D ON A.customer_id=D.customer_id