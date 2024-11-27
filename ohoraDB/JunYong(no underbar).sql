
--리뷰 수 5 업뎃 ( 1번 상품)
update oproduct SET pdtreviewcount = 5 WHere pdtid = 1;


--회원 추가사항 (ouser)

-- sns동의 하나로 묶여있던것 sms/email 로 분리할 것임 따라서 sns => sms로 변경
ALTER TABLE ouser RENAME COLUMN USERSNSAGREE TO USERSMSAGREE;

--email동의 컬럼 추가
ALTER TABLE ouser ADD USEREMAILAGREE CHAR(1);

--디폴트 N줬음 이메일도 
alter table ouser modify USEREMAILAGREE default 'N';


-- 리뷰 테이블에 제품번호 컬럼 추가
ALTER TABLE oreview
ADD pdtid INT;

ALTER TABLE oreview
MODIFY pdtid NUMBER;

COMMENT ON COLUMN oreview.pdtid IS '제품ID';

-- 리뷰에 제품번호 FK로 주기
ALTER TABLE oreview
ADD CONSTRAINT fkoproduct
FOREIGN KEY (pdtid)
REFERENCES oproduct(pdtid);

-- 카트리스트 id를 order테이블의 FK로 주기
ALTER TABLE oorder
ADD CONSTRAINT fkocartlisttooorder
FOREIGN KEY (cartid)
REFERENCES ocartlist(clistid);


-- 리뷰URL 테이블 수정 (포토 영상 구분 없애고 파일로서 관리)
ALTER TABLE orevurl DROP COLUMN rurlphoto;
ALTER TABLE orevurl DROP COLUMN rurlrecord;

ALTER TABLE orevurl ADD filesystemname VARCHAR2(100);
COMMENT ON COLUMN orevurl.filesystemname IS '파일명';

ALTER TABLE orevurl ADD fileoriginalname VARCHAR2(100);
COMMENT ON COLUMN orevurl.filesystemname IS '오리지널파일명';

ALTER TABLE orevurl ADD filelength NUMBER;
COMMENT ON COLUMN orevurl.filesystemname IS '파일용량';





--더미 (선택 - 리뷰할 때 쓰려고 급조)
select *
from ouser;

select *
from oproduct;

select *
from oorder;

select *
from oreview;

--주문 
INSERT INTO oorder 
VALUES
( 1 , 1 , 1001 , '' , '주문자' , '서울시 강남구 역삼동 1', '07112' ,'01012345678' , '', '','2024-10-15',30000,0,0,'','신용카드',3000);

INSERT INTO oorder 
VALUES
( 2 , 2 , 1002 , '' , '김정열' , '서울시 종로구 창신동 1','07113', '01012345666' , '', '','2024-10-17',55000,0,0,'','신용카드',0);

INSERT INTO oorder 
VALUES
( 3 , 3 , 1001 , '' , '주문자' , '서울시 강남구 역삼동 1','07132', '01012345678' , '', '','2024-10-18',37000,0,0,'','계좌이체',0);

INSERT INTO oorder 
VALUES
( 4 , 4 , 1003 , '' , '야나기' , '서울시 강동구 롯데월드 1','07119', '01012345678' , '', '','2024-10-19',120000,0,0,'','카카오페이',0);

INSERT INTO oorder 
VALUES
( 5 , 5 , 1004 , '' , '루시' , '용인시 처인구 대덕로 1','07166', '01012545678' , '', '','2024-10-20',12000,0,0,'','토스',3000);

INSERT INTO oorder 
VALUES
( 5 , 5 , 1004 , '' , '루시' , '용인시 처인구 대덕로 1','07444', '01012545678' , '', '','2024-10-20',12000,0,0,'','토스',3000);

INSERT INTO oorder 
VALUES
( 6 , 6 , 1005 , '' , '미야기' , '대전광역시 유성구 한국로 1','04112', '01013545678' , '', '','2024-10-21',85000,0,0,'','계좌이체',0);

INSERT INTO oorder 
VALUES
( 7 , 7 , 1005 , '' , '미야기' , '대전광역시 유성구 한국로 1','07912', '01013545698' , '', '','2024-10-24',65000,0,0,'','신용카드',0);

INSERT INTO oorder 
VALUES
( 8 , 8 , 1006 , '' , '페이커' , '서울시 강남구 역삼동 21','01112', '01011545698' , '', '','2024-11-05',19000,0,0,'','신용카드',3000);

-- 리뷰 더미
INSERT INTO oreview 
VALUES
( 1 , 1001 , 1 , '' , '이번에 처음 사봤는데 좋네요' , '2024-10-18', 5 , 8, 1, 1 , 'Y','N','','', 1);

INSERT INTO oreview 
VALUES
( 2 , 1002 , 2 , '' , '친구 소개로 왔는데 정말 좋네요 다음부터 이용안하겠습니다.' , '2024-10-19', 1 , 10, 18, 2 , 'N','N','','', 1);

INSERT INTO oreview 
VALUES
( 3 , 1003 , 3 , '' , '이번에 두번째로 이용해보는데 정말 좋네요 광고 아닙니다. 사진도 올릴거임' , '2024-10-21', 5 , 10, 18, 2 , 'N','Y','','', 1);

INSERT INTO oreview 
VALUES
( 4 , 1004 , 4 , '' , '사진이랑 영상으로 퀄리티 보여드립니다' , '2024-10-23', 4 , 23, 1, 1 , 'Y','Y','','', 1);

INSERT INTO oreview 
VALUES
( 5 , 1005 , 5 , '' , '진짜 별로네요 소비자보호협회에 무슨무슨죄로 고소하다 고소해 고소미 냠냠' , '2024-10-28', 1 , 2, 52, 1 , 'N','N','','', 1);

--리뷰 댓글
select * 
from ocomment;

INSERT INTO ocomment
VALUES
( 1 , 1 , 1002  , '2024-10-20','정말 좋네요 나도 사야지');

INSERT INTO ocomment
VALUES
( 2 , 2 , 1002  , '2024-10-20','내가 언제 이런 글을 썼지?');

INSERT INTO ocomment
VALUES
( 3 , 2 , 1003  , '2024-10-21','하하 이자식 완전 바보로구만');

INSERT INTO ocomment
VALUES
( 4 , 3 , 1001  , '2024-10-22','사진 좋네요 사진작가세요?');

INSERT INTO ocomment
VALUES
( 5 , 3 , 1002  , '2024-10-23','이거 바이럴입니다 백퍼센또');

INSERT INTO ocomment
VALUES
( 6 , 4 , 1002  , '2024-10-25','와 퀄리티 보소~~ > ,, <');

INSERT INTO ocomment
VALUES
( 7 , 5 , 1001  , '2024-10-29','어떻게 하나요?');

INSERT INTO ocomment
VALUES
( 8 , 5 , 1004  , '2024-10-29','비~~상~~');

-- 사진 더미 추가
INSERT INTO orevurl VALUES( 1, 3, 'eca2cf24df7f0b57.webp' , 'eca2cf24df7f0b57.webp' , 10000 );
INSERT INTO orevurl VALUES( 2, 4, '5862d5a348b87057.webp' , '5862d5a348b87057.webp' , 10000 );

COMMIT;
