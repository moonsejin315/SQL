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
