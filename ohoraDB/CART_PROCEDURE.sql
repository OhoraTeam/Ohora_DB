-- (위-> 아래 순으로 생성)

-- 저장프로시저는 부여된 번호 부분씩 드래그 해서 생성
-- ctrl + ENTER

-- 프로시저 실행문은 맨밑까지 드래그 해서 
-- ctrl + ENTER

-- 장바구니 시퀀스 생성
CREATE SEQUENCE SEQ_CART
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- 장바구니 목록 시퀀스 생성
CREATE SEQUENCE SEQ_CARTLIST
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


-- 0) 상품정보 얻어오는 프로시저
create or replace PROCEDURE get_productinfo
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



-- 1) 장바구니 (상품 추가) 
CREATE OR REPLACE PROCEDURE UP_CARTLIST_ADD (
    PUSER_ID IN NUMBER,  -- 회원ID   
    PPDT_ID IN NUMBER,   -- 상품ID
    POPT_ID IN NUMBER,   -- 옵션ID
    PQUANTITY IN NUMBER  -- 수량
) AS
    VCART_ID NUMBER;        
    VEXISTING_COUNT NUMBER;
    VOPTION_EXISTS NUMBER;  
    VVALID_OPTION NUMBER;
    VSTOCK_QUANTITY NUMBER;
BEGIN
    BEGIN
        -- 장바구니 ID 가져오기
        SELECT CART_ID
        INTO VCART_ID
        FROM O_CART
        WHERE USER_ID = PUSER_ID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- 장바구니가 존재하지 않을 경우 장바구니 생성
            INSERT INTO O_CART (CART_ID, USER_ID)
            VALUES (SEQ_CART.NEXTVAL, PUSER_ID);
    END;

    BEGIN
        -- 옵션이 존재하는지 확인
        SELECT COUNT(*)
        INTO VOPTION_EXISTS
        FROM O_PDTOPTION
        WHERE PDT_ID = PPDT_ID;

        IF VOPTION_EXISTS > 0 THEN
            -- 옵션이 필요하는 제품인데 옵션이 제공되지 않은 경우
            IF POPT_ID IS NULL THEN
                DBMS_OUTPUT.PUT_LINE('해당 상품은 필수 옵션이 필요합니다. 옵션을 선택해야 합니다.');
                DBMS_OUTPUT.PUT_LINE('');
                DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
                RETURN;
            END IF;

            -- 제공된 옵션 ID가 유효한지 확인
            SELECT COUNT(*)
            INTO VVALID_OPTION
            FROM O_PDTOPTION
            WHERE PDT_ID = PPDT_ID
            AND OPT_ID = POPT_ID;

            IF VVALID_OPTION = 0 THEN
                DBMS_OUTPUT.PUT_LINE('해당 상품에서는 제공하지 않는 옵션입니다. 올바른 옵션을 선택하십시오.');
                DBMS_OUTPUT.PUT_LINE('');
                DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
                RETURN;
            END IF;

        ELSE
            -- 옵션이 필요 없는 제품인데 옵션이 제공된 경우
            IF POPT_ID IS NOT NULL THEN
                DBMS_OUTPUT.PUT_LINE('해당 상품은 옵션이 필요하지 않습니다.');
                DBMS_OUTPUT.PUT_LINE('');
                DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
                RETURN;
            END IF;
        END IF;

        -- 재고 수량 확인
        SELECT NVL(p.PDT_COUNT - NVL(cl.CLIST_PDT_COUNT, 0), p.PDT_COUNT)
        INTO VSTOCK_QUANTITY
        FROM O_PRODUCT p
        LEFT JOIN O_CARTLIST cl ON p.PDT_ID = cl.PDT_ID AND cl.OPT_ID = POPT_ID
        WHERE p.PDT_ID = PPDT_ID;

        -- 기존 장바구니에서 상품 수량 합계 계산
        IF VSTOCK_QUANTITY < PQUANTITY THEN
            DBMS_OUTPUT.PUT_LINE('재고가 부족합니다. 현재 재고 수량: ' || VSTOCK_QUANTITY);
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            RETURN;
        END IF;

        -- 장바구니에 동일 상품과 옵션이 이미 있는지 확인
        SELECT COUNT(*)
        INTO VEXISTING_COUNT
        FROM O_CARTLIST
        WHERE CART_ID = VCART_ID
        AND PDT_ID = PPDT_ID
        AND NVL(OPT_ID, 0) = NVL(POPT_ID, 0);  -- 옵션 ID 비교, NULL 처리

        IF VEXISTING_COUNT > 0 THEN
            -- 동일 상품과 옵션이 있을 경우 수량 증가
            UPDATE O_CARTLIST
            SET CLIST_PDT_COUNT = CLIST_PDT_COUNT + PQUANTITY
            WHERE CART_ID = VCART_ID
            AND PDT_ID = PPDT_ID
            AND NVL(OPT_ID, 0) = NVL(POPT_ID, 0);  -- 옵션 ID 비교, NULL 처리

            DBMS_OUTPUT.PUT_LINE('장바구니에 동일한 상품이 있습니다. 수량이 변경되었습니다.');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
        ELSE
            -- 새로운 상품과 옵션 추가
            INSERT INTO O_CARTLIST (
                CLIST_ID, CART_ID, PDT_ID, OPT_ID, CLIST_PDT_COUNT, CLIST_ADDDATE
            )
            VALUES (
                SEQ_CARTLIST.NEXTVAL, VCART_ID, PPDT_ID, POPT_ID, PQUANTITY, SYSDATE
            );

            DBMS_OUTPUT.PUT_LINE('상품이 장바구니에 추가되었습니다.');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('상품을 장바구니에 추가하는 중 오류가 발생했습니다. 오류 메시지: ' || SQLERRM);
    END;
END;







-- 2) 장바구니 목록 (가격 관리) 
CREATE OR REPLACE PROCEDURE UP_CARTLIST_PRICE (
    PUSER_ID IN NUMBER
) AS
    VCART_ID NUMBER;
    VTOTAL_AMOUNT NUMBER := 0;  -- 총 상품 금액 (할인 전)
    VTOTAL_ITEMS NUMBER := 0;  -- 총 상품 수량
    VDELIVERY_FEE NUMBER := 0;  -- 배송비
    VDISCOUNT_AMOUNT NUMBER := 0;  -- 총 할인 금액
    VFINAL_AMOUNT NUMBER := 0;  -- 총 결제 예정 금액
    VADDITIONAL_AMOUNT NUMBER := 0; -- 추가 구매시 무료배송까지 남은 금액
    VPRODUCT_COUNT NUMBER := 0; -- 상품 수 (옵션 포함)
BEGIN
    BEGIN
        -- 장바구니 ID 가져오기
        SELECT CART_ID
        INTO VCART_ID
        FROM O_CART
        WHERE USER_ID = PUSER_ID;

        BEGIN
            -- 총 상품 금액, 할인 금액, 및 상품 수량 계산 (옵션 포함)
            SELECT 
                NVL(SUM((P.PDT_AMOUNT + NVL(PO.OPT_AMOUNT, 0)) * CL.CLIST_PDT_COUNT), 0) AS TOTAL_AMOUNT,
                NVL(SUM(P.PDT_AMOUNT * CL.CLIST_PDT_COUNT * (P.PDT_DISCOUNT_RATE / 100)), 0) AS DISCOUNT_AMOUNT,
                NVL(COUNT(*), 0) AS PRODUCT_COUNT
            INTO VTOTAL_AMOUNT, VDISCOUNT_AMOUNT, VPRODUCT_COUNT
            FROM O_CARTLIST CL
            JOIN O_PRODUCT P ON CL.PDT_ID = P.PDT_ID
            LEFT JOIN O_PDTOPTION PO ON CL.OPT_ID = PO.OPT_ID
            WHERE CL.CART_ID = VCART_ID
            AND CL.CLIST_SELECT = 'Y';  -- 선택된 상품만 포함

            -- 상품이 없으면 출력하지 않기
            IF VPRODUCT_COUNT = 0 THEN
                DBMS_OUTPUT.PUT_LINE('장바구니에 선택된 상품이 담겨있지 않습니다.');
                DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
                DBMS_OUTPUT.PUT_LINE('');
                RETURN;
            END IF;

            -- 총 결제 금액에서 할인 금액 적용
            VTOTAL_AMOUNT := VTOTAL_AMOUNT - VDISCOUNT_AMOUNT;

            -- 배송비 계산
            IF VTOTAL_AMOUNT >= 50000 THEN
                VDELIVERY_FEE := 0;
            ELSE
                VDELIVERY_FEE := 3000;
                VADDITIONAL_AMOUNT := 50000 - VTOTAL_AMOUNT;
            END IF;

            -- 총 결제 예정 금액 계산
            VFINAL_AMOUNT := VTOTAL_AMOUNT + VDELIVERY_FEE;

            -- 출력 메시지
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('총 상품금액: ' || (VTOTAL_AMOUNT + VDISCOUNT_AMOUNT) || '원');
            DBMS_OUTPUT.PUT_LINE('상품할인금액: -' || VDISCOUNT_AMOUNT || '원');
            DBMS_OUTPUT.PUT_LINE('총 배송비: ' || VDELIVERY_FEE || '원');
            
            IF VADDITIONAL_AMOUNT > 0 THEN
                DBMS_OUTPUT.PUT_LINE(VADDITIONAL_AMOUNT || '원 추가 구매시 무료배송');
            END IF;

            DBMS_OUTPUT.PUT_LINE('총 결제예정금액: ' || VFINAL_AMOUNT || '원');
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('');
             
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('장바구니에 선택된 상품이 담겨있지 않습니다.');
        END;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('장바구니가 존재하지 않습니다.');
    END;
END;








-- 3) 장바구니 (물품 조회) 
CREATE OR REPLACE PROCEDURE UP_CART_CHECK (
    PUSER_ID NUMBER
) IS  
    VCART_COUNT NUMBER; -- 장바구니 존재 여부
    VCLIST_COUNT NUMBER; -- 장바구니에 선택된 상품 개수
BEGIN
    -- 장바구니 존재 여부 확인
    SELECT COUNT(*)
    INTO VCART_COUNT
    FROM O_CART
    WHERE USER_ID = PUSER_ID;
    
    IF VCART_COUNT = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('장바구니가 존재하지 않습니다.');
        RETURN;
    END IF;
    
    -- 장바구니에 담긴 상품 개수 확인 (선택된 상품만)
    SELECT COUNT(*)
    INTO VCLIST_COUNT
    FROM O_CARTLIST
    WHERE CART_ID IN (
        SELECT CART_ID 
        FROM O_CART 
        WHERE USER_ID = PUSER_ID
    )
    AND CLIST_SELECT = 'Y';  -- 선택된 상품만 포함

    IF VCLIST_COUNT = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('선택된 상품이 담겨있지 않습니다.');  
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('전체상품(' || VCLIST_COUNT || ')');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('선택된 상품이 담겨 있습니다.');  
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('전체상품(' || VCLIST_COUNT || ')');
        
        -- 상품명과 수량 출력 (선택된 상품만)
        FOR ACUR IN (
            SELECT 
                P.PDT_NAME, 
                NVL(PO.OPT_NAME, NULL) AS OPT_NAME, 
                CL.CLIST_PDT_COUNT
            FROM O_CARTLIST CL
            JOIN O_PRODUCT P ON CL.PDT_ID = P.PDT_ID
            LEFT JOIN O_PDTOPTION PO ON CL.OPT_ID = PO.OPT_ID
            WHERE CL.CART_ID IN (
                SELECT CART_ID 
                FROM O_CART 
                WHERE USER_ID = PUSER_ID
            )
            AND CL.CLIST_SELECT = 'Y'  -- 선택된 상품만 포함
        ) LOOP
            DBMS_OUTPUT.PUT_LINE(
                '상품명: ' || ACUR.PDT_NAME || 
                CASE
                    WHEN ACUR.OPT_NAME IS NOT NULL THEN
                        ', 옵션: ' || ACUR.OPT_NAME
                    ELSE 
                        ''
                END || ', 수량: ' || ACUR.CLIST_PDT_COUNT
            );
        END LOOP;
    END IF;
END;









-- 4) 장바구니 목록 (수량 변경)
CREATE OR REPLACE PROCEDURE UP_CARTLIST_UPDATE (
    PUSER_ID IN NUMBER,
    PPDT_ID IN NUMBER,
    PUPDATE_MODE IN NUMBER  -- 1이면 증가, -1이면 감소
) AS
    VCART_ID NUMBER;
    VEXISTING_COUNT NUMBER;
    VNEW_QUANTITY NUMBER;
    VSTOCK_QUANTITY NUMBER;
BEGIN
    -- 장바구니 ID 가져오기
    SELECT CART_ID
    INTO VCART_ID
    FROM O_CART
    WHERE USER_ID = PUSER_ID;

    BEGIN
        -- 재고 수량 확인
        SELECT p.PDT_COUNT
        INTO VSTOCK_QUANTITY
        FROM O_PRODUCT p
        WHERE p.PDT_ID = PPDT_ID;

        -- 장바구니에 동일 상품이 이미 있는지 확인
        SELECT CLIST_PDT_COUNT
        INTO VEXISTING_COUNT
        FROM O_CARTLIST
        WHERE CART_ID = VCART_ID
        AND PDT_ID = PPDT_ID;
 
        -- 새로운 수량 계산
        VNEW_QUANTITY := VEXISTING_COUNT + PUPDATE_MODE;

        -- 수량이 1 이하로 내려가지 않도록 제한
        IF VNEW_QUANTITY < 1 THEN
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('수량은 1 이상이어야 합니다.');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            RETURN;
        END IF;

        -- 재고가 충분하지 않은 경우 처리
        IF VNEW_QUANTITY > VSTOCK_QUANTITY THEN
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('재고가 부족합니다. 현재 재고 수량: ' || VSTOCK_QUANTITY);
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            RETURN;
        END IF;

        -- 동일 상품이 있을 경우 수량 업데이트
        UPDATE O_CARTLIST
        SET CLIST_PDT_COUNT = VNEW_QUANTITY 
        WHERE CART_ID = VCART_ID
        AND PDT_ID = PPDT_ID;

        DBMS_OUTPUT.PUT_LINE('수량이 변경되었습니다.');

        -- 장바구니 상태와 가격을 업데이트하는 프로시저 호출
        UP_CART_CHECK(PUSER_ID);
        UP_CARTLIST_PRICE(PUSER_ID);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('장바구니에 해당 상품이 존재하지 않습니다.');
    END;
END;








-- 5) 장바구니 목록 (선택 여부)
CREATE OR REPLACE PROCEDURE UP_CARTLIST_SELECT (
    PUSER_ID IN NUMBER,
    PPDT_ID IN NUMBER,
    PSELECT IN CHAR
) AS
    VCART_ID NUMBER;
    VEXISTING_COUNT NUMBER;
BEGIN
    -- 장바구니 ID 가져오기
    SELECT CART_ID
    INTO VCART_ID
    FROM O_CART
    WHERE USER_ID = PUSER_ID;

    BEGIN
        -- 장바구니에 동일 상품이 이미 있는지 확인
        SELECT COUNT(*)
        INTO VEXISTING_COUNT
        FROM O_CARTLIST
        WHERE CART_ID = VCART_ID
        AND PDT_ID = PPDT_ID;

        IF VEXISTING_COUNT > 0 THEN
            -- 선택 여부 업데이트
            UPDATE O_CARTLIST
            SET CLIST_SELECT = PSELECT
            WHERE CART_ID = VCART_ID
            AND PDT_ID = PPDT_ID;

            DBMS_OUTPUT.PUT_LINE('선택 여부가 변경되었습니다.');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
             
        ELSE
            DBMS_OUTPUT.PUT_LINE('장바구니에 선택된 상품이 존재하지 않습니다.');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
        END IF;

        -- 장바구니 (상품조회)와 가격을 업데이트하는 프로시저 호출
        UP_CART_CHECK(PUSER_ID);
        UP_CARTLIST_PRICE(PUSER_ID);

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('선택 여부를 업데이트하는 중 오류가 발생했습니다. 오류 메시지: ' || SQLERRM);
    END;
END;








-- 6) 장바구니 (상품 제거) 
CREATE OR REPLACE PROCEDURE UP_CART_DELETE (
    PUSER_ID IN NUMBER,
    PPDT_ID IN NUMBER,
    POPT_ID IN NUMBER  -- 옵션 ID 추가
) AS
    VCART_ID NUMBER;
    VEXISTING_COUNT NUMBER;
BEGIN
    BEGIN
        -- 장바구니 ID 가져오기
        SELECT CART_ID
        INTO VCART_ID
        FROM O_CART
        WHERE USER_ID = PUSER_ID;

        -- 장바구니에 해당 상품과 옵션이 있는지 확인
        SELECT COUNT(*)
        INTO VEXISTING_COUNT
        FROM O_CARTLIST
        WHERE CART_ID = VCART_ID
        AND PDT_ID = PPDT_ID
        AND NVL(OPT_ID, 0) = NVL(POPT_ID, 0);  -- 옵션 ID 비교, NULL 처리

        IF VEXISTING_COUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('장바구니에 해당 상품이 존재하지 않습니다.');
        ELSE
            -- 장바구니에서 상품 제거
            DELETE FROM O_CARTLIST
            WHERE CART_ID = VCART_ID
            AND PDT_ID = PPDT_ID
            AND NVL(OPT_ID, 0) = NVL(POPT_ID, 0);  -- 옵션 ID 비교, NULL 처리

            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('장바구니에서 상품이 제거되었습니다.');
        END IF;
        
        -- 장바구니 내용 출력
        UP_CART_CHECK(PUSER_ID);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('장바구니에 상품이 존재하지 않습니다.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('상품을 장바구니에서 제거하는 중 오류가 발생했습니다. 오류 메시지: ' || SQLERRM);
    END;
END;











 
 	
--7) 실행문

-- 상품창에서 장바구니로 상품 추가
EXECUTE get_productinfo(1);
EXECUTE UP_CARTLIST_ADD(1001, 1, NULL, 1);
--                      회원 상품 옵션 수량


-- 상품창에서 동일 제품 추가 (수량 증가)
EXECUTE get_productinfo(1);
EXECUTE UP_CARTLIST_ADD(1001,1,NULL,1);
--                      회원 상품 옵션 수량


-- 상품창에서 동일 제품 추가 (재고보다 많이 추가)
EXECUTE get_productinfo(1);
EXECUTE UP_CARTLIST_ADD(1001,1,NULL,100);


-- 상품창에서 옵션 선택 안하고 추가하려고 하는 경우
EXECUTE get_productinfo(168);
EXECUTE UP_CARTLIST_ADD(1001,168,NULL,1);
--                      회원 상품 옵션 수량


-- 상품창에서 해당 상품에서 제공하지 않는 옵션 추가하려고 하는 경우
EXECUTE get_productinfo(168);
EXECUTE UP_CARTLIST_ADD(1001,168,4,1);
--                      회원 상품 옵션 수량





-- 상품창에서 옵션 선택하고 추가
EXECUTE get_productinfo(168);
EXECUTE UP_CARTLIST_ADD(1001,168,7,1);
--                      회원 상품 옵션 수량


-- 장바구니로 이동해서 장바구니 조회
EXECUTE UP_CART_CHECK(1001);
--                    회원

-- 장바구니에서 상품 수량 제어 (수량을 1 미만으로 감소시키려는 경우)
EXECUTE UP_CARTLIST_UPDATE (1001, 1, -3);
--                          회원 상품 수량


-- 장바구니에서 상품 수량 제어 (수량을 감소시킬 경우)
EXECUTE UP_CARTLIST_UPDATE (1001, 1, -1);
--                          회원 상품 수량ㅁ


-- 장바구니에서 상품 선택, 미선택
EXECUTE UP_CARTLIST_SELECT (1001, 1,'N');
--                          회원 상품 선택여부

EXECUTE UP_CARTLIST_SELECT (1001, 1,'Y');
--                          회원 상품 선택여부



-- N 젤리 피치 네일 (상품 제거)
EXECUTE UP_CART_DELETE(1001, 1, NULL);
--                     회원 상품 옵션

-- 토우 세퍼레이터 2종, 옵션: 플로렌스 (상품 제거)
EXECUTE UP_CART_DELETE(1001, 168, 7);
--                     회원 상품 옵션


