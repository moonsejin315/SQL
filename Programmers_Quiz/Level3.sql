Q1. 문제 설명
다음은 어느 한 서점에서 판매중인 도서들의 도서 정보(BOOK), 판매 정보(BOOK_SALES) 테이블입니다.

BOOK 테이블은 각 도서의 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.

Column name	Type	Nullable	Description
BOOK_ID	INTEGER	FALSE	도서 ID
CATEGORY	VARCHAR(N)	FALSE	카테고리 (경제, 인문, 소설, 생활, 기술)
AUTHOR_ID	INTEGER	FALSE	저자 ID
PRICE	INTEGER	FALSE	판매가 (원)
PUBLISHED_DATE	DATE	FALSE	출판일
BOOK_SALES 테이블은 각 도서의 날짜 별 판매량 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.

Column name	Type	Nullable	Description
BOOK_ID	INTEGER	FALSE	도서 ID
SALES_DATE	DATE	FALSE	판매일
SALES	INTEGER	FALSE	판매량
문제
2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 카테고리명을 기준으로 오름차순 정렬해주세요.

정답 -- 코드를 입력하세요
SELECT B.CATEGORY AS CATEGORY, SUM(BS.SALES) AS TOTAL_SALES
FROM BOOK AS B JOIN BOOK_SALES AS BS
    ON B.BOOK_ID = BS.BOOK_ID
WHERE BS.SALES_DATE LIKE '2022-01%'
GROUP BY B.CATEGORY
ORDER BY CATEGORY

Q2. 문제설명
ANIMAL_INS 테이블은 동물 보호소에 들어온 동물의 정보를 담은 테이블입니다. ANIMAL_INS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, INTAKE_CONDITION, NAME, SEX_UPON_INTAKE는 각각 동물의 아이디, 생물 종, 보호 시작일, 보호 시작 시 상태, 이름, 성별 및 중성화 여부를 나타냅니다.

NAME	TYPE	NULLABLE
ANIMAL_ID	VARCHAR(N)	FALSE
ANIMAL_TYPE	VARCHAR(N)	FALSE
DATETIME	DATETIME	FALSE
INTAKE_CONDITION	VARCHAR(N)	FALSE
NAME	VARCHAR(N)	TRUE
SEX_UPON_INTAKE	VARCHAR(N)	FALSE
ANIMAL_OUTS 테이블은 동물 보호소에서 입양 보낸 동물의 정보를 담은 테이블입니다. ANIMAL_OUTS 테이블 구조는 다음과 같으며, ANIMAL_ID, ANIMAL_TYPE, DATETIME, NAME, SEX_UPON_OUTCOME는 각각 동물의 아이디, 생물 종, 입양일, 이름, 성별 및 중성화 여부를 나타냅니다. ANIMAL_OUTS 테이블의 ANIMAL_ID는 ANIMAL_INS의 ANIMAL_ID의 외래 키입니다.

NAME	TYPE	NULLABLE
ANIMAL_ID	VARCHAR(N)	FALSE
ANIMAL_TYPE	VARCHAR(N)	FALSE
DATETIME	DATETIME	FALSE
NAME	VARCHAR(N)	TRUE
SEX_UPON_OUTCOME	VARCHAR(N)	FALSE
아직 입양을 못 간 동물 중, 가장 오래 보호소에 있었던 동물 3마리의 이름과 보호 시작일을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일 순으로 조회해야 합니다.

예시
예를 들어, ANIMAL_INS 테이블과 ANIMAL_OUTS 테이블이 다음과 같다면

ANIMAL_INS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	INTAKE_CONDITION	NAME	SEX_UPON_INTAKE
A354597	Cat	2014-05-02 12:16:00	Normal	Ariel	Spayed Female
A373687	Dog	2014-03-20 12:31:00	Normal	Rosie	Spayed Female
A412697	Dog	2016-01-03 16:25:00	Normal	Jackie	Neutered Male
A413789	Dog	2016-04-19 13:28:00	Normal	Benji	Spayed Female
A414198	Dog	2015-01-29 15:01:00	Normal	Shelly	Spayed Female
A368930	Dog	2014-06-08 13:20:00	Normal		Spayed Female
ANIMAL_OUTS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	NAME	SEX_UPON_OUTCOME
A354597	Cat	2014-05-02 12:16:00	Ariel	Spayed Female
A373687	Dog	2014-03-20 12:31:00	Rosie	Spayed Female
A368930	Dog	2014-06-13 15:52:00		Spayed Female
SQL문을 실행하면 다음과 같이 나와야 합니다.

NAME	DATETIME
Shelly	2015-01-29 15:01:00
Jackie	2016-01-03 16:25:00
Benji	2016-04-19 13:28:00
※ 입양을 가지 못한 동물이 3마리 이상인 경우만 입력으로 주어집니다.

정답 
-- 코드를 입력하세요
-- 아직 입양을 못 간 동물 중, 1.가장 오래 보호소에 있던 동물 3마리의 이름과
-- 2. 보호 시작일을 조회하는 SQL문
-- 결과는 보호 시작일 순으로
SELECT 
    AI.NAME AS NAME,
    AI.DATETIME AS DATETIME
FROM ANIMAL_INS AI
LEFT JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AO.DATETIME IS NULL
ORDER BY DATETIME
LIMIT 3

Q3. 문제 설명
다음은 식품공장의 주문정보를 담은 FOOD_ORDER 테이블입니다. FOOD_ORDER 테이블은 다음과 같으며 ORDER_ID, PRODUCT_ID, AMOUNT, PRODUCE_DATE, IN_DATE,OUT_DATE,FACTORY_ID, WAREHOUSE_ID는 각각 주문 ID, 제품 ID, 주문양, 생산일자, 입고일자, 출고일자, 공장 ID, 창고 ID를 의미합니다.

Column name	Type	Nullable
ORDER_ID	VARCHAR(10)	FALSE
PRODUCT_ID	VARCHAR(5)	FALSE
AMOUNT	NUMBER	FALSE
PRODUCE_DATE	DATE	TRUE
IN_DATE	DATE	TRUE
OUT_DATE	DATE	TRUE
FACTORY_ID	VARCHAR(10)	FALSE
WAREHOUSE_ID	VARCHAR(10)	FALSE
문제
FOOD_ORDER 테이블에서 2022년 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성해주세요. 출고여부는 2022년 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력해주시고, 결과는 주문 ID를 기준으로 오름차순 정렬해주세요.

예시
FOOD_ORDER 테이블이 다음과 같을 때

ORDER_ID	PRODUCT_ID	AMOUNT	PRODUCE_DATE	IN_DATE	OUT_DATE	FACTORY_ID	WAREHOUSE_ID
OD00000051	P0002	4000	2022-04-01	2022-04-21	2022-04-21	FT19970003	WH0005
OD00000052	P0003	2500	2022-04-10	2022-04-27	2022-04-27	FT19970003	WH0006
OD00000053	P0005	6200	2022-04-15	2022-04-30	2022-05-01	FT19940003	WH0003
OD00000054	P0006	1000	2022-04-21	2022-04-30	NULL	FT19940003	WH0009
OD00000055	P0008	1500	2022-04-25	2022-05-11	2022-05-11	FT19980003	WH0009
SQL을 실행하면 다음과 같이 출력되어야 합니다.

ORDER_ID	PRODUCT_ID	OUT_DATE	출고여부
OD00000051	P0002	2022-04-21	출고완료
OD00000052	P0003	2022-04-27	출고완료
OD00000053	P0005	2022-05-01	출고완료
OD00000054	P0006		출고미정
OD00000055	P0008	2022-05-11	출고대기

정답
-- 코드를 입력하세요
-- 2022년 5월 1일 기준
-- 이전 : 출고완료, 이후 : 출고 대기, NULL : 출고미정
SELECT
    ORDER_ID,
    PRODUCT_ID,
    DATE_FORMAT(OUT_DATE, '%Y-%m-%d') AS OUT_DATE, 
    CASE
        WHEN OUT_DATE <= '2022-05-01' THEN "출고완료"
        WHEN OUT_DATE > '2022-05-01' THEN "출고대기"
        ELSE "출고미정"
    END AS "출고여부"
FROM FOOD_ORDER
ORDER BY ORDER_ID

Q4.문제 설명
다음은 어느 자동차 대여 회사에서 대여 중인 자동차들의 정보를 담은 CAR_RENTAL_COMPANY_CAR 테이블과 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다. CAR_RENTAL_COMPANY_CAR 테이블은 아래와 같은 구조로 되어있으며, CAR_ID, CAR_TYPE, DAILY_FEE, OPTIONS 는 각각 자동차 ID, 자동차 종류, 일일 대여 요금(원), 자동차 옵션 리스트를 나타냅니다.

Column name	Type	Nullable
CAR_ID	INTEGER	FALSE
CAR_TYPE	VARCHAR(255)	FALSE
DAILY_FEE	INTEGER	FALSE
OPTIONS	VARCHAR(255)	FALSE
자동차 종류는 '세단', 'SUV', '승합차', '트럭', '리무진' 이 있습니다. 자동차 옵션 리스트는 콤마(',')로 구분된 키워드 리스트(예: '열선시트', '스마트키', '주차감지센서')로 되어있으며, 키워드 종류는 '주차감지센서', '스마트키', '네비게이션', '통풍시트', '열선시트', '후방카메라', '가죽시트' 가 있습니다.

CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며, HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

Column name	Type	Nullable
HISTORY_ID	INTEGER	FALSE
CAR_ID	INTEGER	FALSE
START_DATE	DATE	FALSE
END_DATE	DATE	FALSE
문제
CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 자동차 종류가 '세단'인 자동차들 중 10월에 대여를 시작한 기록이 있는 자동차 ID 리스트를 출력하는 SQL문을 작성해주세요. 자동차 ID 리스트는 중복이 없어야 하며, 자동차 ID를 기준으로 내림차순 정렬해주세요.

예시
예를 들어 CAR_RENTAL_COMPANY_CAR 테이블이 다음과 같고

CAR_ID	CAR_TYPE	DAILY_FEE	OPTIONS
1	세단	16000	가죽시트,열선시트,후방카메라
2	SUV	14000	스마트키,네비게이션,열선시트
3	세단	22000	주차감지센서,후방카메라,가죽시트
4	세단	12000	주차감지센서
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블이 다음과 같다면

HISTORY_ID	CAR_ID	START_DATE	END_DATE
1	4	2022-09-27	2022-09-27
2	3	2022-10-03	2022-10-04
3	2	2022-10-05	2022-10-05
4	1	2022-10-11	2022-10-14
5	3	2022-10-13	2022-10-15
10월에 대여를 시작한 기록이 있는 '세단' 종류의 자동차는 자동차 ID가 1, 3 인 자동차이고, 자동차 ID를 기준으로 내림차순 정렬하면 다음과 같이 나와야 합니다.

CAR_ID
3
1

정답
-- 코드를 입력하세요
-- 자동차 종류 : '세단' + 10월에 대여를 시작
-- 자동차 ID 중복 X, 자동차 ID 기준 내림차순
SELECT 
    DISTINCT(C.CAR_ID)
FROM CAR_RENTAL_COMPANY_CAR C
JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY CR ON C.CAR_ID = CR.CAR_ID
WHERE C.CAR_TYPE = '세단' AND CR.START_DATE BETWEEN '2022-10-01' AND '2022-10-31'
ORDER BY CAR_ID DESC

