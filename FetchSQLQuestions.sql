
-- 1. Which brand saw the most dollars spent in the month of June?

SELECT bd.NAME
FROM brands bd JOIN receipt_items reci ON (bd.BARCODE = reci.BARCODE) JOIN receipts as R ON (reci.REWARDS_RECEIPT_ID = R.ID)
WHERE MONTH(R.PURCHASE_DATE) = 6
GROUP BY bd.NAME
ORDER BY SUM(reci.TOTAL_FINAL_PRICE) DESC
LIMIT 1;

-- 2. Which user spent the most money in the month of August?

SELECT u.ID
FROM users u JOIN receipts rec ON (u.ID=rec.USER_ID)
WHERE MONTH(rec.PURCHASE_DATE) = 8
GROUP BY u.ID
ORDER BY SUM(rec.TOTAL_SPENT) DESC
LIMIT 1;


-- 3. What user bought the most expensive item?
SELECT u.ID
FROM users u JOIN receipts r ON (u.ID=r.USER_ID) JOIN receipt_items reci ON (r.ID=reci.REWARDS_RECEIPT_ID)
ORDER BY reci.TOTAL_FINAL_PRICE/reci.QUANTITY_PURCHASED DESC
LIMIT 1


-- 4. What is the name of the most expensive item purchased?


SELECT ri.DESCRIPTION
FROM receipt_items ri
WHERE (
SELECT MAX(total_price_per_item)
FROM (
SELECT SUM(ri_1.TOTAL_FINAL_PRICE / ri_1.QUANTITY_PURCHASED) AS total_price_per_item
FROM receipt_items ri_1
) table1
) = (
SELECT SUM(ri.TOTAL_FINAL_PRICE / ri.QUANTITY_PURCHASED)
);


-- 5. How many users scanned in each month?

SELECT MONTH(r.date_scanned), COUNT( DISTINCT r.user_id) 
FROM receipts r 
GROUP BY MONTH(r.date_scanned);



