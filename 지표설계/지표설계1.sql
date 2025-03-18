select * from customers;
select * from orders;
select * from products;
select * from orderdetails;
-- 지표를 설계해야 한다. 
-- 매출
-- 크게 전사의 차원에서 지표를 본다. 
-- 총 매출 , 총 주문 수, 총 판매된 수량, 주문당 평균 매출, 주문당 평균 수량, 해당 날짜의 주문한 고객 수 
-- 항상 필요한 일자 기준 yyyyMMdd 날짜는 꼭 필요하다. ord_ymd, ord_ym 두 개의 컬럼을 만든다.

-- 총매출을 주문 수량으로 나눠보자!
-- 전체 주문(매출) 테이블
SELECT 	
	o.orderDate,
    sum(od.quantityOrdered * od.priceEach) AS total_revenue,## 총 매출 
    count(distinct o.orderNumber) AS total_orders, ## 총 주문 수
    sum(od.quantityOrdered) AS totl_quantity_sold, ## 총 판매된 수량
    count(distinct o.customerNumber) AS ditinct_customers, ## 주문당 평균 매출
    round(sum(od.quantityOrdered * od.priceEach) / count(distinct o.orderNumber), 2) AS avg_order_value, ## 주문당 평균 수량
    round(sum(od.quantityOrdered) / count(distinct o.orderNumber), 2) AS avg_quantity_per_order ## 해당 날짜의 주문한 고객 수
FROM 
	orders AS o
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY o.orderDate
ORDER BY 1;

-- 고객 테이블 - 마스터 테이블
-- 고객ID, 고객명, 고객의 총 주문 횟수, 고객의 주문금액, 고객의 평균 주문금액, 마지막 주문 날짜, 마지막 주문 이후 경과된 일수 , 고객 등급 (임의로 정한 고객의 등급)
-- 고객 등급 기준이 없다
SELECT 
	c.customerNumber,
    c.customerName,
    count(distinct o.orderNumber) AS total_orders, 
    coalesce(sum(od.quantityOrdered * od.priceEach),0) AS total_revenue, 
    coalesce(round(sum(od.quantityOrdered * od.priceEach) / nullif(count(distinct o.orderNumber), 0),2),0) AS avg_order_value,
    max(o.orderDate) AS last_order_date,
    datediff(curdate(), max(o.orderDate)) AS day_since_last_order,
    CASE
		WHEN count(distinct o.orderNumber) > 20 AND sum(od.quantityOrdered * od.priceEach) > 50000 THEN 'VIP 고객'
        WHEN count(distinct o.orderNumber) BETWEEN 5 AND 20 THEN '일반 고객'
		WHEN datediff(curdate(), max(o.orderDate)) > 365 THEN '휴면 고객'
	END AS customer_seg
FROM 
    customers AS c
LEFT JOIN  orders AS o ON o.customerNumber = c.customerNumber
LEFT JOIN orderdetails AS od ON od.orderNumber = o.orderNumber    
GROUP BY c.customerNumber;

-- 필수과제 1
-- 위의 2개의 마트 쿼리를 검증해 주세요.
-- 명확한 검증 로직을 작성하고 -> 해당 값을 검증할 수 있는 코드와 함께 정리해서 주세요.
-- 둘 다 모두 검증해야 하고 예시는 최소 2개 이상씩 해야 합니다. - 총 최소 4개 이상 진행
-- 1. 총 매출 검증쿼리
SELECT SUM(od.quantityOrdered * od.priceEach) AS revenue
FROM orderdetails od;
-- 2. 총 주문 수 검증 쿼리
SELECT COUNT(DISTINCT o.orderNumber) AS orders
FROM orders AS o;
-- 3. 총 판매된 수량 검증 쿼리
SELECT SUM(od.quantityOrdered) AS quantity_sold
FROM orderdetails od;
-- 4. 주문당 평군 매출 검증 쿼리
SELECT COUNT(DISTINCT o.customerNumber) AS distinct_customer
FROM orders o;

-- 필수과제 2
-- 고객의 세그먼트를 새롭게 나눠 주세요.
-- 5등급으로 나눠서 (직접 여러분들이 데이터를 보고 설계하시면 됩니다.) 5개의 등급의 고객 세그먼트가 나올 수 있게 만들어 주시면 됩니다.
-- 수업 때는 3개 했지만 실제 5개까지 진행하고 모두 로직상 겹치지 않게 최대한 다 세그먼트로 나뉠 수 있도록 지정해 주세요!
SELECT 
    c.customerNumber AS 고객번호,  -- 고객 번호
    c.customerName AS 고객명, -- 고객 이름
    COUNT(DISTINCT o.orderNumber) AS 총_주문_건수,  -- 고객의 총 주문 건수
    COALESCE(SUM(od.quantityOrdered), 0) AS 총_주문_수량,  -- 총 주문 수량
    COALESCE(SUM(od.quantityOrdered * od.priceEach), 0) AS 총_구매_금액, -- 총 구매 금액
    COALESCE(ROUND(SUM(od.quantityOrdered * od.priceEach) / NULLIF(COUNT(DISTINCT o.orderNumber), 0), 2), 0) AS 평균_주문_금액, -- 평균 주문 금액 (주문 0건일 때 0 처리)
    MAX(o.orderDate) AS 최근_주문일,    -- 최근 주문 날짜
    DATEDIFF(curdate(), MIN(o.orderDate)) AS 마지막_주문_후_경과일, -- 마지막 주문 후 며칠 지났는지 -> 수정 필요 : 특정 날짜를 현재로 설정해보자. 왜냐면 너무 오래된 데이터라...
    CASE
        WHEN 
			COUNT(DISTINCT o.orderNumber) > 20 AND SUM(od.quantityOrdered * od.priceEach) > 50000 THEN 'VIP 고객'
        WHEN 
			COUNT(DISTINCT o.orderNumber) BETWEEN 10 AND 20 OR SUM(od.quantityOrdered * od.priceEach) BETWEEN 30000 AND 50000 THEN '우수고객'
        WHEN 
			COUNT(DISTINCT o.orderNumber) BETWEEN 3 AND 5 OR SUM(od.quantityOrdered * od.priceEach) BETWEEN 10000 AND 30000 THEN '일반고객'
        WHEN 
			DATEDIFF(curdate(), MIN(o.orderDate)) > 365 
            OR COUNT(DISTINCT o.orderNumber) BETWEEN 1 AND 10
            OR SUM(od.quantityOrdered * od.priceEach) BETWEEN 1 AND 10000 THEN '휴먼고객'
        ELSE '신규/기타 고객'
    END AS 고객_분류
FROM customers AS c
LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
LEFT JOIN orderdetails AS od ON od.orderNumber = o.orderNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY 총_구매_금액 DESC;