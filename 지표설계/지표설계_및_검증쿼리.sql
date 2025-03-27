-- 1. 얼마의 이윤이 남는지?(MSRP - buyPrice)
WITH profits AS (
    SELECT
        *,
        (MSRP - buyPrice) AS profit
    FROM products
)
SELECT
	productCode AS code,
    productName AS name,
    productLine AS line,
    profit
FROM profits
ORDER BY profit DESC;
-- 1.1 검증쿼리
-- 이익을 계산하는 CTE 생성
-- CTE와 원본 테이블 비교
-- CASE로 값을 검증
WITH profits AS (
    SELECT 
        productCode, 
        MSRP, 
        buyPrice, 
        MSRP - buyPrice AS calculated_profit
    FROM products
)
SELECT 
    p.productCode, 
    p.MSRP, 
    p.buyPrice, 
    p.MSRP - p.buyPrice AS expected_profit,
    pf.calculated_profit,
    CASE 
        WHEN (p.MSRP - p.buyPrice) = pf.calculated_profit THEN 'MATCH' 
        ELSE 'MISMATCH' 
    END AS validation_result
FROM products p
JOIN profits pf ON p.productCode = pf.productCode;




-- 2. 얼마의 순이익이 발생하는지? (판매가격 * 수량) - (매입가격 * 수량) -> 코드별로 얼마의 순이익이 발생하는지.
SELECT 
	productCode,
	((MSRP * quantityInStock) - (buyPrice * quantityInStock)) AS netProfit
FROM products
GROUP BY productCode
ORDER BY netProfit DESC;
-- 2.1 검증쿼리
-- CTE 생성
-- 원본 테이블과 JOIN
-- 순이익 비교 
WITH netProfits AS (
    SELECT 
        productCode,
        (MSRP * quantityInStock) - (buyPrice * quantityInStock) AS netProfit
    FROM products
    GROUP BY productCode, MSRP, buyPrice, quantityInStock
)
SELECT 
    p.productCode, 
    (p.MSRP * p.quantityInStock) - (p.buyPrice * p.quantityInStock) AS expected_netProfit,
    np.netProfit,
    CASE 
        WHEN (p.MSRP * p.quantityInStock) - (p.buyPrice * p.quantityInStock) = np.netProfit THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS validation_result
FROM products p
JOIN netProfits np ON p.productCode = np.productCode;

-- 3. 각 라인당 가장 많이 판매된 제품 순위 COUNT(DISTINCT(productCode))
SELECT
    p.productLine AS product_line,
    SUM(od.quantityOrdered * od.priceEach) AS all_price
FROM products AS p
LEFT JOIN orderdetails AS od ON p.productCode = od.productCode
GROUP BY productLine
ORDER BY all_price DESC;

-- 3.1 검증쿼리
-- 각 라인당 판매된 수량을 보여주는 CTE 생성
-- 원본 데이터에서 수량을 보여주는 쿼리
-- 비교 후 같으면 MATCH, 다르면 MISMATCH
WITH expected_values AS (
    SELECT 
        p.productLine,
        SUM(od.quantityOrdered * od.priceEach) AS expected_all_price
    FROM products AS p
    LEFT JOIN orderdetails AS od ON p.productCode = od.productCode
    GROUP BY p.productLine
)
SELECT 
    e.productLine,
    e.expected_all_price,
    o.all_price, 
    CASE 
        WHEN e.expected_all_price = o.all_price THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS validation_result
FROM expected_values e
JOIN (
    SELECT
        p.productLine,
        SUM(od.quantityOrdered * od.priceEach) AS all_price
    FROM products AS p
    LEFT JOIN orderdetails AS od ON p.productCode = od.productCode
    GROUP BY productLine
) o ON e.productLine = o.productLine;


-- 4. 수량이 많은 제품은?(ProductName)
SELECT 
	productLine AS product_line,
    SUM(quantityInStock) AS quantity_in_stock
FROM products
GROUP BY product_line
ORDER BY quantity_in_stock DESC;

-- 4.1 검증쿼리
-- 제품 라인 별 수량이 많은 제품의 합을 구하는 CTE생성
-- 원본 데이터를 기반으로 비교
WITH expected_values AS (
    SELECT 
        productLine AS product_line,
        SUM(quantityInStock) AS quantity_in_stock
    FROM products
    GROUP BY productLine
)
SELECT 
    p.productLine AS all_line,
    ev.quantity_in_stock AS expected_quantity_in_stock,
    SUM(p.quantityInStock) AS product_quantity_in_stock,
    CASE 
        WHEN ev.quantity_in_stock = SUM(p.quantityInStock) THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS validation_result
FROM products AS p
LEFT JOIN expected_values AS ev ON ev.product_line = p.productLine
GROUP BY p.productLine, ev.quantity_in_stock;

-- 5. 제조 업체별 어떤 라인을 많이 생산하는지?
SELECT 
    productVendor AS vendor,
    productLine AS line,
    COUNT(DISTINCT productName) AS product_count
FROM products
GROUP BY productVendor, productLine
ORDER BY productVendor, productLine;
-- 5.1 검증쿼리
-- 제조사별 제품 라인에 속한 제품 개수를 미리 계산
-- 원본 데이터를 기반으로 COUNT를 다시 계산
-- 검증 결과 비교
WITH ProductCounts AS (
    SELECT 
        productVendor AS vendor,
        productLine AS line,
        COUNT(DISTINCT productName) AS product_count
    FROM products
    GROUP BY productVendor, productLine
),
Verification AS (
    SELECT 
        p.productVendor AS vendor,
        p.productLine AS line,
        COUNT(DISTINCT p.productName) AS calculated_count
    FROM products AS p
    GROUP BY p.productVendor, p.productLine
)
SELECT 
    pc.vendor,
    pc.line,
    pc.product_count AS expected_count, 
    v.calculated_count AS actual_count, 
    CASE 
        WHEN pc.product_count = v.calculated_count THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS verification_result
FROM ProductCounts AS pc
JOIN Verification AS v 
    ON pc.vendor = v.vendor AND pc.line = v.line
ORDER BY pc.vendor, pc.line;
