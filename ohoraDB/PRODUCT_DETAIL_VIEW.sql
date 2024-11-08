
------------------------------------메인화면 이 달의 신상품
CREATE OR REPLACE VIEW thismonth_new
AS
    SELECT PDT_REVIEW_COUNT 리뷰수
        , PDT_NAME 상품명
        , PDT_DISCOUNT_RATE 할인률
        , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE/100), 2) 할인가격
        , PDT_AMOUNT 상품정가
    FROM o_product
    WHERE EXTRACT(MONTH FROM PDT_ADDDATE) = EXTRACT(MONTH FROM SYSDATE);

SELECT * FROM thismonth_new;

------------------------------------메인화면 주간 베스트
-- BEST에서 맨 앞에 10개만 출력하고 있음
-- BEST 조회하는 프로시저에서 출력 범위만 12에서 10으로 수정.









--------------------------상세페이지 출력
CREATE OR REPLACE PROCEDURE product_detail_page
(
    pPDT_ID IN O_PRODUCT.PDT_ID%TYPE
)
IS
    vPDT_NAME O_PRODUCT.PDT_NAME%TYPE;
    vPDT_AMOUNT O_PRODUCT.PDT_AMOUNT%TYPE;
    vPDT_DISCOUNT_RATE O_PRODUCT.PDT_DISCOUNT_RATE%TYPE;
    vDiscounted_Amount NUMBER;
BEGIN
    -- 제품 정보를 가져오는 SELECT 문
    SELECT PDT_NAME, PDT_AMOUNT, PDT_DISCOUNT_RATE 
    INTO vPDT_NAME, vPDT_AMOUNT, vPDT_DISCOUNT_RATE
    FROM O_PRODUCT
    WHERE PDT_ID = pPDT_ID;

    -- NULL 처리 및 할인 가격 계산
    vPDT_AMOUNT := NVL(vPDT_AMOUNT, 0);
    vPDT_DISCOUNT_RATE := NVL(vPDT_DISCOUNT_RATE, 0);
    vDiscounted_Amount := ROUND(vPDT_AMOUNT * (1 - vPDT_DISCOUNT_RATE/100), 2);

    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('상품명: ' || vPDT_NAME);
    DBMS_OUTPUT.PUT_LINE('원가: ' || vPDT_AMOUNT);
    DBMS_OUTPUT.PUT_LINE('할인율: ' || vPDT_DISCOUNT_RATE || '%');
    DBMS_OUTPUT.PUT_LINE('할인가: ' || vDiscounted_Amount);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('상품번호 ' || pPDT_ID || '에 해당하는 상품을 찾을 수 없습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예상치 못한 오류가 발생했습니다: ' || SQLERRM);
END;



EXECUTE product_detail_page(3);

SELECT * FROM o_product;


-----------------------상품 상세페이지 실행 시 자동으로 조회수까지 추가되는...
CREATE OR REPLACE PROCEDURE product_detail_page
(
    pPDT_ID IN O_PRODUCT.PDT_ID%TYPE
)
IS
    vPDT_NAME O_PRODUCT.PDT_NAME%TYPE;
    vPDT_AMOUNT O_PRODUCT.PDT_AMOUNT%TYPE;
    vPDT_DISCOUNT_RATE O_PRODUCT.PDT_DISCOUNT_RATE%TYPE;
    vDiscounted_Amount NUMBER;
BEGIN
    -- 제품 정보를 가져오는 SELECT 문
    SELECT PDT_NAME, PDT_AMOUNT, PDT_DISCOUNT_RATE 
    INTO vPDT_NAME, vPDT_AMOUNT, vPDT_DISCOUNT_RATE
    FROM O_PRODUCT
    WHERE PDT_ID = pPDT_ID;
    -- NULL 처리 및 할인 가격 계산
    vPDT_AMOUNT := NVL(vPDT_AMOUNT, 0);
    vPDT_DISCOUNT_RATE := NVL(vPDT_DISCOUNT_RATE, 0);
    vDiscounted_Amount := ROUND(vPDT_AMOUNT * (1 - vPDT_DISCOUNT_RATE/100), 2);
    -- 조회수 1 증가
    UPDATE O_PRODUCT
    SET PDT_VIEWCOUNT = NVL(PDT_VIEWCOUNT, 0) + 1
    WHERE PDT_ID = pPDT_ID;
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(vPDT_NAME);
    DBMS_OUTPUT.PUT_LINE(vPDT_AMOUNT || ' ' || vDiscounted_Amount || ' ' || vPDT_DISCOUNT_RATE || '%');
    DBMS_OUTPUT.PUT_LINE('');
    detail_page_extraproduct(pPDT_ID);
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('상품번호 ' || pPDT_ID || '에 해당하는 상품을 찾을 수 없습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예상치 못한 오류가 발생했습니다: ' || SQLERRM);
END;

EXECUTE product_detail_page(3);
SELECT * FROM o_product;



SELECT * FROM o_category;
--------------------------------------추가구성상품 출력 PROCEDURE
CREATE OR REPLACE PROCEDURE detail_page_extraproduct
(
    pPDT_ID IN O_PRODUCT.PDT_ID%TYPE
)
IS
    vCAT_ID O_CATEGORY.CAT_ID%TYPE;
    vSCAT_ID O_SUBCATEGORY.SCAT_ID%TYPE;
    vUSER_EXISTS NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('추가구성상품');
    
    -- 제품의 카테고리와 서브카테고리 ID 가져오기
    SELECT CAT_ID, SCAT_ID
    INTO vCAT_ID, vSCAT_ID
    FROM O_PRODUCT
    WHERE PDT_ID = pPDT_ID;
    
    -- O_ORDER 테이블에 존재하는 USER_ID를 체크
    SELECT CASE WHEN EXISTS (
        SELECT 1 FROM O_ORDER o
        WHERE EXISTS (SELECT 1 FROM O_USER u WHERE u.USER_ID = o.USER_ID)
    ) THEN 1 ELSE 0 END
    INTO vUSER_EXISTS
    FROM DUAL;
    
    -- 조건문을 사용하여 다른 프로시저 호출
    IF vCAT_ID = 1 AND vSCAT_ID = 1 THEN 
        get_productinfo(169);
        get_productinfo(170);
        get_productinfo(172);
    ELSIF vCAT_ID = 1 AND vSCAT_ID = 2 THEN
        IF vUSER_EXISTS = 1 THEN
            get_productinfo(165);
            get_productinfo(169);
            get_productinfo(170);
            get_productinfo(174);
        ELSE
            get_productinfo(169);
            get_productinfo(170);
            get_productinfo(174);
        END IF;
    ELSIF vCAT_ID = 2 AND vSCAT_ID = 1 THEN
        get_productinfo(169);
        get_productinfo(170);
    ELSIF vCAT_ID = 1 AND pPDT_ID NOT IN (179, 180, 181, 182) THEN
        get_productinfo(169);
        get_productinfo(170);
    ELSE 
        DBMS_OUTPUT.PUT_LINE('추가구성상품 없음');
    END IF;
END;


EXECUTE detail_page_extraproduct(107);

------------------------------------추가구성상품 정보 가져오기 PROCEDURE
CREATE OR REPLACE PROCEDURE get_productinfo
(
    pPDT_ID IN O_PRODUCT.PDT_ID%TYPE
)
IS
    vPDT_NAME O_PRODUCT.PDT_NAME%TYPE;
    vPDT_AMOUNT O_PRODUCT.PDT_AMOUNT%TYPE;
    vPDT_DISCOUNT_RATE O_PRODUCT.PDT_DISCOUNT_RATE%TYPE;
    vDiscounted_Amount NUMBER;
BEGIN
    -- 제품 정보를 가져오는 SELECT 문
    SELECT PDT_NAME, PDT_AMOUNT, PDT_DISCOUNT_RATE 
    INTO vPDT_NAME, vPDT_AMOUNT, vPDT_DISCOUNT_RATE
    FROM O_PRODUCT
    WHERE PDT_ID = pPDT_ID;

    -- NULL 처리 및 할인 가격 계산
    vPDT_AMOUNT := NVL(vPDT_AMOUNT, 0);
    vPDT_DISCOUNT_RATE := NVL(vPDT_DISCOUNT_RATE, 0);
    vDiscounted_Amount := ROUND(vPDT_AMOUNT * (1 - vPDT_DISCOUNT_RATE/100), 2);

    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('상품명: ' || vPDT_NAME);
    DBMS_OUTPUT.PUT_LINE('원가: ' || vPDT_AMOUNT);
    DBMS_OUTPUT.PUT_LINE('할인가: ' || vDiscounted_Amount);
    
--EXCEPTION
END;

EXECUTE get_productinfo(170);



----------------------------------------------------상품 목록 출력
--정렬 방식 - 신상품, 인기상품, 조회수
--신상품
SELECT PDT_ADDDATE 상품추가일
    , PDT_REVIEW_COUNT 리뷰수
    , PDT_NAME 상품명
    , PDT_DISCOUNT_RATE 할인률
    , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE/100), 2) 할인가격
    , PDT_AMOUNT 상품정가
FROM O_PRODUCT
ORDER BY PDT_ADDDATE DESC;

SELECT *
FROM(
SELECT PDT_ADDDATE 상품추가일
    , PDT_REVIEW_COUNT 리뷰수
    , PDT_NAME 상품명
    , PDT_DISCOUNT_RATE 할인률
    , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE/100), 2) 할인가격
    , PDT_AMOUNT 상품정가
    ,  ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
FROM O_PRODUCT
ORDER BY PDT_ADDDATE DESC
)
WHERE rn BETWEEN 1 AND 12;

----------------------------------신상품 정렬을 프로시저로    (신상품 정렬이 디폴트)
------1 넣으면 1페이지, 2 넣으면 2페이지
CREATE OR REPLACE PROCEDURE pr_pdtpage_recentday(
    p_page_number IN NUMBER  -- 페이지 번호 (예: 1, 2, 3, ...)
)
IS
    v_page_size CONSTANT NUMBER := 12;  -- 페이지 크기를 12로 고정

    CURSOR c_pdt_page IS
    WITH RankedProducts AS (
        SELECT PDT_ADDDATE AS 상품추가일
            , PDT_REVIEW_COUNT AS 리뷰수
            , PDT_NAME AS 상품명
            , PDT_DISCOUNT_RATE AS 할인률
            , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE / 100), 2) AS 할인가격
            , PDT_AMOUNT AS 상품정가
            , ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
        FROM O_PRODUCT
        ORDER BY PDT_ADDDATE DESC
    )
    SELECT *
    FROM RankedProducts
    WHERE rn BETWEEN ((p_page_number - 1) * v_page_size + 1) AND (p_page_number * v_page_size);

    -- 레코드 타입을 정의하여 커서에서 반환되는 데이터와 일치시킵니다.
    v_record c_pdt_page%ROWTYPE;
BEGIN
    OPEN c_pdt_page;

    LOOP
        FETCH c_pdt_page INTO v_record;
        EXIT WHEN c_pdt_page%NOTFOUND;

        -- 데이터 출력
        DBMS_OUTPUT.PUT_LINE(v_record.리뷰수 || '  ' ||
                             v_record.상품명 || '  ' ||
                             v_record.할인가격 || '  ' ||
                             v_record.상품정가 || '  ' ||
                             v_record.할인률
                             );
    END LOOP;

    CLOSE c_pdt_page;
END;

EXECUTE pr_pdtpage_recentday(1);






--인기상품
SELECT PDT_SALES_COUNT 판매수
    , PDT_REVIEW_COUNT 리뷰수
    , PDT_NAME 상품명
    , PDT_DISCOUNT_RATE 할인률
    , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE/100), 2) 할인가격
    , PDT_AMOUNT 상품정가
FROM O_PRODUCT
ORDER BY PDT_SALES_COUNT DESC;

SELECT *
FROM (
    SELECT PDT_SALES_COUNT 판매수
    , PDT_REVIEW_COUNT 리뷰수
    , PDT_NAME 상품명
    , PDT_DISCOUNT_RATE 할인률
    , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE/100), 2) 할인가격
    , PDT_AMOUNT 상품정가
    ,  ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
FROM O_PRODUCT
ORDER BY PDT_SALES_COUNT DESC
)
WHERE rn BETWEEN 1 AND 12;

----------------------------------인기상품 정렬을 프로시저로
------1 넣으면 1페이지, 2 넣으면 2페이지
CREATE OR REPLACE PROCEDURE pr_pdtpage_popular
(
     p_page_number IN NUMBER  -- 페이지 번호 (예: 1, 2, 3, ...)
)
IS
     v_page_size CONSTANT NUMBER := 12;  -- 페이지 크기를 12로 고정

     CURSOR c_pdt_page IS
    WITH RankedProducts AS (
        SELECT 
            PDT_ADDDATE AS 상품추가일,
            PDT_REVIEW_COUNT AS 리뷰수,
            PDT_NAME AS 상품명,
            PDT_DISCOUNT_RATE AS 할인률,
            ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE / 100), 2) AS 할인가격,
            PDT_AMOUNT AS 상품정가,
            ROW_NUMBER() OVER (ORDER BY PDT_SALES_COUNT DESC) AS rn
        FROM O_PRODUCT
        ORDER BY PDT_SALES_COUNT DESC
    )
    SELECT *
    FROM RankedProducts
    WHERE rn BETWEEN ((p_page_number - 1) * v_page_size + 1) AND (p_page_number * v_page_size);

    -- 레코드 타입을 정의하여 커서에서 반환되는 데이터와 일치
    v_record c_pdt_page%ROWTYPE;
BEGIN
    OPEN c_pdt_page;

    LOOP
        FETCH c_pdt_page INTO v_record;
        EXIT WHEN c_pdt_page%NOTFOUND;

        -- 데이터 출력
        DBMS_OUTPUT.PUT_LINE(v_record.리뷰수 || '  ' ||
                             v_record.상품명 || '  ' ||
                             v_record.할인가격 || '  ' ||
                             v_record.상품정가 || '  ' ||
                             v_record.할인률
                             );
    END LOOP;

    CLOSE c_pdt_page;
END;

EXECUTE pr_pdtpage_popular(1);



--조회수
SELECT PDT_VIEWCOUNT
    , PDT_REVIEW_COUNT 리뷰수
    , PDT_NAME 상품명
    , PDT_DISCOUNT_RATE 할인률
    , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE/100), 2) 할인가격
    , PDT_AMOUNT 상품정가
FROM O_PRODUCT
ORDER BY PDT_VIEWCOUNT;

SELECT *
FROM (
    SELECT 
        PDT_VIEWCOUNT,
        PDT_REVIEW_COUNT AS 리뷰수,
        PDT_NAME AS 상품명,
        PDT_DISCOUNT_RATE AS 할인률,
        ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE / 100), 2) AS 할인가격,
        PDT_AMOUNT AS 상품정가,
        ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
    FROM O_PRODUCT
)
WHERE rn BETWEEN 1 AND 12;

----------------------------------조회수 정렬을 프로시저로
------1 넣으면 1페이지, 2 넣으면 2페이지
CREATE OR REPLACE PROCEDURE pr_pdtpage_viewcount
(
     p_page_number IN NUMBER  -- 페이지 번호 (예: 1, 2, 3, ...)
)
IS
     v_page_size CONSTANT NUMBER := 12;  -- 페이지 크기를 12로 고정

     CURSOR c_pdt_page IS
    WITH RankedProducts AS (
        SELECT 
            PDT_ADDDATE AS 상품추가일,
            PDT_REVIEW_COUNT AS 리뷰수,
            PDT_NAME AS 상품명,
            PDT_DISCOUNT_RATE AS 할인률,
            ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE / 100), 2) AS 할인가격,
            PDT_AMOUNT AS 상품정가,
            ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
        FROM O_PRODUCT
        ORDER BY PDT_VIEWCOUNT DESC
    )
    SELECT *
    FROM RankedProducts
    WHERE rn BETWEEN ((p_page_number - 1) * v_page_size + 1) AND (p_page_number * v_page_size);

    -- 레코드 타입을 정의하여 커서에서 반환되는 데이터와 일치
    v_record c_pdt_page%ROWTYPE;
BEGIN
    OPEN c_pdt_page;

    LOOP
        FETCH c_pdt_page INTO v_record;
        EXIT WHEN c_pdt_page%NOTFOUND;

        -- 데이터 출력
        DBMS_OUTPUT.PUT_LINE(v_record.리뷰수 || '  ' ||
                             v_record.상품명 || '  ' ||
                             v_record.할인가격 || '  ' ||
                             v_record.상품정가 || '  ' ||
                             v_record.할인률
                             );
    END LOOP;

    CLOSE c_pdt_page;
END;

EXECUTE pr_pdtpage_viewcount(15);
EXECUTE pr_pdtpage_viewcount(16);


-----------------------------------PRODUCT에서 디자인별,컬러별, 라인업별로 출력

--디자인 데일리 design_id = 1

SELECT p.PDT_REVIEW_COUNT AS 리뷰수
        , p.PDT_NAME AS 상품명
        , p.PDT_DISCOUNT_RATE AS 할인률
        , ROUND(p.PDT_AMOUNT * (1 - p.PDT_DISCOUNT_RATE / 100), 2) AS 할인가격
        , p.PDT_AMOUNT AS 상품정가
        ,  ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
FROM O_PDTDESIGN d JOIN O_PRODUCT p ON d.PDT_ID = p.PDT_ID
WHERE d.DESIGN_ID = 1;

---------------------------------------------디자인별 프로시저
CREATE OR REPLACE PROCEDURE searchby_design
(
    pDESIGN_ID IN O_PDTDESIGN.DESIGN_ID%TYPE  -- 입력 파라미터
)
IS
    -- 커서 선언
    CURSOR c_design IS
        SELECT 
            p.PDT_REVIEW_COUNT AS 리뷰수,
            p.PDT_NAME AS 상품명,
            p.PDT_DISCOUNT_RATE AS 할인률,
            ROUND(p.PDT_AMOUNT * (1 - p.PDT_DISCOUNT_RATE / 100), 2) AS 할인가격,
            p.PDT_AMOUNT AS 상품정가,
            ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
        FROM O_PDTDESIGN d 
        JOIN O_PRODUCT p ON d.PDT_ID = p.PDT_ID
        WHERE d.DESIGN_ID = pDESIGN_ID;
    -- 커서에서 반환될 행 타입 선언
    v_record c_design%ROWTYPE;
    
BEGIN
    -- 커서 열기
    OPEN c_design;
    -- 커서에서 데이터를 한 행씩 가져와 처리
    LOOP
        FETCH c_design INTO v_record;
        EXIT WHEN c_design%NOTFOUND;
        -- 데이터 출력
        DBMS_OUTPUT.PUT_LINE('상품명: ' || v_record.상품명 ||
                             ', 리뷰수: ' || v_record.리뷰수 ||
                             ', 할인률: ' || v_record.할인률 || '%' ||
                             ', 상품정가: ' || v_record.상품정가 || '원' ||
                             ', 할인가격: ' || v_record.할인가격 || '원');
    END LOOP;
    -- 커서 닫기
    CLOSE c_design;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 DESIGN_ID에 대한 데이터가 없습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류 발생: ' || SQLERRM);
END;

EXECUTE searchby_design(1);




-- 컬러 코랄핑크 COLOR_ID = 1
SELECT *
FROM(
SELECT p.PDT_REVIEW_COUNT AS 리뷰수
        , p.PDT_NAME AS 상품명
        , p.PDT_DISCOUNT_RATE AS 할인률
        , ROUND(p.PDT_AMOUNT * (1 - p.PDT_DISCOUNT_RATE / 100), 2) AS 할인가격
        , p.PDT_AMOUNT AS 상품정가
        ,  ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
FROM O_PDTCOLOR c JOIN O_PRODUCT p ON c.PDT_ID = p.PDT_ID
WHERE COLOR_ID = 1
)
WHERE rn BETWEEN 1 AND 12;
-----------------------------------------------색깔별 프로시저
CREATE OR REPLACE PROCEDURE searchby_color
(
    pCOLOR_ID IN O_PDTCOLOR.COLOR_ID%TYPE  -- 입력 파라미터
)
IS
    -- 커서 선언
    CURSOR c_color IS
        SELECT 
            p.PDT_REVIEW_COUNT AS 리뷰수,
            p.PDT_NAME AS 상품명,
            p.PDT_DISCOUNT_RATE AS 할인률,
            ROUND(p.PDT_AMOUNT * (1 - p.PDT_DISCOUNT_RATE / 100), 2) AS 할인가격,
            p.PDT_AMOUNT AS 상품정가,
            ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
        FROM O_PDTCOLOR d 
        JOIN O_PRODUCT p ON d.PDT_ID = p.PDT_ID
        WHERE d.COLOR_ID = pCOLOR_ID;
    
    -- 커서에서 반환될 행 타입 선언
    v_record c_color%ROWTYPE;
BEGIN
    -- 커서 열기
    OPEN c_color;
    
    -- 커서에서 데이터를 한 행씩 가져와 처리
    LOOP
        FETCH c_color INTO v_record;
        EXIT WHEN c_color%NOTFOUND;
        
        -- 데이터 출력
        DBMS_OUTPUT.PUT_LINE('상품명: ' || v_record.상품명 ||
                             ', 리뷰수: ' || v_record.리뷰수 ||
                             ', 할인률: ' || v_record.할인률 || '%' ||
                             ', 상품정가: ' || v_record.상품정가 || '원' ||
                             ', 할인가격: ' || v_record.할인가격 || '원' ||
                             ', 순위: ' || v_record.rn);
    END LOOP;

    -- 커서 닫기
    CLOSE c_color;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 COLOR_ID에 대한 데이터가 없습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류 발생: ' || SQLERRM);
END;

EXECUTE searchby_color(11);


-- 라인업 풀컬러 LINEUP_ID = 2
SELECT *
FROM(
SELECT p.PDT_REVIEW_COUNT AS 리뷰수
        , p.PDT_NAME AS 상품명
        , p.PDT_DISCOUNT_RATE AS 할인률
        , ROUND(p.PDT_AMOUNT * (1 - p.PDT_DISCOUNT_RATE / 100), 2) AS 할인가격
        , p.PDT_AMOUNT AS 상품정가
        ,  ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
FROM O_PDTLINEUP l JOIN O_PRODUCT p ON l.PDT_ID = p.PDT_ID
WHERE LINEUP_ID = 2
)
WHERE rn BETWEEN 1 AND 12;
-------------------------------------------라인업별 프로시저
CREATE OR REPLACE PROCEDURE searchby_lineup
(
    pLINEUP_ID O_PDTLINEUP.LINEUP_ID%TYPE
)
IS
    CURSOR c_lineup IS
    SELECT p.PDT_REVIEW_COUNT AS 리뷰수
        , p.PDT_NAME AS 상품명
        , p.PDT_DISCOUNT_RATE AS 할인률
        , ROUND(p.PDT_AMOUNT * (1 - p.PDT_DISCOUNT_RATE / 100), 2) AS 할인가격
        , p.PDT_AMOUNT AS 상품정가
        ,  ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
    FROM O_PDTLINEUP l JOIN O_PRODUCT p ON l.PDT_ID = p.PDT_ID
    WHERE l.LINEUP_ID = pLINEUP_ID;
    
    v_record c_lineup%ROWTYPE;
BEGIN
    OPEN c_lineup;
        LOOP
        FETCH c_lineup INTO v_record;
        EXIT WHEN c_lineup%NOTFOUND;
    
        DBMS_OUTPUT.PUT_LINE('상품명: ' || v_record.상품명 ||
                             ', 리뷰수: ' || v_record.리뷰수 ||
                             ', 할인률: ' || v_record.할인률 || '%' ||
                             ', 상품정가: ' || v_record.상품정가 || '원' ||
                             ', 할인가격: ' || v_record.할인가격 || '원');
        
        END LOOP;
    
    CLOSE c_lineup;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 LINEUP_ID에 대한 데이터가 없습니다.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('오류 발생: ' || SQLERRM);
END;

EXECUTE searchby_lineup(3);


-----------------------------------------------------아울렛 조회
--네일, 페디 중 할인률 30% 이상인 상품들
SELECT *
FROM(
SELECT PDT_REVIEW_COUNT AS 리뷰수
        , PDT_NAME AS 상품명
        , PDT_DISCOUNT_RATE AS 할인률
        , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE / 100), 2) AS 할인가격
        , PDT_AMOUNT AS 상품정가
        ,  ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
FROM o_product
WHERE cat_id IN (1,2) AND PDT_DISCOUNT_RATE >= 30
)
--WHERE rn BETWEEN 25 AND 36;
--WHERE rn BETWEEN 13 AND 24;
WHERE rn BETWEEN 1 AND 12;


---------------------------------------아울렛 조회 프로시저
CREATE OR REPLACE PROCEDURE pr_disp_outlet
(
     p_page_number IN NUMBER  -- 페이지 번호 (예: 1, 2, 3, ...)
)
IS
     v_page_size CONSTANT NUMBER := 12;  -- 페이지 크기를 12로 고정

     CURSOR c_pdt_page IS
    WITH RankedProducts AS (
        SELECT PDT_REVIEW_COUNT AS 리뷰수
        , PDT_NAME AS 상품명
        , PDT_DISCOUNT_RATE AS 할인률
        , ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE / 100), 2) AS 할인가격
        , PDT_AMOUNT AS 상품정가
        ,  ROW_NUMBER() OVER (ORDER BY PDT_VIEWCOUNT DESC) AS rn
        FROM o_product
        WHERE cat_id IN (1,2) AND PDT_DISCOUNT_RATE >= 30
    )
    SELECT *
    FROM RankedProducts
    WHERE rn BETWEEN ((p_page_number - 1) * v_page_size + 1) AND (p_page_number * v_page_size);

    -- 레코드 타입을 정의하여 커서에서 반환되는 데이터와 일치
    v_record c_pdt_page%ROWTYPE;
BEGIN
    OPEN c_pdt_page;

    LOOP
        FETCH c_pdt_page INTO v_record;
        EXIT WHEN c_pdt_page%NOTFOUND;

        -- 데이터 출력
        DBMS_OUTPUT.PUT_LINE(v_record.리뷰수 || '  ' ||
                             v_record.상품명 || '  ' ||
                             v_record.할인가격 || '  ' ||
                             v_record.상품정가 || '  ' ||
                             v_record.할인률 || '%');
    END LOOP;

    CLOSE c_pdt_page;
END;

EXECUTE pr_disp_outlet(1);

----------------------------BEST 조회
WITH RankedProducts AS (
    SELECT 
        PDT_SALES_COUNT AS 판매수,
        PDT_REVIEW_COUNT AS 리뷰수,
        PDT_NAME AS 상품명,
        PDT_DISCOUNT_RATE AS 할인률,
        ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE / 100), 2) AS 할인가격,
        PDT_AMOUNT AS 상품정가,
        ROW_NUMBER() OVER (ORDER BY PDT_SALES_COUNT DESC) AS rn,
        COUNT(*) OVER () AS total_count  -- 전체 상품 수를 계산
    FROM O_PRODUCT
)
SELECT *
FROM (
        SELECT 판매수, 리뷰수, 상품명, 할인률, 할인가격, 상품정가,
            rn,
            total_count,
            PERCENT_RANK() OVER (ORDER BY 판매수 DESC) AS rank_pct
        FROM RankedProducts
)
WHERE rank_pct <= 0.30  -- 상위 30% 범위
AND rn BETWEEN 1 AND 12; -- 페이지 범위

-----------------------------------------BEST 조회 프로시저
CREATE OR REPLACE PROCEDURE pr_disp_best
(
    p_page_number IN NUMBER  -- 페이지 번호 (예: 1, 2, 3, ...)
)
IS
    v_page_size CONSTANT NUMBER := 12;  -- 페이지 크기를 12로 고정

    CURSOR c_pdt_page IS
    WITH RankedProducts AS (
        SELECT 
            PDT_SALES_COUNT AS 판매수,
            PDT_REVIEW_COUNT AS 리뷰수,
            PDT_NAME AS 상품명,
            PDT_DISCOUNT_RATE AS 할인률,
            ROUND(PDT_AMOUNT * (1 - PDT_DISCOUNT_RATE / 100), 2) AS 할인가격,
            PDT_AMOUNT AS 상품정가,
            ROW_NUMBER() OVER (ORDER BY PDT_SALES_COUNT DESC) AS rn,
            PERCENT_RANK() OVER (ORDER BY PDT_SALES_COUNT DESC) AS rank_pct
        FROM O_PRODUCT
    )
    SELECT *
    FROM RankedProducts
    WHERE rank_pct <= 0.30  -- 상위 30% 범위
    AND rn BETWEEN ((p_page_number - 1) * v_page_size + 1) AND (p_page_number * v_page_size);  -- 페이지 범위

    -- 레코드 타입을 정의하여 커서에서 반환되는 데이터와 일치
    v_record c_pdt_page%ROWTYPE;
BEGIN
    OPEN c_pdt_page;

    LOOP
        FETCH c_pdt_page INTO v_record;
        EXIT WHEN c_pdt_page%NOTFOUND;

        -- 데이터 출력
        DBMS_OUTPUT.PUT_LINE(v_record.리뷰수 || '  ' ||
                             v_record.상품명 || '  ' ||
                             v_record.할인가격 || '  ' ||
                             v_record.상품정가 || '  ' ||
                             v_record.할인률);
    END LOOP;

    CLOSE c_pdt_page;
END;

EXECUTE pr_disp_best(2);






----------------------------------------NOTICE 목록 뷰
CREATE OR REPLACE VIEW notice_view
AS
    SELECT notice_title 제목
    FROM o_notice;

SELECT * FROM notice_view;


--------------------------------------NOTICE 내용 뷰
CREATE OR REPLACE VIEW notice_detail_view
AS
    SELECT notice_title 제목
        , NOTICE_WRITER 작성자
        , NOTICE_WRITEDATE 작성일
        , NOTICE_VIEWCOUNT 조회수
        , NOTICE_CONTENT 내용
    FROM O_NOTICE
    WHERE NOTICE_ID = 1;
    
SELECT * FROM notice_detail_view;


CREATE OR REPLACE PROCEDURE pr_notice_detail
(
     pNOTICE_ID IN O_NOTICE.NOTICE_ID%TYPE
)
IS
    vnotice_title     O_NOTICE.notice_title%TYPE;
    vNOTICE_WRITER    O_NOTICE.NOTICE_WRITER%TYPE;
    vNOTICE_WRITEDATE O_NOTICE.NOTICE_WRITEDATE%TYPE;
    vNOTICE_VIEWCOUNT O_NOTICE.NOTICE_VIEWCOUNT%TYPE;
    vNOTICE_CONTENT   O_NOTICE.NOTICE_CONTENT%TYPE;
    
BEGIN
    SELECT notice_title, NOTICE_WRITER, NOTICE_WRITEDATE, NOTICE_VIEWCOUNT, NOTICE_CONTENT
        INTO vnotice_title, vNOTICE_WRITER, vNOTICE_WRITEDATE, vNOTICE_VIEWCOUNT, vNOTICE_CONTENT
    FROM O_NOTICE
    WHERE NOTICE_ID = pNOTICE_ID;
    
    UPDATE O_NOTICE
    SET NOTICE_VIEWCOUNT = NVL(NOTICE_VIEWCOUNT, 0) + 1
    WHERE NOTICE_ID = pNOTICE_ID;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('제목: ' || vnotice_title);
    DBMS_OUTPUT.PUT_LINE('작성자: ' || vNOTICE_WRITER);
    DBMS_OUTPUT.PUT_LINE('작성일: ' || vNOTICE_WRITEDATE || ' ' || '조회수' || vNOTICE_VIEWCOUNT);
    DBMS_OUTPUT.PUT_LINE(vNOTICE_CONTENT);
END;

EXECUTE pr_notice_detail(1);

SELECT * FROM o_notice;

------------------------------------------------------O_ASK 목록 뷰
--원래는 내가 작성한 문의만 보여야 함
CREATE OR REPLACE VIEW ask_view
AS
    SELECT ASK_ID 번호
        , ASK_TITLE 제목
        , ASK_WRITER 작성자
        , ASK_WRITEDATE 작성일
        , ASK_ISANSWER 답변
    FROM o_ask;
    
SELECT * FROM ask_view;

SELECT * FROM o_ask;


------------------------------------O_ASK 목록 프로시저
CREATE OR REPLACE PROCEDURE myask_list
(
    pUSER_ID IN O_ASK.USER_ID%TYPE
)
IS
    CURSOR c_ask IS
        SELECT ASK_ID, ASK_TITLE, ASK_WRITER, ASK_WRITEDATE, ASK_ISANSWER 
        FROM O_ASK
        WHERE USER_ID = pUSER_ID;

    vASK_ID         O_ASK.ASK_ID%TYPE;
    vASK_TITLE      O_ASK.ASK_TITLE%TYPE;
    vASK_WRITER     O_ASK.ASK_WRITER%TYPE;
    vASK_WRITEDATE  O_ASK.ASK_WRITEDATE%TYPE;
    vASK_ISANSWER   O_ASK.ASK_ISANSWER%TYPE;
BEGIN
    -- 커서 열기
    OPEN c_ask;
    LOOP
        FETCH c_ask INTO vASK_ID, vASK_TITLE, vASK_WRITER, vASK_WRITEDATE, vASK_ISANSWER;
        EXIT WHEN c_ask%NOTFOUND;

        -- 출력
        DBMS_OUTPUT.PUT_LINE('번호: ' || vASK_ID || 
                             ', 제목: ' || vASK_TITLE ||
                             ', 작성자: ' || vASK_WRITER ||
                             ', 작성일: ' || vASK_WRITEDATE ||
                             ', 답변: ' || vASK_ISANSWER);
    END LOOP;
    CLOSE c_ask;
END;

EXECUTE myask_list(1002);



