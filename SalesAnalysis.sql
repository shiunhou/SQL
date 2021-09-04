use portfolio;
show tables;

-- to find the max quantity of product sold in a transaction
SELECT max(quantity) 
FROM tr_orderdetails;

-- to find number of unique product in all the transactions
SELECT count(distinct(productid)) as number_of_unique_product
FROM tr_orderdetails;

-- to find which category has the highest number of product
SELECT productcategory, count(productid) as number_of_product
FROM tr_products
GROUP BY productCategory
ORDER BY count(productid) desc;

-- to find the state where most stores are present
SELECT propertystate, count(*) as number_of_store
FROM tr_propertyinfo
GROUP by propertystate
ORDER BY 2 desc
LIMIT 5;

-- to find the top 10 productIDs that did maximum sales in term of quantity
SELECT productID, SUM(quantity) as QuantitySold
FROM tr_orderdetails
GROUP BY productID
ORDER BY SUM(quantity) desc
LIMIT 10;

-- to find the top 10 propertyIDs that did maximum sales in term of quantity
SELECT propertyID, SUM(quantity) as QuantitySold
FROM tr_orderdetails
GROUP BY propertyID
ORDER BY SUM(quantity) desc
LIMIT 10;

-- to find the top 5 product names that did max sales in terms of quantity
SELECT od.productID, p.productName, sum(od.quantity)
FROM tr_orderdetails od
LEFT JOIN tr_products p
ON od.productID = p.productID
GROUP BY od.productID
ORDER BY sum(quantity) desc
LIMIT 5;

-- to find the top 5 products that did max sales
SELECT od.productID, p.productName, sum(od.quantity*p.price) as Sales
FROM tr_orderdetails od
LEFT JOIN tr_products p
ON od.productID = p.productID
GROUP BY od.productID
ORDER BY sum(quantity*price) desc
LIMIT 5;

-- to find the top 5 cities that did max sales
SELECT pi.PropertyCity, sum(od.quantity * p.price) as Sales
FROM tr_orderdetails od
LEFT JOIN tr_products p 
ON od.ProductID = p.ProductID
LEFT JOIN tr_propertyinfo pi 
ON od.PropertyID = pi.`Prop ID`
GROUP BY pi.PropertyCity
ORDER BY Sales desc
LIMIT 5;

-- to find the top 5 products in 'Arlington' and 'New York' 
(SELECT pi.propertyCity, p.productName, sum(od.quantity * p.price) as Sales
FROM tr_orderdetails od
JOIN tr_products p
ON od.ProductID = p.productID
JOIN tr_propertyinfo pi 
ON od.propertyID = pi.`Prop ID`
WHERE pi.propertyCity = 'Arlington'
GROUP BY p.productName
ORDER BY Sales desc
LIMIT 5)
UNION
(SELECT pi.propertyCity, p.productName, sum(od.quantity * p.price) as Sales
FROM tr_orderdetails od
JOIN tr_products p
ON od.ProductID = p.productID
JOIN tr_propertyinfo pi 
ON od.propertyID = pi.`Prop ID`
WHERE pi.propertyCity = 'New York'
GROUP BY p.productName
ORDER BY Sales desc
LIMIT 5);