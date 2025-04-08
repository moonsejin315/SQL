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

Q5. 문제 설명
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
관리자의 실수로 일부 동물의 입양일이 잘못 입력되었습니다. 보호 시작일보다 입양일이 더 빠른 동물의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 시작일이 빠른 순으로 조회해야합니다.

예시
예를 들어, ANIMAL_INS 테이블과 ANIMAL_OUTS 테이블이 다음과 같다면

ANIMAL_INS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	INTAKE_CONDITION	NAME	SEX_UPON_INTAKE
A350276	Cat	2017-08-13 13:50:00	Normal	Jewel	Spayed Female
A381217	Dog	2017-07-08 09:41:00	Sick	Cherokee	Neutered Male
ANIMAL_OUTS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	NAME	SEX_UPON_OUTCOME
A350276	Cat	2018-01-28 17:51:00	Jewel	Spayed Female
A381217	Dog	2017-06-09 18:51:00	Cherokee	Neutered Male
SQL문을 실행하면 다음과 같이 나와야 합니다.

ANIMAL_ID	NAME
A381217	Cherokee

정답
-- 코드를 입력하세요
-- 보호 시작일보다 입양일이 더 빠른 동물
SELECT
    AI.ANIMAL_ID,
    AO.NAME
FROM ANIMAL_INS AI
JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AI.DATETIME > AO.DATETIME
ORDER BY AI.DATETIME

Q6. 문제 설명
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
입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.

예시
예를 들어, ANIMAL_INS 테이블과 ANIMAL_OUTS 테이블이 다음과 같다면

ANIMAL_INS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	INTAKE_CONDITION	NAME	SEX_UPON_INTAKE
A354597	Cat	2014-05-02 12:16:00	Normal	Ariel	Spayed Female
A362707	Dog	2016-01-27 12:27:00	Sick	Girly Girl	Spayed Female
A370507	Cat	2014-10-27 14:43:00	Normal	Emily	Spayed Female
A414513	Dog	2016-06-07 09:17:00	Normal	Rocky	Neutered Male
ANIMAL_OUTS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	NAME	SEX_UPON_OUTCOME
A354597	Cat	2014-06-03 12:30:00	Ariel	Spayed Female
A362707	Dog	2017-01-10 10:44:00	Girly Girl	Spayed Female
A370507	Cat	2015-08-15 09:24:00	Emily	Spayed Female
SQL문을 실행하면 다음과 같이 나와야 합니다.

ANIMAL_ID	NAME
A362707	Girly Girl
A370507	Emily
※ 입양을 간 동물이 2마리 이상인 경우만 입력으로 주어집니다.

정답
-- 코드를 입력하세요
-- 입양을 간 동물 중(OUTS 날짜 O), 보호 기간이 가장 길었던 동물 두 마리
SELECT 
    ANIMAL_ID,
    NAME
FROM(SELECT 
    AI.ANIMAL_ID AS ANIMAL_ID,
    AI.NAME AS NAME,
    DATEDIFF(AO.DATETIME, AI.DATETIME) AS DATE
FROM ANIMAL_INS AI
JOIN ANIMAL_OUTS AO ON AI.ANIMAL_ID = AO.ANIMAL_ID
WHERE AO.DATETIME IS NOT NULL
ORDER BY DATE DESC
LIMIT 2
) AS SELECTED

Q7. 문제 설명
다음은 중고 거래 게시판 정보를 담은 USED_GOODS_BOARD 테이블과 중고 거래 게시판 사용자 정보를 담은 USED_GOODS_USER 테이블입니다. USED_GOODS_BOARD 테이블은 다음과 같으며 BOARD_ID, WRITER_ID, TITLE, CONTENTS, PRICE, CREATED_DATE, STATUS, VIEWS는 게시글 ID, 작성자 ID, 게시글 제목, 게시글 내용, 가격, 작성일, 거래상태, 조회수를 의미합니다.

Column name	Type	Nullable
BOARD_ID	VARCHAR(5)	FALSE
WRITER_ID	VARCHAR(50)	FALSE
TITLE	VARCHAR(100)	FALSE
CONTENTS	VARCHAR(1000)	FALSE
PRICE	NUMBER	FALSE
CREATED_DATE	DATE	FALSE
STATUS	VARCHAR(10)	FALSE
VIEWS	NUMBER	FALSE
USED_GOODS_USER 테이블은 다음과 같으며 USER_ID, NICKNAME, CITY, STREET_ADDRESS1, STREET_ADDRESS2, TLNO는 각각 회원 ID, 닉네임, 시, 도로명 주소, 상세 주소, 전화번호를 를 의미합니다.

Column name	Type	Nullable
USER_ID	VARCHAR(50)	FALSE
NICKNAME	VARCHAR(100)	FALSE
CITY	VARCHAR(100)	FALSE
STREET_ADDRESS1	VARCHAR(100)	FALSE
STREET_ADDRESS2	VARCHAR(100)	TRUE
TLNO	VARCHAR(20)	FALSE
문제
USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 완료된 중고 거래의 총금액이 70만 원 이상인 사람의 회원 ID, 닉네임, 총거래금액을 조회하는 SQL문을 작성해주세요. 결과는 총거래금액을 기준으로 오름차순 정렬해주세요.

예시
USED_GOODS_BOARD 테이블이 다음과 같고

BOARD_ID	WRITER_ID	TITLE	CONTENTS	PRICE	CREATED_DATE	STATUS	VIEWS
B0001	zkzkdh1	캠핑의자	가벼워요 깨끗한 상태입니다. 2개	25000	2022-11-29	SALE	34
B0002	miyeon89	벽걸이 에어컨	엘지 휘센 7평	100000	2022-11-29	SALE	55
B0003	dhfkzmf09	에어팟 맥스	에어팟 맥스 스카이 블루 색상 판매합니다.	450000	2022-11-26	DONE	67
B0004	sangjune1	파파야나인 포르쉐 푸쉬카	예민하신분은 피해주세요	30000	2022-11-30	DONE	78
B0005	zkzkdh1	애플워치7	애플워치7 실버 스텐 45미리 판매합니다.	700000	2022-11-30	DONE	99
USED_GOODS_USER 테이블이 다음과 같을 때

USER_ID	NICKNAME	CITY	STREET_ADDRESS1	STREET_ADDRESS2	TLNO
cjfwls91	점심만금식	성남시	분당구 내정로 185	501호	01036344964
zkzkdh1	후후후	성남시	분당구 내정로 35	가동 1202호	01032777543
spdlqj12	크크큭	성남시	분당구 수내로 206	2019동 801호	01087234922
xlqpfh2	잉여킹	성남시	분당구 수내로 1	001-004	01064534911
dhfkzmf09	찐찐	성남시	분당구 수내로 13	A동 1107호	01053422914
SQL을 실행하면 다음과 같이 출력되어야 합니다.

USER_ID	NICKNAME	TOTAL_SALES
zkzkdh1	후후후	700000

정답
-- 코드를 입력하세요
-- 완료된 중고 거래의 총금액 70만원 이상
-- 회원ID, 닉네임, 총거래금액
-- 총거래금액 오름차순
SELECT 
    U.USER_ID AS USER_ID,
    U.NICKNAME AS NICKNAME,
    SUM(B.PRICE) AS PRICE
FROM USED_GOODS_BOARD B
JOIN USED_GOODS_USER U ON B.WRITER_ID = U.USER_ID
WHERE STATUS = 'DONE'
GROUP BY USER_ID
HAVING PRICE >= 700000
ORDER BY PRICE

Q8. 문제 설명
다음은 식당의 정보를 담은 REST_INFO 테이블입니다. REST_INFO 테이블은 다음과 같으며 REST_ID, REST_NAME, FOOD_TYPE, VIEWS, FAVORITES, PARKING_LOT, ADDRESS, TEL은 식당 ID, 식당 이름, 음식 종류, 조회수, 즐겨찾기수, 주차장 유무, 주소, 전화번호를 의미합니다.

Column name	Type	Nullable
REST_ID	VARCHAR(5)	FALSE
REST_NAME	VARCHAR(50)	FALSE
FOOD_TYPE	VARCHAR(20)	TRUE
VIEWS	NUMBER	TRUE
FAVORITES	NUMBER	TRUE
PARKING_LOT	VARCHAR(1)	TRUE
ADDRESS	VARCHAR(100)	TRUE
TEL	VARCHAR(100)	TRUE
문제
REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요. 이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.

예시
REST_INFO 테이블이 다음과 같을 때

REST_ID	REST_NAME	FOOD_TYPE	VIEWS	FAVORITES	PARKING_LOT	ADDRESS	TEL
00001	은돼지식당	한식	1150345	734	N	서울특별시 중구 다산로 149	010-4484-8751
00002	하이가쯔네	일식	120034	112	N	서울시 중구 신당동 375-21	NULL
00003	따띠따띠뜨	양식	1234023	102	N	서울시 강남구 신사동 627-3 1F	02-6397-1023
00004	스시사카우스	일식	1522074	230	N	서울시 서울시 강남구 신사동 627-27	010-9394-2554
00005	코슌스	일식	15301	123	N	서울특별시 강남구 언주로153길	010-1315-8729
SQL을 실행하면 다음과 같이 출력되어야 합니다.

FOOD_TYPE	REST_ID	REST_NAME	FAVORITES
한식	00001	은돼지식당	734
일식	00004	스시사카우스	230
양식	00003	따띠따띠뜨	102

정답 
-- 코드를 입력하세요
-- 음식종류별 즐겨찾기 가장 많은
-- 음식종류 기준 내림차순
SELECT
    FOOD_TYPE,
    REST_ID,
    REST_NAME,
    FAVORITES
FROM REST_INFO
WHERE FAVORITES IN 
    (SELECT MAX(FAVORITES)
    FROM REST_INFO
    GROUP BY FOOD_TYPE)
GROUP BY FOOD_TYPE
ORDER BY FOOD_TYPE DESC

Q9. 문제 설명
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
문제
HR_DEPARTMENT와 HR_EMPLOYEES 테이블을 이용해 부서별 평균 연봉을 조회하려 합니다. 부서별로 부서 ID, 영문 부서명, 평균 연봉을 조회하는 SQL문을 작성해주세요.

평균연봉은 소수점 첫째 자리에서 반올림하고 컬럼명은 AVG_SAL로 해주세요.
결과는 부서별 평균 연봉을 기준으로 내림차순 정렬해주세요.

예시
HR_DEPARTMENT 테이블이 다음과 같고

DEPT_ID	DEPT_NAME_KR	DEPT_NAME_EN	LOCATION
D0005	재무팀	Finance	그렙타워 5층
D0006	구매팀	Purchasing	그렙타워 5층
D0007	마케팅팀	Marketing	그렙타워 6층
HR_EMPLOYEES 테이블이 다음과 같을 때

EMP_NO	EMP_NAME	DEPT_ID	POSITION	EMAIL	COMP_TEL	HIRE_DATE	SAL
2019003	한동희	D0005	팀장	donghee_han@grep.com	031-8000-1122	2019-03-01	57000000
2020032	한명지	D0005	팀원	mungji_han@grep.com	031-8000-1123	2020-03-01	52000000
2022003	김보라	D0005	팀원	bora_kim@grep.com	031-8000-1126	2022-03-01	47000000
2018005	이재정	D0006	팀장	jaejung_lee@grep.com	031-8000-1127	2018-03-01	60000000
2019032	윤성희	D0006	팀원	sunghee_yoon@grep.com	031-8000-1128	2019-03-01	57000000
2020009	송영섭	D0006	팀원	yungseop_song@grep.com	031-8000-1130	2020-03-01	51000000
2021006	이성주	D0006	팀원	sungju_lee@grep.com	031-8000-1131	2021-03-01	49000000
2018004	이주리	D0007	팀장	joori_lee@grep.com	031-8000-1132	2018-03-01	61000000
2020012	김사랑	D0007	팀원	sarang_kim@grep.com	031-8000-1133	2020-03-01	54000000
2021018	김히라	D0007	팀원	heera_kim@grep.com	031-8000-1136	2021-03-01	49000000
SQL을 실행하면 다음과 같이 출력되어야 합니다.

DEPT_ID	DEPT_NAME_EN	AVG_SAL
D0007	Marketing	54666667
D0006	Purchasing	54250000
D0005	Finance	52000000

정답
-- 코드를 작성해주세요
-- 부서별 평균 연봉을 조회 
-- 평균연봉은 소수점 첫째 자리에서 반올림 -> 컬럼명 AVG_SAL
-- 결과는 부서별 평균 연봉 기준 내림차순
SELECT 
    D.DEPT_ID,
    D.DEPT_NAME_EN,
    ROUND(AVG(E.SAL),0) AS AVG_SAL
FROM HR_DEPARTMENT D
JOIN HR_EMPLOYEES E ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_ID
ORDER BY AVG_SAL DESC

Q10. 문제 설명
다음은 중고 거래 게시판 정보를 담은 USED_GOODS_BOARD 테이블과 중고 거래 게시판 첨부파일 정보를 담은 USED_GOODS_USER 테이블입니다. USED_GOODS_BOARD 테이블은 다음과 같으며 BOARD_ID, WRITER_ID, TITLE, CONTENTS, PRICE, CREATED_DATE, STATUS, VIEWS는 게시글 ID, 작성자 ID, 게시글 제목, 게시글 내용, 가격, 작성일, 거래상태, 조회수를 의미합니다.

Column name	Type	Nullable
BOARD_ID	VARCHAR(5)	FALSE
WRITER_ID	VARCHAR(50)	FALSE
TITLE	VARCHAR(100)	FALSE
CONTENTS	VARCHAR(1000)	FALSE
PRICE	NUMBER	FALSE
CREATED_DATE	DATE	FALSE
STATUS	VARCHAR(10)	FALSE
VIEWS	NUMBER	FALSE
USED_GOODS_USER 테이블은 다음과 같으며 USER_ID, NICKNAME, CITY, STREET_ADDRESS1, STREET_ADDRESS2, TLNO는 각각 회원 ID, 닉네임, 시, 도로명 주소, 상세 주소, 전화번호를 의미합니다.

Column name	Type	Nullable
USER_ID	VARCHAR(50)	FALSE
NICKANME	VARCHAR(100)	FALSE
CITY	VARCHAR(100)	FALSE
STREET_ADDRESS1	VARCHAR(100)	FALSE
STREET_ADDRESS2	VARCHAR(100)	TRUE
TLNO	VARCHAR(20)	FALSE
문제
USED_GOODS_BOARD와 USED_GOODS_USER 테이블에서 중고 거래 게시물을 3건 이상 등록한 사용자의 사용자 ID, 닉네임, 전체주소, 전화번호를 조회하는 SQL문을 작성해주세요. 이때, 전체 주소는 시, 도로명 주소, 상세 주소가 함께 출력되도록 해주시고, 전화번호의 경우 xxx-xxxx-xxxx 같은 형태로 하이픈 문자열(-)을 삽입하여 출력해주세요. 결과는 회원 ID를 기준으로 내림차순 정렬해주세요.

예시
USED_GOODS_BOARD 테이블이 다음과 같고

BOARD_ID	WRITER_ID	TITLE	CONTENTS	PRICE	CREATED_DATE	STATUS	VIEWS
B0001	dhfkzmf09	칼라거펠트 코트	양모 70%이상 코트입니다.	120000	2022-10-14	DONE	104
B0002	lee871201	국내산 볶음참깨	직접 농사지은 참깨입니다.	3000	2022-10-02	DONE	121
B0003	dhfkzmf09	나이키 숏패팅	사이즈는 M입니다.	40000	2022-10-17	DONE	98
B0004	kwag98	반려견 배변패드 팝니다	정말 저렴히 판매합니다. 전부 미개봉 새상품입니다.	12000	2022-10-01	DONE	250
B0005	dhfkzmf09	PS4	PS5 구매로인해 팝니다.	250000	2022-11-03	DONE	111
USED_GOODS_USER 테이블이 다음과 같을 때

USER_ID	NICKNAME	CITY	STREET_ADDRESS1	STREET_ADDRESS2	TLNO
dhfkzmf09	찐찐	성남시	분당구 수내로 13	A동 1107호	01053422914
dlPcks90	썹썹	성남시	분당구 수내로 74	401호	01034573944
cjfwls91	점심만금식	성남시	분당구 내정로 185	501호	01036344964
dlfghks94	희망	성남시	분당구 내정로 101	203동 102호	01032634154
rkdhs95	용기	성남시	분당구 수내로 23	501호	01074564564
SQL을 실행하면 다음과 같이 출력되어야 합니다.

USER_ID	NICKNAME	전체주소	전화번호
dhfkzmf09	찐찐	성남시 분당구 수내로 13 A동 1107호	010-5342-2914

정답
-- 코드를 입력하세요
-- 중고거래 게시물을 3건 이상 등록한 사람
-- 사용자ID, 닉네임, 전체주소, 전화번호
-- 주소 -> 시,도로명주소, 상세주소 함께 출력
-- 전화번호 -> xxx-xxxx-xxxx
-- 회원ID 기준 내림차순 정렬
SELECT
    B.WRITER_ID AS USER_ID,
    U.NICKNAME AS NICKNAME,
    CONCAT(U.CITY, " ", U.STREET_ADDRESS1, " ",U.STREET_ADDRESS2) AS 전체주소,
    CONCAT(
        SUBSTRING(U.TLNO, 1, 3), '-',
        SUBSTRING(U.TLNO, 4, 4), '-',
        SUBSTRING(U.TLNO, 8, 4)
    ) AS 전화번호
FROM USED_GOODS_BOARD B
JOIN USED_GOODS_USER U ON B.WRITER_ID = U.USER_ID
GROUP BY WRITER_ID
HAVING COUNT(USER_ID) >= 3
ORDER BY USER_ID DESC

Q11. 문제 설명
대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.
다음은 실험실에서 배양한 대장균들의 정보를 담은 ECOLI_DATA 테이블입니다. ECOLI_DATA 테이블의 구조는 다음과 같으며, ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE 은 각각 대장균 개체의 ID, 부모 개체의 ID, 개체의 크기, 분화되어 나온 날짜, 개체의 형질을 나타냅니다.

Column name	Type	Nullable
ID	INTEGER	FALSE
PARENT_ID	INTEGER	TRUE
SIZE_OF_COLONY	INTEGER	FALSE
DIFFERENTIATION_DATE	DATE	FALSE
GENOTYPE	INTEGER	FALSE
최초의 대장균 개체의 PARENT_ID 는 NULL 값입니다.

문제
대장균 개체의 크기가 100 이하라면 'LOW', 100 초과 1000 이하라면 'MEDIUM', 1000 초과라면 'HIGH' 라고 분류합니다. 대장균 개체의 ID(ID) 와 분류(SIZE)를 출력하는 SQL 문을 작성해주세요.이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요.

예시
예를 들어 ECOLI_DATA 테이블이 다음과 같다면

ID	PARENT_ID	SIZE_OF_COLONY	DIFFERENTIATION_DATE	GENOTYPE
1	NULL	17	2019/01/01	5
2	NULL	150	2019/01/01	3
3	1	4000	2020/01/01	4
대장균 개체 ID(ID) 1,2,3 에 대해 개체의 크기는 각각 17, 150, 4000 이므로 분류된 이름은 각각 'LOW', 'MEDIUM', 'HIGH' 입니다. 따라서 결과를 개체의 ID 에 대해 오름차순 정렬하면 다음과 같아야 합니다.

ID	SIZE
1	LOW
2	MEDIUM
3	HIGH

정답
-- 코드를 작성해주세요
-- 대장균 개체 크기 100 이하면 'LOW'
-- 100초과 1000이하면 'MEDIUM'
-- 1000초과면 'HIGH'
-- 개체ID 오름차순 정렬
SELECT 
    ID,
    CASE
    WHEN SIZE_OF_COLONY <= 100 THEN 'LOW'
    WHEN SIZE_OF_COLONY BETWEEN 100 AND 1000 THEN 'MEDIUM'
    ELSE 'HIGH'
    END AS SIZE
FROM ECOLI_DATA
ORDER BY ID ASC

Q12. 문제 설명
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
천재지변으로 인해 일부 데이터가 유실되었습니다. 입양을 간 기록은 있는데, 보호소에 들어온 기록이 없는 동물의 ID와 이름을 ID 순으로 조회하는 SQL문을 작성해주세요.

예시
예를 들어, ANIMAL_INS 테이블과 ANIMAL_OUTS 테이블이 다음과 같다면

ANIMAL_INS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	INTAKE_CONDITION	NAME	SEX_UPON_INTAKE
A352713	Cat	2017-04-13 16:29:00	Normal	Gia	Spayed Female
A350375	Cat	2017-03-06 15:01:00	Normal	Meo	Neutered Male
ANIMAL_OUTS

ANIMAL_ID	ANIMAL_TYPE	DATETIME	NAME	SEX_UPON_OUTCOME
A349733	Dog	2017-09-27 19:09:00	Allie	Spayed Female
A352713	Cat	2017-04-25 12:25:00	Gia	Spayed Female
A349990	Cat	2018-02-02 14:18:00	Spice	Spayed Female
ANIMAL_OUTS 테이블에서

Allie의 ID는 ANIMAL_INS에 없으므로, Allie의 데이터는 유실되었습니다.
Gia의 ID는 ANIMAL_INS에 있으므로, Gia의 데이터는 유실되지 않았습니다.
Spice의 ID는 ANIMAL_INS에 없으므로, Spice의 데이터는 유실되었습니다.
따라서 SQL문을 실행하면 다음과 같이 나와야 합니다.

ANIMAL_ID	NAME
A349733	Allie
A349990	Spice

정답
-- 코드를 입력하세요
-- 입양 간 기록 O, 보호소 들어온 기록 X
-- 동물 ID와 이름 , ID순으로 조회
SELECT
    O.ANIMAL_ID,
    O.NAME
FROM ANIMAL_INS I
RIGHT JOIN ANIMAL_OUTS O ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE I.DATETIME IS NULL
ORDER BY O.ANIMAL_ID

Q13. 문제 설명
다음은 어느 자동차 대여 회사의 자동차 대여 기록 정보를 담은 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블입니다. CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블은 아래와 같은 구조로 되어있으며, HISTORY_ID, CAR_ID, START_DATE, END_DATE 는 각각 자동차 대여 기록 ID, 자동차 ID, 대여 시작일, 대여 종료일을 나타냅니다.

Column name	Type	Nullable
HISTORY_ID	INTEGER	FALSE
CAR_ID	INTEGER	FALSE
START_DATE	DATE	FALSE
END_DATE	DATE	FALSE
문제
CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 2022년 10월 16일에 대여 중인 자동차인 경우 '대여중' 이라고 표시하고, 대여 중이지 않은 자동차인 경우 '대여 가능'을 표시하는 컬럼(컬럼명: AVAILABILITY)을 추가하여 자동차 ID와 AVAILABILITY 리스트를 출력하는 SQL문을 작성해주세요. 이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시해주시고 결과는 자동차 ID를 기준으로 내림차순 정렬해주세요.

예시
예를 들어 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블이 다음과 같다면

HISTORY_ID	CAR_ID	START_DATE	END_DATE
1	4	2022-09-27	2022-09-27
2	3	2022-10-03	2022-10-04
3	2	2022-10-05	2022-10-05
4	1	2022-10-11	2022-10-16
5	3	2022-10-13	2022-10-15
6	2	2022-10-15	2022-10-17
2022년 10월 16일에 대여 중인 자동차는 자동차 ID가 1, 2인 자동차이고, 대여 가능한 자동차는 자동차 ID가 3, 4이므로, '대여중' 또는 '대여 가능' 을 표시하는 컬럼을 추가하고, 자동차 ID를 기준으로 내림차순 정렬하면 다음과 같이 나와야 합니다.

CAR_ID	AVAILABILITY
4	대여 가능
3	대여 가능
2	대여중
1	대여중

정답
-- 코드를 입력하세요
-- 2022년 10월 16일 대여 중인 자동차 '대여중' 표시
-- 대여 중이지 않은 자동차 '대여 가능' 표시
-- -> AVAILABILITY 컬럼에 추가
-- 이때 반납 날짜가 2022년 10월 16일인 경우에도 '대여중'으로 표시
-- 자동차 ID와 AVAILABILITY 출력
-- 자동차 ID 기준 내림차순 정렬
SELECT 
    CAR_ID,
    MAX(CASE
    WHEN '2022-10-16' BETWEEN START_DATE AND END_DATE THEN '대여중'
    ELSE '대여 가능'
    END) AS AVAILABILITY
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC

Q14. 문제 설명
다음은 중고거래 게시판 정보를 담은 USED_GOODS_BOARD 테이블과 중고거래 게시판 첨부파일 정보를 담은 USED_GOODS_FILE 테이블입니다. USED_GOODS_BOARD 테이블은 다음과 같으며 BOARD_ID, WRITER_ID, TITLE, CONTENTS, PRICE, CREATED_DATE, STATUS, VIEWS은 게시글 ID, 작성자 ID, 게시글 제목, 게시글 내용, 가격, 작성일, 거래상태, 조회수를 의미합니다.

Column name	Type	Nullable
BOARD_ID	VARCHAR(5)	FALSE
WRITER_ID	VARCHAR(50)	FALSE
TITLE	VARCHAR(100)	FALSE
CONTENTS	VARCHAR(1000)	FALSE
PRICE	NUMBER	FALSE
CREATED_DATE	DATE	FALSE
STATUS	VARCHAR(10)	FALSE
VIEWS	NUMBER	FALSE
USED_GOODS_FILE 테이블은 다음과 같으며 FILE_ID, FILE_EXT, FILE_NAME, BOARD_ID는 각각 파일 ID, 파일 확장자, 파일 이름, 게시글 ID를 의미합니다.

Column name	Type	Nullable
FILE_ID	VARCHAR(10)	FALSE
FILE_EXT	VARCHAR(5)	FALSE
FILE_NAME	VARCHAR(256)	FALSE
BOARD_ID	VARCHAR(10)	FALSE
문제
USED_GOODS_BOARD와 USED_GOODS_FILE 테이블에서 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로를 조회하는 SQL문을 작성해주세요. 첨부파일 경로는 FILE ID를 기준으로 내림차순 정렬해주세요. 기본적인 파일경로는 /home/grep/src/ 이며, 게시글 ID를 기준으로 디렉토리가 구분되고, 파일이름은 파일 ID, 파일 이름, 파일 확장자로 구성되도록 출력해주세요. 조회수가 가장 높은 게시물은 하나만 존재합니다.

예시
USED_GOODS_BOARD 테이블이 다음과 같고

BOARD_ID	WRITER_ID	TITLE	CONTENTS	PRICE	CREATED_DATE	STATUS	VIEWS
B0001	kwag98	반려견 배변패드 팝니다	정말 저렴히 판매합니다. 전부 미개봉 새상품입니다.	12000	2022-10-01	DONE	250
B0002	lee871201	국내산 볶음참깨	직접 농사지은 참깨입니다.	3000	2022-10-02	DONE	121
B0003	goung12	배드민턴 라켓	사놓고 방치만 해서 팝니다.	9000	2022-10-02	SALE	212
B0004	keel1990	디올 귀걸이	신세계강남점에서 구입. 정품 아닐시 백퍼센트 환불	130000	2022-10-02	SALE	199
B0005	haphli01	스팸클래식 팔아요	유통기한 2025년까지에요	10000	2022-10-02	SALE	121
USED_GOODS_FILE 테이블이 다음과 같을 때

FILE_ID	FILE_EXT	FILE_NAME	BOARD_ID
IMG_000001	.jpg	photo1	B0001
IMG_000002	.jpg	photo2	B0001
IMG_000003	.png	사진	B0002
IMG_000004	.jpg	사진	B0003
IMG_000005	.jpg	photo	B0004
SQL을 실행하면 다음과 같이 출력되어야 합니다.

FILE_PATH
/home/grep/src/B0001/IMG_000001photo1.jpg
/home/grep/src/B0001/IMG_000002photo2.jpg

정답
-- 코드를 입력하세요
-- 조회수가 가장 높은 중고거래 게시물에 대한 첨부파일 경로 조회
-- 첨부파일 경로는 FILE ID를 기준으로 내림차순 정렬
-- 기본적인 파일경로는 /home/grep/src/ 
-- 게시글 ID를 기준으로 디렉토리가 구분
SELECT
    CONCAT("/home/grep/src/", BOARD_ID, '/', FILE_ID, FILE_NAME, FILE_EXT) AS FILE_PATH
FROM (
    SELECT 
        B.BOARD_ID,
        F.FILE_ID,
        F.FILE_NAME,
        F.FILE_EXT
    FROM USED_GOODS_BOARD B
    JOIN USED_GOODS_FILE F ON B.BOARD_ID = F.BOARD_ID
    WHERE B.VIEWS = (SELECT MAX(VIEWS) FROM USED_GOODS_BOARD)
) AS BOARD_TABLE
ORDER BY FILE_ID DESC

Q15. 문제 설명
PLACES 테이블은 공간 임대 서비스에 등록된 공간의 정보를 담은 테이블입니다. PLACES 테이블의 구조는 다음과 같으며 ID, NAME, HOST_ID는 각각 공간의 아이디, 이름, 공간을 소유한 유저의 아이디를 나타냅니다. ID는 기본키입니다.

NAME	TYPE
ID	INT
NAME	VARCHAR
HOST_ID	INT
문제
이 서비스에서는 공간을 둘 이상 등록한 사람을 "헤비 유저"라고 부릅니다. 헤비 유저가 등록한 공간의 정보를 아이디 순으로 조회하는 SQL문을 작성해주세요.

예시
예를 들어, PLACES 테이블이 다음과 같다면

ID	NAME	HOST_ID
4431977	BOUTIQUE STAYS - Somerset Terrace, Pet Friendly	760849
5194998	BOUTIQUE STAYS - Elwood Beaches 3, Pet Friendly	760849
16045624	Urban Jungle in the Heart of Melbourne	30900122
17810814	Stylish Bayside Retreat with a Luscious Garden	760849
22740286	FREE PARKING - The Velvet Lux in Melbourne CBD	30900122
22868779	★ Fresh Fitzroy Pad with City Views! ★	21058208
760849번 유저는 공간을 3개 등록했으므로 이 유저는 헤비유저입니다.
30900122번 유저는 공간을 2개 등록했으므로 이 유저는 헤비유저입니다.
21058208번 유저는 공간을 1개 등록했으므로 이 유저는 헤비유저가 아닙니다.
따라서 SQL 문을 실행하면 다음과 같이 나와야 합니다.

ID	NAME	HOST_ID
4431977	BOUTIQUE STAYS - Somerset Terrace, Pet Friendly	760849
5194998	BOUTIQUE STAYS - Elwood Beaches 3, Pet Friendly	760849
16045624	Urban Jungle in the Heart of Melbourne	30900122
17810814	Stylish Bayside Retreat with a Luscious Garden	760849
22740286	FREE PARKING - The Velvet Lux in Melbourne CBD	30900122

정답
-- 코드를 입력하세요
-- 공간을 둘 이상 등록했으면 "헤비 유저"
-- 헤비 유저가 등록한 공간의 정보 아이디 순 조회
WITH HEAVY_USER AS(
    SELECT
        *,
        COUNT(*) AS cnt
    FROM PLACES
    GROUP BY HOST_ID
    HAVING COUNT(HOST_ID) >= 2
)
SELECT
    P.ID,
    P.NAME,
    P.HOST_ID
FROM PLACES P
JOIN HEAVY_USER H ON P.HOST_ID = H.HOST_ID
ORDER BY P.ID

Q16. 문제 설명
낚시앱에서 사용하는 FISH_INFO 테이블은 잡은 물고기들의 정보를 담고 있습니다. FISH_INFO 테이블의 구조는 다음과 같으며 ID, FISH_TYPE, LENGTH, TIME은 각각 잡은 물고기의 ID, 물고기의 종류(숫자), 잡은 물고기의 길이(cm), 물고기를 잡은 날짜를 나타냅니다.

Column name	Type	Nullable
ID	INTEGER	FALSE
FISH_TYPE	INTEGER	FALSE
LENGTH	FLOAT	TRUE
TIME	DATE	FALSE
단, 잡은 물고기의 길이가 10cm 이하일 경우에는 LENGTH 가 NULL 이며, LENGTH 에 NULL 만 있는 경우는 없습니다.

문제
FISH_INFO에서 평균 길이가 33cm 이상인 물고기들을 종류별로 분류하여 잡은 수, 최대 길이, 물고기의 종류를 출력하는 SQL문을 작성해주세요. 결과는 물고기 종류에 대해 오름차순으로 정렬해주시고, 10cm이하의 물고기들은 10cm로 취급하여 평균 길이를 구해주세요.

컬럼명은 물고기의 종류 'FISH_TYPE', 잡은 수 'FISH_COUNT', 최대 길이 'MAX_LENGTH'로 해주세요.

예시
예를 들어 FISH_INFO 테이블이 다음과 같다면

ID	FISH_TYPE	LENGTH	TIME
0	0	30	2021/12/04
1	0	50	2020/03/07
2	0	40	2020/03/07
3	1	30	2022/03/09
4	1	NULL	2022/04/08
5	2	32	2020/04/28
물고기 종류가 0인 물고기들의 평균 길이는 (30 + 50 + 40) / 3 = 40cm 이고 물고기 종류가 1인 물고기들의 평균 길이는 (30 + 10) / 2 = 20cm 이며, 물고기 종류(가 2인 물고기들의 평균 길이는 (32) / 1 = 32cm 입니다. 따라서 평균길이가 33cm 인 물고기 종류는 0 이므로, 총 잡은 수는 3마리, 최대 길이는 50cm 이므로 결과는 다음과 같아야 합니다.

FISH_COUNT	MAX_LENGTH	FISH_TYPE
3	50	0

정답
-- 코드를 작성해주세요
-- 평균 길이가 33cm이상인 물고기 종류별 분류
-- 잡은 수, 최대 길이, 물고기 종류 출력
-- 물고기 종류 오름차순, 10cm이하 -> 10cm로 취급하여 평균 길이 구하기.
WITH FISH AS(
    SELECT 
        ID, 
        FISH_TYPE,
        CASE
            WHEN LENGTH IS NULL AND LENGTH <= 10 THEN 10
            ELSE LENGTH
        END AS LENGTH
    FROM FISH_INFO),
AVG_FISH AS(
    SELECT
        COUNT(*) AS FISH_COUNT,
        FISH_TYPE,
        AVG(LENGTH) AS AVG_LENGTH,
        MAX(LENGTH) AS MAX_LENGTH
    FROM FISH_INFO
    GROUP BY FISH_TYPE
)
SELECT
    AF.FISH_COUNT,
    AF.MAX_LENGTH,
    AF.FISH_TYPE
FROM FISH F
JOIN AVG_FISH AF ON F.FISH_TYPE = AF.FISH_TYPE
WHERE AF.AVG_LENGTH >= 33
GROUP BY AF.FISH_TYPE
ORDER BY FISH_TYPE
