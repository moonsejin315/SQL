Q1. 문제 설명
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
보호소에서 중성화 수술을 거친 동물 정보를 알아보려 합니다. 보호소에 들어올 당시에는 중성화1되지 않았지만, 보호소를 나갈 당시에는 중성화된 동물의 아이디와 생물 종, 이름을 조회하는 아이디 순으로 조회하는 SQL 문을 작성해주세요.

예시
예를 들어, ANIMAL_INS 테이블과 ANIMAL_OUTS 테이블이 다음과 같다면

ANIMAL_INS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	INTAKE_CONDITION	NAME	SEX_UPON_INTAKE
A367438	Dog	2015-09-10 16:01:00	Normal	Cookie	Spayed Female
A382192	Dog	2015-03-13 13:14:00	Normal	Maxwell 2	Intact Male
A405494	Dog	2014-05-16 14:17:00	Normal	Kaila	Spayed Female
A410330	Dog	2016-09-11 14:09:00	Sick	Chewy	Intact Female
ANIMAL_OUTS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	NAME	SEX_UPON_OUTCOME
A367438	Dog	2015-09-12 13:30:00	Cookie	Spayed Female
A382192	Dog	2015-03-16 13:46:00	Maxwell 2	Neutered Male
A405494	Dog	2014-05-20 11:44:00	Kaila	Spayed Female
A410330	Dog	2016-09-13 13:46:00	Chewy	Spayed Female
Cookie는 보호소에 들어올 당시에 이미 중성화되어있었습니다.
Maxwell 2는 보호소에 들어온 후 중성화되었습니다.
Kaila는 보호소에 들어올 당시에 이미 중성화되어있었습니다.
Chewy는 보호소에 들어온 후 중성화되었습니다.
따라서 SQL문을 실행하면 다음과 같이 나와야 합니다.

ANIMAL_ID	ANIMAL_TYPE	NAME
A382192	Dog	Maxwell 2
A410330	Dog	Chewy

A1. -- 코드를 입력하세요
-- 보호소에서 중성화 수술을 거친 동물 정보
-- 보호소 들어올 당시 중성화 X
-- 보호소 나갈 때 중성화 O
-- 동물 ID, 생물 종, 이름(아이디순)
-- Spayed = 중성화 O, Intact = 중성화 X -> Neutered, Spayed = 중성화 O 
SELECT 
    AI.ANIMAL_ID,
    AI.ANIMAL_TYPE,
    AI.NAME
FROM ANIMAL_INS AI
JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AI.SEX_UPON_INTAKE LIKE 'Intact%' AND AO.SEX_UPON_OUTCOME NOT LIKE 'Intact%'
ORDER BY AI.ANIMAL_ID

Q2. 문제 설명
다음은 식품의 정보를 담은 FOOD_PRODUCT 테이블입니다. FOOD_PRODUCT 테이블은 다음과 같으며 PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE는 식품 ID, 식품 이름, 식품코드, 식품분류, 식품 가격을 의미합니다.

Column name	Type	Nullable
PRODUCT_ID	VARCHAR(10)	FALSE
PRODUCT_NAME	VARCHAR(50)	FALSE
PRODUCT_CD	VARCHAR(10)	TRUE
CATEGORY	VARCHAR(10)	TRUE
PRICE	NUMBER	TRUE
문제
FOOD_PRODUCT 테이블에서 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문을 작성해주세요. 이때 식품분류가 '과자', '국', '김치', '식용유'인 경우만 출력시켜 주시고 결과는 식품 가격을 기준으로 내림차순 정렬해주세요.

예시
FOOD_PRODUCT 테이블이 다음과 같을 때

PRODUCT_ID	PRODUCT_NAME	PRODUCT_CD	CATEGORY	PRICE
P0018	맛있는고추기름	CD_OL00008	식용유	6100
P0019	맛있는카놀라유	CD_OL00009	식용유	5100
P0020	맛있는산초유	CD_OL00010	식용유	6500
P0021	맛있는케첩	CD_SC00001	소스	4500
P0022	맛있는마요네즈	CD_SC00002	소스	4700
P0039	맛있는황도	CD_CN00008	캔	4100
P0040	맛있는명이나물	CD_CN00009	캔	3500
P0041	맛있는보리차	CD_TE00010	차	3400
P0042	맛있는메밀차	CD_TE00001	차	3500
P0099	맛있는맛동산	CD_CK00002	과자	1800
SQL을 실행하면 다음과 같이 출력되어야 합니다.

CATEGORY	MAX_PRICE	PRODUCT_NAME
식용유	6500	맛있는산초유
과자	1800	맛있는맛동산

A2. -- 코드를 입력하세요
-- 식품분류별로 가격이 제일 비싼 식품의 분류
-- 식품분류는 '과자', '국', '김치', '식용유'
-- 결과는 식품가격 기준 내림차순
SELECT 
    CATEGORY, 
    PRICE AS MAX_PRICE, 
    PRODUCT_NAME
FROM FOOD_PRODUCT
WHERE (CATEGORY, PRICE) IN (
                            SELECT CATEGORY, MAX(PRICE)
                            FROM FOOD_PRODUCT
                            GROUP BY CATEGORY
                            HAVING CATEGORY IN ('국', '김치', '식용유', '과자')
)
ORDER BY MAX_PRICE DESC

Q3. 문제 설명
다음은 식품의 정보를 담은 FOOD_PRODUCT 테이블과 식품의 주문 정보를 담은 FOOD_ORDER 테이블입니다. FOOD_PRODUCT 테이블은 다음과 같으며 PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE는 식품 ID, 식품 이름, 식품코드, 식품분류, 식품 가격을 의미합니다.

Column name	Type	Nullable
PRODUCT_ID	VARCHAR(10)	FALSE
PRODUCT_NAME	VARCHAR(50)	FALSE
PRODUCT_CD	VARCHAR(10)	TRUE
CATEGORY	VARCHAR(10)	TRUE
PRICE	NUMBER	TRUE
FOOD_ORDER 테이블은 다음과 같으며 ORDER_ID, PRODUCT_ID, AMOUNT, PRODUCE_DATE, IN_DATE, OUT_DATE, FACTORY_ID, WAREHOUSE_ID는 각각 주문 ID, 제품 ID, 주문량, 생산일자, 입고일자, 출고일자, 공장 ID, 창고 ID를 의미합니다.

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
FOOD_PRODUCT와 FOOD_ORDER 테이블에서 생산일자가 2022년 5월인 식품들의 식품 ID, 식품 이름, 총매출을 조회하는 SQL문을 작성해주세요. 이때 결과는 총매출을 기준으로 내림차순 정렬해주시고 총매출이 같다면 식품 ID를 기준으로 오름차순 정렬해주세요.

예시
FOOD_PRODUCT 테이블이 다음과 같고

PRODUCT_ID	PRODUCT_NAME	PRODUCT_CD	CATEGORY	PRICE
P0011	맛있는콩기름	CD_OL00001	식용유	4880
P0012	맛있는올리브유	CD_OL00002	식용유	7200
P0013	맛있는포도씨유	CD_OL00003	식용유	5950
P0014	맛있는마조유	CD_OL00004	식용유	8950
P0015	맛있는화조유	CD_OL00005	식용유	8800
P0016	맛있는참기름	CD_OL00006	식용유	7100
P0017	맛있는들기름	CD_OL00007	식용유	7900
P0018	맛있는고추기름	CD_OL00008	식용유	6100
P0019	맛있는카놀라유	CD_OL00009	식용유	5100
P0020	맛있는산초유	CD_OL00010	식용유	6500
FOOD_ORDER 테이블이 다음과 같을 때

ORDER_ID	PRODUCT_ID	AMOUNT	PRODUCE_DATE	IN_DATE	OUT_DATE	FACTORY_ID	WAREHOUSE_ID
OD00000056	P0012	1000	2022-04-04	2022-04-21	2022-04-25	FT19980002	WH0032
OD00000057	P0014	2500	2022-04-14	2022-04-27	2022-05-01	FT19980002	WH0033
OD00000058	P0017	1200	2022-05-19	2022-05-28	2022-05-28	FT20070002	WH0033
OD00000059	P0017	1000	2022-05-24	2022-05-30	2022-05-30	FT20070002	WH0038
OD00000060	P0019	2000	2022-05-29	2022-06-08	2022-06-08	FT20070002	WH0035
SQL을 실행하면 다음과 같이 출력되어야 합니다.

PRODUCT_ID	PRODUCT_NAME	TOTAL_SALES
P0017	맛있는들기름	17380000
P0019	맛있는카놀라유	10200000

A3. -- 코드를 입력하세요
-- 생산일자가 2022년 5월인 식품들의 
-- 식품 ID, 식품 이름, 총매출을 조회
-- 결과는 총매출을 기준으로 내림차순 정렬, 식품 ID 오름차순
WITH SEL_PRO AS(
    SELECT *
    FROM FOOD_ORDER
    WHERE YEAR(PRODUCE_DATE) = 2022 AND MONTH(PRODUCE_DATE) = 5
)
SELECT 
    FP.PRODUCT_ID,
    FP.PRODUCT_NAME,
    SUM(FP.PRICE * SP.AMOUNT) AS TOTAL_SALES
FROM FOOD_PRODUCT AS FP
JOIN SEL_PRO AS SP
ON FP.PRODUCT_ID = SP.PRODUCT_ID
GROUP BY FP.PRODUCT_NAME
ORDER BY TOTAL_SALES DESC, FP.PRODUCT_ID

Q4. 문제 설명
다음은 환자 정보를 담은 PATIENT 테이블과 의사 정보를 담은 DOCTOR 테이블, 그리고 진료 예약목록을 담은 APPOINTMENT에 대한 테이블입니다. PATIENT 테이블은 다음과 같으며 PT_NO, PT_NAME, GEND_CD, AGE, TLNO는 각각 환자번호, 환자이름, 성별코드, 나이, 전화번호를 의미합니다.

Column name	Type	Nullable
PT_NO	VARCHAR(N)	FALSE
PT_NAME	VARCHAR(N)	FALSE
GEND_CD	VARCHAR(N)	FALSE
AGE	INTEGER	FALSE
TLNO	VARCHAR(N)	TRUE
DOCTOR 테이블은 다음과 같으며 DR_NAME, DR_ID, LCNS_NO, HIRE_YMD, MCDP_CD, TLNO는 각각 의사이름, 의사ID, 면허번호, 고용일자, 진료과코드, 전화번호를 나타냅니다.

Column name	Type	Nullable
DR_NAME	VARCHAR(N)	FALSE
DR_ID	VARCHAR(N)	FALSE
LCNS_NO	VARCHAR(N)	FALSE
HIRE_YMD	DATE	FALSE
MCDP_CD	VARCHAR(N)	TRUE
TLNO	VARCHAR(N)	TRUE
APPOINTMENT 테이블은 다음과 같으며 APNT_YMD, APNT_NO, PT_NO, MCDP_CD, MDDR_ID, APNT_CNCL_YN, APNT_CNCL_YMD는 각각 진료 예약일시, 진료예약번호, 환자번호, 진료과코드, 의사ID, 예약취소여부, 예약취소날짜를 나타냅니다.

Column name	Type	Nullable
APNT_YMD	TIMESTAMP	FALSE
APNT_NO	INTEGER	FALSE
PT_NO	VARCHAR(N)	FALSE
MCDP_CD	VARCHAR(N)	FALSE
MDDR_ID	VARCHAR(N)	FALSE
APNT_CNCL_YN	VARCHAR(N)	TRUE
APNT_CNCL_YMD	DATE	TRUE
문제
PATIENT, DOCTOR 그리고 APPOINTMENT 테이블에서 2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역을 조회하는 SQL문을 작성해주세요. 진료예약번호, 환자이름, 환자번호, 진료과코드, 의사이름, 진료예약일시 항목이 출력되도록 작성해주세요. 결과는 진료예약일시를 기준으로 오름차순 정렬해주세요.

예시
PATIENT 테이블이 다음과 같고,

PT_NO	PT_NAME	GEND_CD	AGE	TLNO
PT22000019	바라	W	10	01079068799
PT22000043	오스왈드	M	68	01031294124
PT22000052	제니	W	60	NULL
PT22000071	몬몬	M	31	01076489209
PT22000097	슈가	M	19	NULL
DOCTOR 테이블이 다음과 같고,

DR_NAME	DR_ID	LCNS_NO	HIRE_YMD	MCDP_CD	TLNO
루피	DR20090029	LC00010001	2009-03-01	CS	01085482011
니모	DR20200012	LC00911162	2020-03-01	CS	01089483921
핑크퐁	DR20140011	LC00082201	2014-03-01	NP	01098428957
젤라비	DR20160031	LC00340327	2016-11-01	OB	01023981922
토리	DR20190129	LC00099911	2019-03-01	NS	01058390758
APPOINTMENT 테이블이 다음과 같을 때,

APNT_YMD	APNT_NO	PT_NO	MCDP_CD	MDDR_ID	APNT_CNCL_YN	APNT_CNCL_YMD
2022-04-13 12:30:00.000000	42	PT22000071	CS	DR20090029	N	NULL
2022-04-13 15:30:00.000000	43	PT22000019	CS	DR20200012	N	NULL
2022-04-13 09:00:00.000000	46	PT22000043	CS	DR20090029	N	NULL
2022-07-09 11:00:00.000000	74	PT22000042	NP	DR20100011	N	NULL
2022-12-13 12:30:00.000000	110	PT22000097	NP	DR20160011	Y	2022-12-03
SQL을 실행하면 다음과 같이 출력되어야 합니다.

APNT_NO	PT_NAME	PT_NO	MCDP_CD	DR_NAME	APNT_YMD
46	오스왈드	PT22000043	CS	루피	2022-04-13 09:00:00.000000
42	몬몬	PT22000071	CS	루피	2022-04-13 12:30:00.000000
43	바라	PT22000019	CS	니모	2022-04-13 15:30:00.000000

A4. -- 코드를 입력하세요
-- 2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역 조회
-- 진료예약번호(A.APNT_NO), 환자이름(P.PT_NAME), 환자번호(P.PT_NO), 
-- 진료과코드(D.MCDP_CD), 의사이름(D.DR_NAME), 진료예약일시(A.APNT_YMD) 항목이 출력
-- 결과는 진료예약일시 기준 오름차순
SELECT
    A.APNT_NO,
    P.PT_NAME,
    P.PT_NO,
    D.MCDP_CD,
    D.DR_NAME,
    A.APNT_YMD
FROM APPOINTMENT A
LEFT JOIN DOCTOR D ON D.DR_ID = A.MDDR_ID
LEFT JOIN PATIENT P ON P.PT_NO = A.PT_NO
WHERE A.MCDP_CD = 'CS' AND DATE(A.APNT_YMD) = '2022-04-13' AND  A.APNT_CNCL_YMD IS NULL
ORDER BY A.APNT_YMD 

Q5. 문제 설명
다음은 어느 한 서점에서 판매중인 도서들의 도서 정보(BOOK), 저자 정보(AUTHOR) 테이블입니다.

BOOK 테이블은 각 도서의 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.

Column name	Type	Nullable	Description
BOOK_ID	INTEGER	FALSE	도서 ID
CATEGORY	VARCHAR(N)	FALSE	카테고리 (경제, 인문, 소설, 생활, 기술)
AUTHOR_ID	INTEGER	FALSE	저자 ID
PRICE	INTEGER	FALSE	판매가 (원)
PUBLISHED_DATE	DATE	FALSE	출판일
AUTHOR 테이블은 도서의 저자의 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.

Column name	Type	Nullable	Description
AUTHOR_ID	INTEGER	FALSE	저자 ID
AUTHOR_NAME	VARCHAR(N)	FALSE	저자명
BOOK_SALES 테이블은 각 도서의 날짜 별 판매량 정보를 담은 테이블로 아래와 같은 구조로 되어있습니다.

Column name	Type	Nullable	Description
BOOK_ID	INTEGER	FALSE	도서 ID
SALES_DATE	DATE	FALSE	판매일
SALES	INTEGER	FALSE	판매량
문제
2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여, 저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.

예시
예를 들어 BOOK 테이블과 AUTHOR 테이블, BOOK_SALES 테이블이 다음과 같다면

BOOK_ID	CATEGORY	AUTHOR_ID	PRICE	PUBLISHED_DATE
1	인문	1	10000	2020-01-01
2	경제	1	9000	2021-02-05
3	경제	2	9000	2021-03-11
AUTHOR_ID	AUTHOR_NAME
1	홍길동
2	김영호
BOOK_ID	SALES_DATE	SALES
1	2022-01-01	2
2	2022-01-02	3
1	2022-01-05	1
2	2022-01-20	5
2	2022-01-21	6
3	2022-01-22	2
2	2022-02-11	3
2022년 1월의 도서 별 총 매출액은 도서 ID 가 1 인 도서가 총 3권 * 10,000원 = 30,000원, 도서 ID 가 2 인 도서가 총 14권 * 9,000 = 126,000원 이고, 도서 ID 가 3 인 도서가 총 2권 * 9,000 = 18,000원 입니다.

저자 별 카테고리 별로 매출액을 집계하면 결과는 다음과 같습니다.

AUTHOR_ID	AUTHOR_NAME	CATEGORY	TOTAL_SALES
1	홍길동	인문	30000
1	홍길동	경제	126000
2	김영호	경제	18000
그리고 저자 ID, 카테고리 순으로 내림차순 정렬하면 다음과 같이 나와야 합니다.

AUTHOR_ID	AUTHOR_NAME	CATEGORY	TOTAL_SALES
1	홍길동	인문	30000
1	홍길동	경제	126000
2	김영호	경제	18000

A5. -- 코드를 입력하세요
-- 2022년 01월 도서 판매 데이터
-- 저자 별, 카테고리 별 매출액, 저자 ID, 저자명, 카테고리, 매출액
-- 결과 -> 저자 ID 오름차순, 카테고리 내림차순
SELECT
    A.AUTHOR_ID,
    A.AUTHOR_NAME,
    B.CATEGORY,
    SUM(B.PRICE * BS.SALES) AS TOTAL_SALES
FROM BOOK B
LEFT JOIN AUTHOR A ON B.AUTHOR_ID = A.AUTHOR_ID
LEFT JOIN BOOK_SALES BS ON B.BOOK_ID = BS.BOOK_ID
WHERE YEAR(BS.SALES_DATE) = 2022 AND MONTH(BS.SALES_DATE) = 1
GROUP BY A.AUTHOR_ID, B.CATEGORY
ORDER BY A.AUTHOR_ID, B.CATEGORY DESC

Q6. 문제 설명
다음은 어느 의류 쇼핑몰에 가입한 회원 정보를 담은 USER_INFO 테이블과 온라인 상품 판매 정보를 담은 ONLINE_SALE 테이블 입니다.USER_INFO 테이블은 아래와 같은 구조로 되어있으며 USER_ID, GENDER, AGE, JOINED는 각각 회원 ID, 성별, 나이, 가입일을 나타냅니다.

Column name	Type	Nullable
USER_ID	INTEGER	FALSE
GENDER	TINYINT(1)	TRUE
AGE	INTEGER	TRUE
JOINED	DATE	FALSE
GENDER 컬럼은 비어있거나 0 또는 1의 값을 가지며 0인 경우 남자를, 1인 경우는 여자를 나타냅니다.

ONLINE_SALE 테이블은 아래와 같은 구조로 되어있으며, ONLINE_SALE_ID, USER_ID, PRODUCT_ID, SALES_AMOUNT, SALES_DATE는 각각 온라인 상품 판매 ID, 회원 ID, 상품 ID, 판매량, 판매일을 나타냅니다.

Column name	Type	Nullable
ONLINE_SALE_ID	INTEGER	FALSE
USER_ID	INTEGER	FALSE
PRODUCT_ID	INTEGER	FALSE
SALES_AMOUNT	INTEGER	FALSE
SALES_DATE	DATE	FALSE
동일한 날짜, 회원 ID, 상품 ID 조합에 대해서는 하나의 판매 데이터만 존재합니다.

문제
USER_INFO 테이블과 ONLINE_SALE 테이블에서 년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성해주세요. 결과는 년, 월, 성별을 기준으로 오름차순 정렬해주세요. 이때, 성별 정보가 없는 경우 결과에서 제외해주세요.

예시
예를 들어 USER_INFO 테이블이 다음과 같고

USER_ID	GENDER	AGE	JOINED
1	1	26	2021-06-01
2	NULL	NULL	2021-06-25
3	0	NULL	2021-06-30
4	0	31	2021-07-03
5	1	25	2021-07-09
6	1	33	2021-07-14
ONLINE_SALE 테이블이 다음과 같다면

ONLINE_SALE_ID	USER_ID	PRODUCT_ID	SALES_AMOUNT	SALES_DATE
1	1	54	1	2022-01-01
2	1	3	2	2022-01-25
3	4	34	1	2022-01-30
4	6	253	3	2022-02-03
5	2	31	2	2022-02-09
6	5	35	1	2022-02-14
7	5	57	1	2022-02-18
2022년 1월에 상품을 구매한 회원은 USER_ID 가 1(GENDER=1), 4(GENDER=0)인 회원들이고,
2022년 2월에 상품을 구매한 회원은 USER_ID 가 2(GENDER=NULL), 5(GENDER=1), 6(GENDER=1)인 회원들 이므로,

년, 월, 성별 별로 상품을 구매한 회원수를 집계하고, 년, 월, 성별을 기준으로 오름차순 정렬하면 다음과 같은 결과가 나와야 합니다.

YEAR	MONTH	GENDER	USERS
2022	1	0	1
2022	1	1	1
2022	2	1	2

A6. -- 코드를 입력하세요
-- 각 테이블에서 년, 월, 성별 결로 상품을 구매한 회원수
-- 결과는 년, 월, 성별 기준 오름차순
-- 성별 정보 없으면 결과에서 제외
# SELECT *
# FROM USER_INFO UI
# RIGHT JOIN ONLINE_SALE OS 
# ON UI.USER_ID = OS.USER_ID
WITH SELL_USER AS(
    SELECT 
        USER_ID,
        YEAR(SALES_DATE) AS YEAR,
        MONTH(SALES_DATE) AS MONTH
    FROM ONLINE_SALE
)
SELECT
    SU.YEAR,
    SU.MONTH,
    UI.GENDER,
    COUNT(DISTINCT SU.USER_ID) AS USERS
FROM USER_INFO UI
LEFT JOIN SELL_USER SU ON UI.USER_ID = SU.USER_ID
WHERE UI.GENDER IS NOT NULL AND SU.YEAR IS NOT NULL AND UI.GENDER IS NOT NULL
GROUP BY SU.MONTH, UI.GENDER
ORDER BY YEAR, MONTH, GENDER

Q7. 문제 설명
다음은 식당의 정보를 담은 REST_INFO 테이블과 식당의 리뷰 정보를 담은 REST_REVIEW 테이블입니다. REST_INFO 테이블은 다음과 같으며 REST_ID, REST_NAME, FOOD_TYPE, VIEWS, FAVORITES, PARKING_LOT, ADDRESS, TEL은 식당 ID, 식당 이름, 음식 종류, 조회수, 즐겨찾기수, 주차장 유무, 주소, 전화번호를 의미합니다.

Column name	Type	Nullable
REST_ID	VARCHAR(5)	FALSE
REST_NAME	VARCHAR(50)	FALSE
FOOD_TYPE	VARCHAR(20)	TRUE
VIEWS	NUMBER	TRUE
FAVORITES	NUMBER	TRUE
PARKING_LOT	VARCHAR(1)	TRUE
ADDRESS	VARCHAR(100)	TRUE
TEL	VARCHAR(100)	TRUE
REST_REVIEW 테이블은 다음과 같으며 REVIEW_ID, REST_ID, MEMBER_ID, REVIEW_SCORE, REVIEW_TEXT,REVIEW_DATE는 각각 리뷰 ID, 식당 ID, 회원 ID, 점수, 리뷰 텍스트, 리뷰 작성일을 의미합니다.

Column name	Type	Nullable
REVIEW_ID	VARCHAR(10)	FALSE
REST_ID	VARCHAR(10)	TRUE
MEMBER_ID	VARCHAR(100)	TRUE
REVIEW_SCORE	NUMBER	TRUE
REVIEW_TEXT	VARCHAR(1000)	TRUE
REVIEW_DATE	DATE	TRUE
문제
REST_INFO와 REST_REVIEW 테이블에서 서울에 위치한 식당들의 식당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회하는 SQL문을 작성해주세요. 이때 리뷰 평균점수는 소수점 세 번째 자리에서 반올림 해주시고 결과는 평균점수를 기준으로 내림차순 정렬해주시고, 평균점수가 같다면 즐겨찾기수를 기준으로 내림차순 정렬해주세요.

예시
REST_INFO 테이블이 다음과 같고

REST_ID	REST_NAME	FOOD_TYPE	VIEWS	FAVORITES	PARKING_LOT	ADDRESS	TEL
00028	대우부대찌개	한식	52310	10	N	경기도 용인시 처인구 남사읍 처인성로 309	031-235-1235
00039	광주식당	한식	23001	20	N	경기도 부천시 산업로8번길 60	031-235-6423
00035	삼촌식당	일식	532123	80	N	서울특별시 강서구 가로공원로76가길	02-135-1266
REST_REVIEW 테이블이 다음과 같을 때

REVIEW_ID	REST_ID	MEMBER_ID	REVIEW_SCORE	REVIEW_TEXT	REVIEW_DATE
R000000065	00028	soobin97@naver.com	5	부찌 국물에서 샤브샤브 맛이나고 깔끔	2022-04-12
R000000066	00039	yelin1130@gmail.com	5	김치찌개 최곱니다.	2022-02-12
R000000067	00028	yelin1130@gmail.com	5	햄이 많아서 좋아요	2022-02-22
R000000068	00035	ksyi0316@gmail.com	5	숙성회가 끝내줍니다.	2022-02-15
R000000069	00035	yoonsy95@naver.com	4	비린내가 전혀없어요.	2022-04-16
SQL을 실행하면 다음과 같이 출력되어야 합니다.

REST_ID	REST_NAME	FOOD_TYPE	FAVORITES	ADDRESS	SCORE
00035	삼촌식당	일식	80	서울특별시 강서구 가로공원로76가길	4.50

A7. -- 코드를 입력하세요
-- 서울에 위치한 식당 -> CTE
-- 당 ID, 식당 이름, 음식 종류, 즐겨찾기수, 주소, 리뷰 평균 점수를 조회
-- 리뷰 평균점수는 소수점 세 번째 자리에서 반올림
-- 평균점수 기준 내림차순, 즐겨찾기수 기준 내림차순
SELECT 
    RI.REST_ID,
    RI.REST_NAME,
    RI.FOOD_TYPE,
    RI.FAVORITES,
    RI.ADDRESS,
    ROUND(AVG(REVIEW_SCORE),2) AS SCORE
FROM REST_INFO RI
INNER JOIN REST_REVIEW RR ON RI.REST_ID = RR.REST_ID
WHERE RI.ADDRESS LIKE "서울%"
GROUP BY RI.REST_ID
ORDER BY SCORE DESC, RI.FAVORITES DESC

------------------------------------------------------------------
-- CTE 사용한 쿼리
WITH SEOUL_REST AS(
    SELECT
        REST_ID,
        REST_NAME,
        FOOD_TYPE,
        FAVORITES,
        ADDRESS
    FROM REST_INFO
    WHERE ADDRESS LIKE "서울%"
)
SELECT
    RR.REST_ID,
    SR.REST_NAME,
    SR.FOOD_TYPE,
    SR.FAVORITES,
    SR.ADDRESS,
    ROUND(AVG(RR.REVIEW_SCORE), 2) AS SCORE
FROM REST_REVIEW RR
INNER JOIN SEOUL_REST SR ON RR.REST_ID = SR.REST_ID
GROUP BY RR.REST_ID
ORDER BY SCORE DESC, SR.FAVORITES DESC

Q8. 문제 설명
CART_PRODUCTS 테이블은 장바구니에 담긴 상품 정보를 담은 테이블입니다. CART_PRODUCTS 테이블의 구조는 다음과 같으며, ID, CART_ID, NAME, PRICE는 각각 테이블의 아이디, 장바구니의 아이디, 상품 종류, 가격을 나타냅니다.

NAME	TYPE
ID	INT
CART_ID	INT
NAME	VARCHAR
PRICE	INT
데이터 분석 팀에서는 우유(Milk)와 요거트(Yogurt)를 동시에 구입한 장바구니가 있는지 알아보려 합니다. 우유와 요거트를 동시에 구입한 장바구니의 아이디를 조회하는 SQL 문을 작성해주세요. 이때 결과는 장바구니의 아이디 순으로 나와야 합니다.

예시
예를 들어 CART_PRODUCTS 테이블이 다음과 같다면

CART_PRODUCTS 테이블

ID	CART_ID	NAME	PRICE
1630	83	Cereal	3980
1631	83	Multipurpose Supply	3900
5491	286	Yogurt	2980
5504	286	Milk	1880
8435	448	Milk	1880
8437	448	Yogurt	2980
8438	448	Tea	11000
20236	1034	Yogurt	2980
20237	1034	Butter	4890
83번 장바구니에는 Milk와 Yogurt가 모두 없습니다.
286번 장바구니에는 Milk와 Yogurt가 모두 있습니다.
448번 장바구니에는 Milk와 Yogurt가 모두 있습니다.
1034번 장바구니에는 Milk는 없고 Yogurt만 있습니다.
따라서 SQL 문을 실행하면 다음과 같이 나와야 합니다.

CART_ID
286
448

A8. -- 코드를 입력하세요
-- Milk와 Yogurt 동시에 구입한 장바구니가 있는지
-- 동시에 구입한 장바구니 아이디 조회
-- 장바구니의 아이디 순서
SELECT 
    CART_ID
FROM CART_PRODUCTS
WHERE NAME IN ('Milk', 'Yogurt') 
GROUP BY CART_ID
HAVING COUNT(DISTINCT(NAME)) = 2
ORDER BY CART_ID

Q9. 문제 설명
다음은 아이스크림 가게의 상반기 주문 정보를 담은 FIRST_HALF 테이블과 7월의 아이스크림 주문 정보를 담은 JULY 테이블입니다. FIRST_HALF 테이블 구조는 다음과 같으며, SHIPMENT_ID, FLAVOR, TOTAL_ORDER는 각각 아이스크림 공장에서 아이스크림 가게까지의 출하 번호, 아이스크림 맛, 상반기 아이스크림 총주문량을 나타냅니다. FIRST_HALF 테이블의 기본 키는 FLAVOR입니다. FIRST_HALF테이블의 SHIPMENT_ID는 JULY테이블의 SHIPMENT_ID의 외래 키입니다.

NAME	TYPE	NULLABLE
SHIPMENT_ID	INT(N)	FALSE
FLAVOR	VARCHAR(N)	FALSE
TOTAL_ORDER	INT(N)	FALSE
JULY 테이블 구조는 다음과 같으며, SHIPMENT_ID, FLAVOR, TOTAL_ORDER 은 각각 아이스크림 공장에서 아이스크림 가게까지의 출하 번호, 아이스크림 맛, 7월 아이스크림 총주문량을 나타냅니다. JULY 테이블의 기본 키는 SHIPMENT_ID입니다. JULY테이블의 FLAVOR는 FIRST_HALF 테이블의 FLAVOR의 외래 키입니다. 7월에는 아이스크림 주문량이 많아 같은 아이스크림에 대하여 서로 다른 두 공장에서 아이스크림 가게로 출하를 진행하는 경우가 있습니다. 이 경우 같은 맛의 아이스크림이라도 다른 출하 번호를 갖게 됩니다.

NAME	TYPE	NULLABLE
SHIPMENT_ID	INT(N)	FALSE
FLAVOR	VARCHAR(N)	FALSE
TOTAL_ORDER	INT(N)	FALSE
문제
7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하는 SQL 문을 작성해주세요.

예시
예를 들어 FIRST_HALF 테이블이 다음과 같고

SHIPMENT_ID	FLAVOR	TOTAL_ORDER
101	chocolate	3200
102	vanilla	2800
103	mint_chocolate	1700
104	caramel	2600
105	white_chocolate	3100
106	peach	2450
107	watermelon	2150
108	mango	2900
109	strawberry	3100
110	melon	3150
111	orange	2900
112	pineapple	2900
JULY테이블이 다음과 같다면

SHIPMENT_ID	FLAVOR	TOTAL_ORDER
101	chocolate	520
102	vanilla	560
103	mint_chocolate	400
104	caramel	460
105	white_chocolate	350
106	peach	500
107	watermelon	780
108	mango	790
109	strawberry	520
110	melon	400
111	orange	250
112	pineapple	200
208	mango	110
209	strawberry	220
7월 아이스크림 총주문량과 상반기의 아이스크림 총 주문량을 더한 값이 큰 순서대로 상위 3개의 맛을 조회하면 strawberry(520 + 220 + 3,100 = 3,840), mango(790 + 110 + 2,900 = 3,800), chocolate(520 + 3,200 = 3,720) 순입니다. 따라서 SQL 문을 실행하면 다음과 같이 나와야 합니다.

FLAVOR
strawberry
mango
chocolate

A9. -- 코드를 입력하세요
-- 7월 아이스크림 총 주문량과 상반기의 아이스크림 총 주문량 더한 값
-- 상위 3개의 맛 조회
WITH JULY_ICE AS(
    SELECT
        J.SHIPMENT_ID,
        J.FLAVOR,
        SUM(J.TOTAL_ORDER) + SUM(FH.TOTAL_ORDER) AS SUM_TOTAL_ORDER
    FROM JULY J
    LEFT JOIN FIRST_HALF FH ON J.SHIPMENT_ID = FH.SHIPMENT_ID
    GROUP BY J.FLAVOR
)
SELECT 
    FLAVOR
FROM JULY_ICE
ORDER BY SUM_TOTAL_ORDER DESC
LIMIT 3

Q10. 문제 설명
HR_DEPARTMENT 테이블은 회사의 부서 정보를 담은 테이블입니다. HR_DEPARTMENT 테이블의 구조는 다음과 같으며 DEPT_ID, DEPT_NAME_KR, DEPT_NAME_EN, LOCATION은 각각 부서 ID, 국문 부서명, 영문 부서명, 부서 위치를 의미합니다.

Column name	Type	Nullable
DEPT_ID	VARCHAR	FALSE
DEPT_NAME_KR	VARCHAR	FALSE
DEPT_NAME_EN	VARCHAR	FALSE
LOCATION	VARCHAR	FLASE
HR_EMPLOYEES 테이블은 회사의 사원 정보를 담은 테이블입니다. HR_EMPLOYEES 테이블의 구조는 다음과 같으며 EMP_NO, EMP_NAME, DEPT_ID, POSITION, EMAIL, COMP_TEL, HIRE_DATE, SAL은 각각 사번, 성명, 부서 ID, 직책, 이메일, 전화번호, 입사일, 연봉을 의미합니다.

Column name	Type	Nullable
EMP_NO	VARCHAR	FALSE
EMP_NAME	VARCHAR	FALSE
DEPT_ID	VARCHAR	FALSE
POSITION	VARCHAR	FALSE
EMAIL	VARCHAR	FALSE
COMP_TEL	VARCHAR	FALSE
HIRE_DATE	DATE	FALSE
SAL	NUMBER	FALSE
HR_GRADE 테이블은 2022년 사원의 평가 정보를 담은 테이블입니다. HR_GRADE의 구조는 다음과 같으며 EMP_NO, YEAR, HALF_YEAR, SCORE는 각각 사번, 연도, 반기, 평가 점수를 의미합니다.

Column name	Type	Nullable
EMP_NO	VARCHAR	FALSE
YEAR	NUMBER	FALSE
HALF_YEAR	NUMBER	FALSE
SCORE	NUMBER	FALSE
문제
HR_DEPARTMENT, HR_EMPLOYEES, HR_GRADE 테이블을 이용해 사원별 성과금 정보를 조회하려합니다. 평가 점수별 등급과 등급에 따른 성과금 정보가 아래와 같을 때, 사번, 성명, 평가 등급, 성과금을 조회하는 SQL문을 작성해주세요.

평가등급의 컬럼명은 GRADE로, 성과금의 컬럼명은 BONUS로 해주세요.
결과는 사번 기준으로 오름차순 정렬해주세요.

기준 점수	평가 등급	성과금(연봉 기준)
96 이상	S	20%
90 이상	A	15%
80 이상	B	10%
이외	C	0%
예시
HR_DEPARTMENT 테이블이 다음과 같고

DEPT_ID	DEPT_NAME_KR	DEPT_NAME_EN	LOCATION
D0001	법무팀	Law Dep	그렙타워 4층
D0002	인사팀	Human resources	그렙타워 4층
D0003	총무팀	General Affairs	그렙타워 4층
HR_EMPLOYEES 테이블이 다음과 같고

EMP_NO	EMP_NAME	DEPT_ID	POSITION	EMAIL	COMP_TEL	HIRE_DATE	SAL
2017002	정호식	D0001	팀장	hosick_jung@grep.com	031-8000-1101	2017-03-01	65000000
2018001	김민석	D0001	팀원	minseock_kim@grep.com	031-8000-1102	2018-03-01	60000000
2019001	김솜이	D0002	팀장	somi_kim@grep.com	031-8000-1106	2019-03-01	60000000
2020002	김연주	D0002	팀원	yeonjoo_kim@grep.com	031-8000-1107	2020-03-01	53000000
2020005	양성태	D0003	팀원	sungtae_yang@grep.com	031-8000-1112	2020-03-01	53000000
HR_GRADE 테이블이 다음과 같을 때

EMP_NO	YEAR	HALF_YEAR	SCORE
2017002	2022	1	92
2018001	2022	1	89
2019001	2022	1	94
2020002	2022	1	90
2020005	2022	1	92
2017002	2022	2	84
2018001	2022	2	89
2019001	2022	2	81
2020002	2022	2	91
2020005	2022	2	81
다음과 같이 사원별 성과금 정보를 출력해야 합니다.

EMP_NO	EMP_NAME	GRADE	BONUS
2017002	정호식	B	6500000
2018001	김민석	B	6000000
2019001	김솜이	B	6000000
2020002	김연주	A	7950000
2020005	양성태	B	5300000

A10. # -- 코드를 작성해주세요
# -- 96점 이상 : S, 성과금 20% // 90점 이상 : A, 성과금 15% // 80점 이상 : B, 성과금 10% // 이외 : C
# -- 평가 등급의 컬럼명 GRADE, 성과금 컬럼명 BONUS
# -- 결과는 사번 기준 오름차순
WITH SCORE_TAB AS(
SELECT
    HE.EMP_NO,
    HE.EMP_NAME,
    AVG(HG.SCORE) AS SCORE
FROM HR_EMPLOYEES HE
LEFT JOIN HR_GRADE HG ON HG.EMP_NO = HE.EMP_NO
GROUP BY HE.EMP_NO
), GRADE_TAB AS(
SELECT 
    ST.EMP_NO,
    ST.EMP_NAME,
    HE.SAL,
    CASE
        WHEN SCORE >= 96 THEN 'S'
        WHEN SCORE >= 90 THEN 'A'
        WHEN SCORE >= 80 THEN 'B'
        ELSE 'C'
    END AS GRADE
FROM SCORE_TAB ST
LEFT JOIN HR_EMPLOYEES HE ON ST.EMP_NO = HE.EMP_NO
)
SELECT
    ST.EMP_NO,
    ST.EMP_NAME,
    GT.GRADE,
    CASE
        WHEN GRADE = 'S' THEN (GT.SAL * 0.2)
        WHEN GRADE = 'A' THEN (GT.SAL * 0.15)
        WHEN GRADE = 'B' THEN (GT.SAL * 0.1)
        ELSE 0
     END AS BONUS
FROM SCORE_TAB ST
LEFT JOIN GRADE_TAB GT ON ST.EMP_NO = GT.EMP_NO
ORDER BY ST.EMP_NO

Q11. 
