--게시판 fnq 더미데이터

CREATE TABLE ohora_fnq_board (

  seq NUMBER NOT NULL PRIMARY KEY,
  writer VARCHAR2 (20),
  title VARCHAR2 (200),
  writedate DATE DEFAULT SYSDATE ,
  readed NUMBER DEFAULT (0),
  tag NUMBER(1)NOT NULL ,
  category VARCHAR2 (50),
  content CLOB
);

CREATE SEQUENCE ohora_fnq_seq 
    START WITH 1 
    INCREMENT BY 1 
    NOCACHE;

    -- tag 숫자 의미
    -- 2 고정x 글
    -- 1 상단 고정 글
SET DEFINE OFF;

SELECT *
FROM ohora_fnq_board
ORDER BY seq desc;

--insert문 예시
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, '관리자', 'Q. 회원 탈퇴 방법이 궁금합니다.', SYSDATE, 0, 2, '주문/결제/취소', '이것은 fnp 본문 내용입니다.');



--더미
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 회원 탈퇴 방법이 궁금합니다.', SYSDATE, 0, 2, '사이트 이용', '■ 탈퇴 방법: 홈페이지 로그인 > MY PAGE > (스크롤 하단)회원정보 > 비밀번호 / 비밀번호 확인 입력 > 회원탈퇴 클릭 > 탈퇴 사유 선택후 탈퇴 진행

■ 탈퇴 안내사항:
- [배송 완료] [환불 완료] 상태가 아닌 주문 건이 있을 시 탈퇴가 가능하지 않습니다.
- 탈퇴 시, 즉시 탈퇴 처리되며 서비스 이용이 가능하지 않습니다. (다만, 부정 이용 거래 방지 및 전자상거래법 등 관련 법령에 따라 보관이 필요한 경우 해당 기간 동안 회원 정보를 보관할 수 있습니다.)
- 탈퇴한 아이디는 재사용과 복구가 가능하지 않습니다.
- 탈퇴 시 구매 내역 확인이 가능하지 않습니다.
- 탈퇴 시 적립금 및 쿠폰, 이벤트, 기타 혜택 모두 소멸하며, 재가입 하더라도 복구되지 않습니다.
- 기존 작성한 리뷰 및 댓글은 자동으로 삭제되지 않으며, 탈퇴 후 회원 정보 삭제로 작성자 확인이 어려워 리뷰 및 댓글 삭제 처리가 가능하지 않습니다.');

--------------------------------------------------------------------------------

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤스트립] 어떻게 하면 손톱에 딱 맞는 사이즈를 찾을 수 있나요?', SYSDATE, 0, 2, '상품', '젤스트립은 15종 사이즈 & 30pcs 구성으로 다양한 손톱 사이즈에 사용 가능합니다.
맞는 사이즈가 없을 경우, 젤스트립을 손톱 크기에 맞게 살짝 늘려주시면 더욱더 완벽하게 부착하실 수 있습니다.

Tip. 젤스트립을 늘리실 때, 접착력이 떨어지지 않도록 손과 손톱의 유수분기를 완벽하게 제거해주세요. ');


INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤스트립] 파츠 상품에 동봉되어있는 손톱보호젤은 뭔가요?', SYSDATE, 0, 2, '상품', '손톱보호젤은 파츠로 인해 생길 수 있는 손톱 손상, 기포, 유수분으로부터 손톱을 보호해줍니다.  

파츠 상품의 경우, 동봉된 손톱보호젤 부착 후 파츠가 올라간 젤스트립을 붙여주세요.

< 파츠 상품 사용 방법 >
1. 프렙패드로 손톱의 유수분기를 제거합니다.
2. 파츠 젤스트립 부착 전 손톱보호젤을 부착해주세요.
3. 파츠 젤스트립을 파츠 주변부부터 꼼꼼하게 부착하여 기포 없이 붙여줍니다.
4. 오호라 젤램프 기준 2~3회 경화시켜줍니다.

Tip. 오호라 프로 글로시 탑젤을 파츠의 주변부에 얇게 바라주시면 유지력이 더 좋아집니다.  ');


INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤스트립, 젤네일팁] 베이스젤/탑젤을 사용해도되나요?', SYSDATE, 0, 2, '상품', '베이스젤의 경우 제거 과정에서 손톱 표면과 함께 뜯겨 손톱 손상을 야기할 수 있기에 권장해 드리지 않습니다.


오호라 젤네일은 실제 액상 젤로 만들어졌기 때문에, 젤네일 용 탑젤을 사용해야 합니다.

특히, 오호라 젤네일에 최적화된 [오호라 프로 글로시 탑젤]을 사용하여 지속력과 광택을 더해보세요. ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤스트립] 젤램프로 꼭 경화시켜야하나요?', SYSDATE, 0, 2, '상품', '오호라 젤스트립은 실제 액상 젤을 60%만 굳혀 말랑말랑하게 만든 제품으로 마무리 과정에서 UV LED 젤램프 경화 과정이 꼭 필요합니다. 



완벽한 경화를 위해 오호라 젤램프로 1~2회(오호라 프로 젤램프 사용 시 1회) 경화하는 것을 권장드리며, 6W 이상의 시중 젤램프라면 함께 사용할 수 있습니다. 



※  젤램프 사용 시, 미사용 젤스트립이 빛에 노출되지 않도록 주의해주세요.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤램프] 오호라에서 판매중인 젤램프마다 차이는 무엇인가요?', SYSDATE, 0, 2, '상품', '이것은 fnp 본문 내용입니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤스트립] 남은 젤스트립은 어떻게 보관하나요?', SYSDATE, 0, 2, 상품, '젤스트립은 제품 박스 하단의 유통기한까지 사용이 가능합니다. 

사용 후 남은 젤스트립은 아래와 같이 보관 권장 드립니다.



1) 젤스트립이 빛(자외선, UV)에 노출되면 굳을 수 있으므로, 

사용하고 남은 제품은 세미큐어젤 전용 케이스에 넣어 직사광선을 피해 그늘진 곳에 보관해주세요. 

(부착 시 남은 젤스트립이 젤램프 빛에 닿지 않도록 주의해주세요.) 



2) 온도에 영향을 받는 제품으로 상온(20-30도)에 보관해주세요. 

기온이 낮아지면 일시적으로 굳을 수 있으나, 온도를 따뜻하게 하면 다시 말랑하게 사용할 수 있습니다. 



Tip. 남은 젤스트립은 다른 디자인과 Mix&Match해서 나만의 디자인으로 즐겨보세요.  ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤스트립] 어떻게 제거해야하나요?', SYSDATE, 0, 2, '상품', '동봉된 우드스틱에 네일 전용 리무버를 충분히 적셔 가장자리부터 결을 따라 부드럽게 밀면서 제거하면 손·발톱 손상을 최소화할 수 있습니다. 



접착제가 남았다면 네일 전용 리무버를 적신 화장솜이나 물티슈로 마무리해주세요. 



Tip. 오호라 프로 이지필 리무버 사용 시 더 쉽고 부드럽게 제거가 가능합니다.



※ 제거가 필요한 세미큐어젤 외 물체에 리무버의 내용물이 닿지 않도록 사용 시 주의가 필요합니다. ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤스트립, 젤네일팁] 임산부 / 어린이가 사용해도 되나요?', SYSDATE, 0, 2, '상품', '
오호라 제품은 어린이 장신구 안전 기준에 따른 중금속과 유해 물질 검출 시험을 통과하였으며, 

다양한 안전성 검증을 주기적으로 진행하여 관리하는 상품으로 전 성분에 문제가 없어 안심하고 이용하셔도 됩니다.



다만, 유아 혹은 어린이의 경우 손톱을 물어 뜯을 수 있기 때문에 섭취하지 않을 수 있도록 주의 부탁 드리며,

임산부에 대한 안전성을 입증하는 기관이 없어 증빙 자료를 갖추기 어렵다 보니 

혹시나 걱정되신다면 내원 하시는 산부인과 혹은 전문 의료 기관을 통해 사용 가능 여부에 대한 확인을 권장 드립니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 배송은 얼마나 걸리나요?', SYSDATE, 0, 2, '배송', '배송은 출고일로부터 주말/공휴일 제외 평균 1~3일 정도 소요됩니다.

 

상품 출고 시 송장 번호가 알림톡 혹은 SMS로 발송되며, 입고지연 및 품절 등으로 인해 출고가 지연될 경우 별도 안내드리고 있습니다.



모든 배송은 지역 택배사 사정과 천재지변으로 지연될 수 있으며, 출고 후 배송에 대한 부분은 택배사로 문의 부탁드립니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 배송비는 얼마인가요?', SYSDATE, 0, 2, '배송', '기본 배송비는 3,000원 이며, 5만원 이상 구매 시 무료배송 됩니다.  

(단, 제주 및 특수 도서 산간 지역은 지역별로 3,000~8,000원의 별도 추가 운임 발생)');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 적립금은 어떻게 사용하나요?', SYSDATE, 0, 2, '사이트 이용', '적립금은 결제페이지에서 적용이 가능합니다. 

3,000원 이상부터 사용이 가능하며, 최대 사용 금액은 제한이 없습니다. 



적립금으로만 결제할 경우, 결제금액이 0으로 보여지며 [결제하기] 버튼을 누르면 주문이 처리됩니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 쿠폰은 어떻게 사용하나요?', SYSDATE, 0, 2, '사이트 이용', '이것은 fnp 본문 내용입니다.');
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤램프] 오호라에서 판매중인 젤램프마다 차이는 무엇인가요?', SYSDATE, 0, 2, '쿠폰은 결제페이지에서 적용이 가능합니다. 

결제 시 하나의 쿠폰만 사용이 가능하며, 중복 사용은 불가합니다. 



쿠폰에 따라 사용 가능 조건이 상이하므로, 결제 전 my page 쿠폰 내역에서 확인 후 이용 부탁드립니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 가상계좌 입금 방법이 어떻게 되나요?', SYSDATE, 0, 2, '사이트 이용', '가상계좌는 아래 방법으로 입금이 가능합니다.

1. 결제수단 > 가상계좌 선택
2. 입금은행/입금자명 선택
3. 주문 완료 화면 내 가상 계좌번호 확인
4. 입금(결제일 제외 7일 이내 입금 가능) ex) 1일 주문 시 8일 23시 59분 59초까지 입금 가능

자동 입금 확인까지는 최소 20분에서 2시간 정도 소요될 수 있습니다.

입금자명 또는 입금액이 다른 경우 자동 입금 확인이 어렵기에,
이 경우 고객센터로 문의 부탁드립니다.

▶ 오호라 고객센터
- 카카오톡 채널 @오호라(ohora) / 1:1 문의하기
- 운영시간 : 평일 09:00~18:00 (Lunch 12:30~13:30)');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 현금 영수증 발행이 가능한가요?', SYSDATE, 0, 2, '사이트 이용', '가능합니다.

상품 주문 시 결제수단에서 [실시간 계좌 이체] 혹은 [가상계좌]를 선택 후 현금 영수증 신청란에 정보 입력해주시면 해당 정보로 현금 영수증이 발생됩니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 신규 회원 가입 시 혜택이 있나요?', SYSDATE, 0, 2, '회원', '신규 회원가입 후 첫 구매하신 고객님을 대상으로 18,000원 상당의 오호라 젤램프를 무료로 증정해 드리고 있습니다.
상기 이벤트 외에도 오호라 공식몰에서만 제공되는 다양한 이벤트 및 혜택을 만나보세요.

※ 신규 회원 가입 후 로그인을 하셔야 정상적으로 혜택이 적용됩니다.(비회원 구매, 비 로그인 네이버페이 구매 제외 )
※ 시스템상 최초 주문 건만 첫 구매로 간주하여, 구매 취소 후 재주문 시 혜택이 적용되지 않습니다. (ID당 최초 1회 지급)  ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 회원정보를 변경하고 싶어요.', SYSDATE, 0, 2, '회원', '자사몰 회원가입 고객의 경우, 마이페이지 > 회원정보에서 정보 수정이 가능하나,
간편 로그인의 가입 고객의 경우 일부 정보의 수정이 어렵습니다.

부득이하게 수정이 필요하신 경우에는 오호라 고객센터로 문의주시면 빠르게 수정 도와드리겠습니다.

▶ 오호라 고객센터
- 카카오톡 채널 @오호라(ohora) / 1:1 문의하기
- 운영시간 : 평일 09:00~18:00 (Lunch 12:30~13:30)  ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. ID/PW가 기억이 안나요.', SYSDATE, 0, 2, '회원', '로그인 → 하단 아이디 찾기 → 이메일 또는 휴대폰 번호 선택 후 정보를 입력해주세요.
이후 아이디 찾기 또는 비밀번호 찾기가 가능합니다.

▶자사몰 ID : 아이디 일부 마스킹 처리되어 표기
자사몰 PW: 아이디,이메일/휴대폰 번호 인증 후 비밀번호 재 설정 해주세요.

▶간편 가입 ID : 숫자******* 자동 생성 된 ID가 마스킹 처리되어 표기

    ex) 카카오톡 : 숫자@k

          네이버 : 숫자@n

          애플 :  숫자@a

※네이버,카카오톡,페이스북,애플로 간편가입을 하신 경우, 오호라 자사몰과 연동만 시킨 것으로 계정 정보 및 비밀번호 찾기가 불가능 합니다.
이 경우 해당 고객센터/사이트로 문의 부탁드립니다.  ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 리뷰(이용 후기) 운영 정책이 궁금합니다.', SYSDATE, 0, 2, '사이트 이용', '리뷰(이용 후기) 운영 정책은 아래와 같습니다.  



? 오호라 리뷰 작성 유의사항

1. 주문 상태가 [배송 완료]인 경우에 리뷰 작성이 가능합니다.  

   *2023년 9월 1일 이후 '배송 완료 90일 후까지 리뷰 작성 가능'으로 변경 되었습니다. 

2. 리뷰 작성은 MY PAGE -> 주문 내역에서 가능합니다.

3. 작성된 리뷰는 MY PAGE -> 게시글 관리에서 직접 수정이 가능합니다.

4. 리뷰 작성 후 적립금은 영업일 2~3일 내 지급됩니다. 단, 적립금 지급 후 반품 및 취소한 경우 지급된 적립금은 차감되며, 작성한 리뷰도 삭제됩니다.

5. 최초로 작성된 리뷰에 한하여 적립금이 1회 지급되며, 중복 리뷰에 대한 적립금은 지급되지 않습니다.

6. 결제금액 0원 또는 이벤트(증정품) 등 행사로 지급된 제품의 경우 리뷰 적립금이 지급되지 않습니다.

7. 20자 미만 텍스트 리뷰로 작성된 경우 적립금은 지급되지 않습니다.

8. 세트 상품 리뷰 작성의 경우 적립금은 1회만 지급됩니다.

9. 지급된 총 적립금이 3,000원 이상일 경우 사용이 가능합니다.

10. 작성해 주신 리뷰 글과 첨부 파일은 개인의 의견이 반영된 내용으로 해당 내용에 대한 책임은 작성자 본인에게 있습니다.

11. 배송현황, 주문취소, 교환 및 반품 등에 대한 문의는 오호라 고객센터를 통해 문의해 주시길 바랍니다.

12. 등록된 모든 리뷰에 기재된 텍스트와 사진 및 영상은 ohora 마케팅 등에 활용될 수 있습니다.





? 리뷰 적립금 지급

 1. 베스트 리뷰  5,000원, 타임투 오호라 3,000원

 2. 포토&동영상 리뷰 300원/500원, 텍스트 리뷰 : 100원

 *네일/페디 상품 구매 후 리뷰 작성 시 구매한 제품과 동일하며,  손/발톱에 부착한 포토&동영상 리뷰 -> 500원 지급



▶2024.02.26 포토 적립금 지급 조건 변경 

 ※포토리뷰 적립금 변경 안내 바로가기:  https://ohora.kr/article/fnq/14/224951/





? 오호라 리뷰 블라인드 정책 

1. 악의적으로 제품의 기능 및 가치를 저하시킬 수 있는 오해의 소지가 담긴 게시글

2. 욕설, 비속어, 스팸성 도배 등의 게시글로 반복되는 동일한 단어나 문장이 기재된 게시글

3. 상업적인 홍보의 목적으로 작성된 게시글 또는 타 업체가 언급된 게시글

4. 개인정보를 포함한 게시글

5. 리뷰를 작성한 상품과 관계없는 게시글 또는 일치하지 않는 사진

6. 제품 이용 후기에 허위 사실이 포함되어 있는 게시글

7. 특정인, 특정 업체에 대한 모욕 및 사생활 침해로 명예훼손의 권리침해가 인정될 수 있는 게시글

8. 취소 및 환불이 진행된 주문 건과 연관된 게시글

9. 그 외 사회통념과 정서에 어긋나는 내용이 포함되어 있거나, 리뷰 운영 원칙에 위배 혹은 위배 가능성이 농후한 게시글



※ 리뷰 운영 정책은 정보통신망 이용 촉진 및 정보 보호 등에 관한 법률 제44조에 의거하여 삭제 등의 필요한 조치가 취해질 수 있습니다.   



리뷰 운영 정책에 관한 문의사항은 오호라 고객센터로 문의 부탁드립니다.

▶ 오호라 고객센터

 - 카카오톡 채널 @오호라(ohora) / 1:1 문의하기

 - 운영시간 : 평일 09:00~18:00 (Lunch 12:30~13:30) ');
 
 
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 고객센터 이용 방법 알려주세요.', SYSDATE, 0, 2, '사이트 이용', '오호라 고객센터는 평일 9시부터 18시까지 채팅 상담으로 운영됩니다.

주말 및 공휴일, 운영 시간 이외에는 상담사 연결이 어려우나 ,

채팅창에 문의글을 남겨주시면 확인 후 운영 시간 내에 순차적으로 답변 드리고 있습니다.





[이용 방법]

■ PC / APP

   화면 오른쪽 하단 1:1 문의하기 버튼 클릭




■ 카카오톡 상담: 카카오톡 채널 @오호라(ohora) > 채팅하기 > [고객센터] 클릭





   

상담 시간 외 문의사항이 있으실 경우, 운영 시간 내 빠르게 답변드릴 수 있도록 노력하겠습니다.  ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 오프라인 매장에서 오호라를 구매할 수 있나요?', SYSDATE, 0, 2, '기타', '오호라의 모든 제품은 온라인을 통해서만 구매하실 수 있으며,

별도의 오프라인 매장은 운영하고 있지 않습니다.





오호라 공식몰에서만 제공되는 특별한 이벤트 및 혜택(회원가입 후 첫 구매 시 젤램프 증정 등)과 함께

온라인에서 오호라를 만나보세요.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤램프] 오호라에서 판매중인 젤램프마다 차이는 무엇인가요?', SYSDATE, 0, 2, '상품', '이것은 fnp 본문 내용입니다.');
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 휴면 회원은 무엇인가요?', SYSDATE, 0, 2, '회원', '휴면 회원은 2015년 8월 18일부터 시행된 개인정보 유효 기간제에 따라 1년 이상 자사몰 접속 이력이 없는 회원을 대상으로 적용됩니다. 



개인정보 유효기간 만료 30일 전에 등록된 이메일로 사전 안내드리며, 휴면 회원 전환 시 자사몰에서 진행되는 이벤트 혜택은 적용되지 않습니다. 



휴면 회원 해제를 원하신다면, 로그인 화면에서 등록된 ID와 PW 입력 시 자동으로 해제됩니다.



  ID/PW 찾는 방법 바로가기 ');
  
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [커스텀젤] 사용기한이 정해져 있나요?', SYSDATE, 0, 2, '상품', '사용기한은 제조일로부터 2년으로 제품에 별도 표기되어있으며, 사용기한이 남아있더라도 개봉 후 1년 이내 사용을 권장합니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [커스텀젤] 꼭 오호라 젤네일 위에 도포해야 하나요?', SYSDATE, 0, 2, '상품', '타사 젤 제품과 함께 사용 시 사용한 제품에 따라 호환성에 차이가 있을 수 있습니다.



오호라 젤네일 전용으로 만들어진 커스텀젤은 가급적 오호라 젤네일 위에 도포하는 것을 권장합니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [커스텀젤] 임산부 / 어린이가 사용해도 되나요?', SYSDATE, 0, 2, '상품', '임산부의 경우 전문의와 충분한 상의 후 사용하는 것을 권장합니다.



커스템젤은 성인용으로 만들어진 제품으로 영유아의 손에 닿지 않는 곳에 보관해주시고, 손·발톱과 피부가 약한 어린이는 사용을 권장하지 않습니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [커스텀젤] 커스텀젤 사용 후 어떻게 보관해야 하나요?', SYSDATE, 0, 2, '상품', '반드시 뚜껑을 닫은 채로 직사광선을 피해 상온에서 보관해주세요.



* 뚜껑을 닫지 않은 채 장시간 보관되거나, 사용 중인 젤램프에 노출될 경우 내용물이 굳을 수 있습니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [커스텀젤] 예쁘게 모양을 내는 팁이 있나요?', SYSDATE, 0, 2, '상품', '상세페이지의 드로잉 가이드를 토대로 원하는 형태의 디자인을 종이에 연습해보세요.

오호라 젤네일 위에 도포 후 수정이 필요하다면 경화되지 않은 상태에서 물티슈로 닦아낸 후 물기가 완전히 마른 후 다시 도포해주세요.



tip. 커스텀젤은 도포 후 형태가 쉽게 무너지지 않으며 셀프 레벨링이 뛰어나 도포 직후 젤이 고깔 모양으로 늘어나는 현상이 발생하더라도 수 초 이내 완화되오니 원하는 양만큼 도포한 후 과감히 떼어내 주세요.



tip. 여러 손가락에 사용할 경우, 한 손가락씩 도포·경화해 주세요.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [커스텀젤] 탑젤을 먼저 바르고 커스텀젤을 사용해도 되나요?', SYSDATE, 0, 2, '상품', '커스텀젤을 먼저 도포하고 그 위에 탑젤은 얇게 바르는 것을 권장하고 있습니다');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [커스텀젤] 오호라 프로 포인트 젤램프가 아닌 일반 젤램프로 경화해도 되나요?', SYSDATE, 0, 2, '상품', '오호라 프로 포인트 젤램프로 경화 시, 손톱으로부터 3~4cm 떨어진 지점에서 도포 한 양에 따라 20초씩 1~2회 경화해주세요.

* 오호라 프로 포인트 젤램프는 짧게 누르면 20초, 길게 누르면 60초 작동됩니다.



오호라 젤램프로 경화 시 도포한 양에 따라 45초씩 2~3회 경화해주세요.



tip. 오호라 프로 포인트 젤램프 혹은 오호라 젤램프와 동일한 사양이라면 시중에 판매되는 젤램프를 사용해도 무방합니다.

 ');
 
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤스트립, 젤네일팁] 부착 기간이 정해져 있나요?', SYSDATE, 0, 2, '상품', '젤스트립, 젤네일팁은 부착 방법 및 손, 발톱 상태에 따라서 최대 2주 이상 유지될 수 있습니다.

부착 시 틈이 생기지 않도록 꼼꼼하게 밀착시켜주시고, 완전히 밀착하지 않은 경우 손, 발톱 위생 및 건강을 위해 

20일 이내에 제거를 권장하고 있습니다.



개인차가 있기는 하지만 사용하시다가 손톱이 손상되었다고 느껴지실 경우 약 2주 정도 휴식을 취하신 후 부착하시기를 권장 드립니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 길이를 손톱에 맞게 잘라서(다듬어서) 사용이 가능한가요?', SYSDATE, 0, 2, '상품', '오호라 젤네일팁은 연장된 길이에 가장 예쁜 쉐입으로 만들어져 있어서 길이를 잘라서 조정할 시 설계된 쉐입이 틀어질 수 있습니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 탑젤을 사용해도 되나요?', SYSDATE, 0, 2, '상품', '네 가능합니다. 



Tip. 오호라 프로 글로시 탑젤은 젤네일팁 부착 후 덧발라주면 유리알 광택감과 지속력을 향상시켜 주며 논 와이프 타입의 제품으로 초보자도 전문가처럼 쉽게 사용할 수 있습니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤램프] 오호라에서 판매하는 모든 젤램프로 경화가 가능한가요?', SYSDATE, 0, 2, '상품', '오호라 제품은 상품과 젤램프에 따라 적정 경화 횟수가 상이합니다.

상세 내용은 아래 표에서 확인해주세요.



');

    
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 오호라 프로 네일 프라이머 플러스 사용이 가능한가요?', SYSDATE, 0, 2, '상품', '네. 가능합니다.

오호라 프로 네일 프라이머 플러스는 손·발톱의 요철을 커버해 매끈하게 정리해주는 동시에 보호막을 형성해 줍니다.

젤네일팁 부착 전, 오호라 네일 프라이머 플러스를 도톰하게 발라주시면,
손톱의 손상을 최소화하고 유지력을 높이는 데 도움이 되는 점 참고 부탁드립니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 어떻게 제거해야 하나요?', SYSDATE, 0, 2, '상품', '젤네일팁 본품 박스 내 동봉된 제거툴과, 이지필 리무버를 사용 시 효과적으로 젤네일 팁 제거가 가능합니다.



젤네일팁을 힘으로 떼어낼 경우 손톱 손상으로 이어질 수 있기 때문에 동봉된 스트링 리무버를 사용하여 제거해 주시기 바랍니다. 



Tip. 스트링 리무버의 엣지로 큐티클 라인에 틈을 만들어 이지필 리무버를 떨어트린 후 스트링을 틈 사이로 넣어 바깥 방향으로 밀면서 제거해 주세요.



※ 제거가 필요한 세미큐어젤 외 물체에 리무버의 내용물이 닿지 않도록 사용 시 주의가 필요합니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 남은 젤네일팁은 어떻게 보관하나요?', SYSDATE, 0, 2, '상품', '1. 사용하고 남은 제품은 젤네일 팁 본품 박스 및 케이스에 넣어서 직사광선을 피해 그늘진 곳에 보관해주세요.
젤네일 팁이 햇빛(자외선, UV)에 노출되면 굳을 수 있습니다.

2. 젤네일팁은 상온(20-30도)에 보관해주세요.
기온이 낮아지면 젤네일 팁 이 일시적으로 딱딱하게 굳을 수 있으나, 온도를 따뜻하게 해주면 다시 말랑말랑하게 사용할 수 있습니다.

Tip. 헤어드라이기를 이용하여 약한 온풍을 약 10초 정도 쐬어주면 보다 밀착력이 좋아집니다.
(젤네일팁 은 보호 필름이 부착되어 있지 않으니 주의해 주세요.) ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 어떻게 하면 손톱에 딱 맞는 사이즈를 찾을 수 있나요?', SYSDATE, 0, 2, '상품', '젤네일팁이 스트립에 붙어있는 상태에서 손톱에 대본 후, 손톱보다 살짝 작은(약 1~2mm) 사이즈를 골라주세요. 



Tip. 큐티클 라인으로부터 살짝 간격을 두고 부착해 주세요. (큐티클에 바짝 부착하게 되면 큐티클에서 발생하는 유수분으로 유지력이 떨어질 수 있습니다.) 



*젤네일팁은 총 30pcs 구성으로 다양한 손톱 사이즈에 사용이 가능합니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 경화를 하지 않고 사용해도 되나요?', SYSDATE, 0, 2, '상품', '젤네일팁은 실제 액상 젤로 만들어진 제품으로 필수적으로 마무리 과정에서 UV LED 젤램프를 이용해 경화를 해주셔야 합니다.
완벽한 경화를 위해 오호라 프로 젤램프 60초 기준 1~2회 경화하는 것을 권장합니다.

Tip. 오호라 젤램프(화이트)로는 완벽한 경화가 불가능 합니다.

*젤램프 사용 시, 미사용 젤네일 팁이 램프 빛에 노출되지 않도록 주의해 주세요.   ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 젤스트립과 젤네일팁의 차이점이 무엇인가요?', SYSDATE, 0, 2, '상품', '[젤스트립]





-액상젤을 60% 굳혀서 만든 일렬 스티커 형태(strip)로 제작

-내 손, 발톱 크기와 길이에 맞게 자르고 다듬어서 사용할 수 있는 제품

-오호라 젤램프(화이트), 프로 젤램프, 프로 포터블 젤램프 모두 경화 가능한 제품





[젤네일팁]





-액상젤을 40% 정도 굳혀서 만든 손톱의 굴곡과 유사한 팁(tip) 형태로 제작

-어떤 손톱에도 쉐입 및 길이 조절 없이 간편하게 사용 가능한 제품

-프로 젤램프, 프로 포터블 젤램프로 경화 후 사용해야 하는 제품

※오호라 젤램프(화이트)로는 완벽한 경화가 불가능 합니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 언더코트 성분이 어떻게 되나요?', SYSDATE, 0, 2, '상품', '[2024.06.19] [리뉴얼] 에틸아세테이트,부틸아세테이트,나이트로셀룰로오스,아디픽애씨드/네오펜틸글라이콜/트라이멜리틱안하이드라이드코폴리머,에탄올,아이소프로필알코올,수크로오스아세테이트아이소부티레이트,캠퍼,정제수,드로메트리졸



[기존] 정제수, 폴리우레탄-11, 다이프로필렌글라이콜다이메틸에터, 프로필렌글라이콜, 펜틸렌글라이콜



*ohora에서는 고객님들께서 보다 안전하게 사용하시기를 바라는 마음에 주기적으로 성분 검사를 진행하고 있으니 안심하고 사용하셔도 좋습니다!

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 한 사이즈 작은 팁 사용을 추천하는 이유가 무엇인가요?', SYSDATE, 0, 2, '상품', '젤네일팁은 손톱 굴곡과 유사한 곡면으로 제작되어 눈으로 보는 것보다 실제 손톱에 부착했을 때 더 크게 느껴집니다.

따라서 실제 손톱보다 살짝 작은 사이즈를 부착하시면 더 예쁜 연출이 가능한 점 참고 부탁드립니다!');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 부착 후 커스텀젤 사용이 가능한가요?', SYSDATE, 0, 2, '상품', '네 가능합니다. 



Tip. 젤네일팁 경화 후 커스텀젤 사용 시 탑 젤을 얇게 도포해 주시면 유지력 향상 및 광택감을 느껴보실 수 있습니다. 



Tip. 커스텀젤은 도포 후 형태가 쉽게 무너지지 않으며, 셀프 레벨링이 뛰어나 도포 직후 젤이 고깔 모양으로 늘어나는 현상이 발생하더라도 수 초 이내 완화되오니 원하는 양만큼 도포한 후 과감히 떼어내 주시기 바랍니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. [젤네일팁] 위에 파츠 사용이 가능한가요?', SYSDATE, 0, 2, '상품', '네 가능합니다.

커스텀 파츠를 부착하실 때에는 우드스틱 또는 듀얼스틱을 이용하여 파츠 주변부를 눌러 꼼꼼하게 밀착시켜 주세요.

부착 후 파츠 주변으로 탑젤을 도포하여 경화시켜주면 유지력이 향상되는 점 참고 부탁드립니다. ');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, null, 'Q. 환불 소요 기간은 어떻게 되나요?', SYSDATE, 0, 2, '교환/반품/환불', '주문하신 상품의 취소/반품이 완료된 이후 환불이 진행됩니다.

결제 수단별 환불 시점 및 환불 방법은 아래와 같습니다.



');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 주문 취소시 적립금과 쿠폰 환원은 어떻게 되나요?', SYSDATE, 0, 2, '주문/결제/취소', '주문 취소 또는 반품 시 적립금과 쿠폰은 정상적으로 환원됩니다.

쿠폰의 경우 사용 조건 및 기한 기준에 따라 자동으로 원복 됩니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 주문 취소 철회는 어떻게 할 수 있나요?', SYSDATE, 0, 2, '주문/결제/취소', '마이페이지 [주문 내역]에서 주문 취소 철회가 가능합니다.

환불이 완료 된 경우에는 철회가 불가능하며 재 주문 해주시기를 부탁드립니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 결제 수단을 변경하고 싶어요.', SYSDATE, 0, 2, '주문/결제/취소', '시스템 상 결제 수단 변경이 불가능하여 주문 취소 후 재 구매 해주셔야 합니다

※카드사별 혜택 적용 및 할부 수수료, 할부 개월 수 변경은 카드사 고객센터로 문의 부탁드립니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q.주문한 상품을 취소/변경 하고 싶어요.', SYSDATE, 0, 2, '주문/결제/취소', '주문의 상태에 따라 방법이 상이합니다.

▶결제 완료 및 상품 준비중 상태
취소 : 주문내역에서 직접 취소하실 수 있습니다.
변경 : 주문 취소 후 재 구매 부탁드립니다.

▶배송 준비중, 배송 중 상태
상품 취소/변경은 “상품 준비중” 상태에서만 가능합니다.
취소/변경을 원하실 경우 수령 후 교환/반품 접수 부탁드립니다.
이 경우 교환 및 반품 왕복 배송비 6,000원이 부과됩니다.

(단, 제주 및 특수 도서 산간 지역은 지역별로 3,000~8,000원의 별도 추가 운임 발생)');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 네이버페이로 주문했는데 주문 번호 확인이 되지 않아요.', SYSDATE, 0, 2, '주문/결제/취소', '네이버페이는 비회원 주문으로 오호라 공식 홈페이지에서 확인이 불가능 하며, 네이버페이 결제 내역에서 확인 가능합니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 배송지 변경은 어떻게 하나요?', SYSDATE, 0, 2, '배송', '[결제 완료 및 상품 준비중 상태]
주문 취소 후 재 주문 부탁드립니다.

[배송 준비중, 배송 중 상태]
배송 준비중 또는 배송중 상태의 경우 상품이 택배사로 인계되어 배송지 변경이 불가능합니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 언더코트는 어떻게 사용하나요?', SYSDATE, 0, 2, '상품', '손톱이 부착되지 않은 젤네일팁 부착면 여유 부위에 언더코트를 얇게 한 번만 바른 후 자연건조해주세요.

건조 후 살짝 하얗게 일어나는 현상은 수분이 지나면 자연스럽게 사라집니다.
언더코트를 두껍게 바르면 건조가 오래 걸리며, 손톱과 젤네일팁 사이 틈으로 스며들어 접착력을 저하시킬 수 있습니다.
피부에 발린 언더코트는 물티슈로 가볍게 닦아주세요.
프렙패드로 닦을 시 젤네일팁의 접착력과 광택감에 영향을 끼칠 수 있습니다.

Tip. 오호라 프로 네일 프라이머 플러스를 언더코트 대용으로 사용할 수 있습니다.,

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤램프] 젤램프 다리가 펴지지 않아요.', SYSDATE, 0, 2, '상품', '처음에는 다리와 본체가 꽉 결합되어 있기 때문에 쇠젓가락과 같은 얇은 도구로 지렛대 원리는 이용하여 조금만 힘을 주시면 펴 집니다.
혹시라도 지렛대 원리로도 다리가 펴지지 않을 경우 동영상 촬영 후 고객센터로 연락주시면 신속하게 도움드릴 수 있도록 하겠습니다.

■ 사은품 젤램프 불량 교환 기준
- 배송 완료일로부터 90일 이내 불량(달력일 기준) : 무상교환
- 배송 완료일로부터 90일 이후 불량(달력일 기준) : 교환 및 반품 불가

※ 오호라 고객센터
- 카카오톡 채널 @오호라(ohora) / 1:1 문의하기
- 운영시간 : 평일 09:00~18:00 (Lunch 12:30~13:30)');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤램프]오호라 프로 포터블 램프가 빨리 꺼져요/안 켜져요.', SYSDATE, 0, 2, '상품', '

프로 포터블 젤램프는 제품 안전 설계의 이유로 최초 사용시와 제품이 완전 방전시에 완전 충전이 된 후에 정상 작동이 되도록 설계되었습니다.

일반 어댑터 + 동봉핻린 케이블로 초록불이 켜져 있는 점등 상태가 될 때 까지 충전 후 재 사용 부탁드립니다



*고속 충전 어댑터 또는 C TO C 케이블을 이용하여 충전하실 경우 프로 포터블 램프와 전압이 맞지 않아 정상 작동 되지 않을 수 있습니다.

*최소 120분 이상 충전을 권장드리며, 일반 어댑터와 동봉 된 케이블로 초록불이 켜져있는 "점등" 상태가 될 때까지 충전 후 재 사용 부탁드립니다



[램프 상태]
초록불 점멸 : 충전 중
초록불 점등 : 완충
빨간불 점등 : 배터리 부족

완충 후에도 동일한 증상이 발생할 경우
오호라 케이블과 어댑터를 연결한 전원 콘센트부터 초록색 점등이 보여지는 장면 및 고장 증상이 확인되는 영상 촬영 후 고객센터로 연락주시면 신속하게 도움드릴 수 있도록 하겠습니다 .

■ 사은품 젤램프 불량 교환 기준
- 배송 완료일로부터 90일 이내 불량(달력일 기준) : 무상교환
- 배송 완료일로부터 90일 이후 불량(달력일 기준) : 교환 및 반품 불가

※ 오호라 고객센터
- 카카오톡 채널 @오호라(ohora) / 1:1 문의하기
- 운영시간 : 평일 09:00~18:00 (Lunch 12:30~13:30)

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 불량 제품을 받았는데 어떻게 하나요?', SYSDATE, 0, 2, '교환/반품/환불', '불량 부분이 잘 보이는 사진 또는 영상 + 패키지 박스 하단 LOT.NO 사진 1장 촬영 후 고객 센터로 연락 주시면 불량 확인 후 빠르게 도움드리고 있습니다.

젤램프 불량의 경우 동영상 촬영이 필요하며, 고장 증상 확인 방법에 대해 상세히 기재되어 있습니다. 



  :고장 증상 확인 방법으로 이동하기');
  
INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 비회원으로 주문했는데 주문 번호를 잊어버렸어요.', SYSDATE, 0, 2, '회원', '주문 시 입력한 휴대폰 번호와 이메일로 주문 처리 과정을 보내드리고 있습니다.

1.카카오톡 오호라 알림톡 -> [주문완료 안내] 메시지에서 주문 번호 확인 가능
2.주문 시 입력한 이메일에서 ohora 주문 내역 메일 확인 시 주문 번호 확인 가능
※네이버페이로 구매 하신 경우 네이버페이에서 메일이 발송됩니다.
주문 취소 및 주문 번호 확인은 네이버페이 페이지에서 확인하실 수 있습니다.

카카오 알림톡과 메일에서 확인이 어려우실 경우 고객센터로 연락주시면 빠르게 도움드릴 수 있도록 하겠습니다.

※ 오호라 고객센터
- 카카오톡 채널 @오호라(ohora) / 1:1 문의하기
- 운영시간 : 평일 09:00~18:00 (Lunch 12:30~13:30)

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 오호라 보관함 사이즈가 어떻게 되나요?', SYSDATE, 0, 2, '상품', '오호라 보관함은 세미큐어젤과 케어 용품의 정리를 도와주는 아이템입니다.

세미큐어젤(젤스트립)을 보관할 수 있는 바인더 10장과, 정리 칸막이를 활용하여 제품 보관을 더욱 깔끔하고 편리하게 하실 수 있습니다.



   



[사이즈]

-오호라 보관함

            







             가로:  21cm

             세로 : 15cm 

             높이 : 15cm





















-바인더

             







              전체 가로: 14cm

              전체 세로 : 13cm

              포켓 가로 : 6.1cm

              포켓 세로 : 10.2cm

              





















[오호라 보관함 사용 유의사항]

? 어린이의 손이 닿지 않는 곳에 보관해 주세요.

? 세탁이 불가한 제품으로 표면에 얼룩이 발생한 경우에는 즉시 젖은 수건으로 제거해 주세요.

? 소재의 특성상 자연스러운 주름과 변색이 생길 수 있으며, 날카로운 물체에 긁히면 손상될 수 있습니다.

? 직사광선, 화기 및 고온 다습한 환경에 제품이 노출되지 않도록 주의해 주시고 용도 외에는 사용을 피해주세요

? 증정용 사은품으로 본품 및 구성품은 개별 판매되지 않습니다

? 장기간 보관 및 사용 시 제품의 변형 또는 변색이 될 수 있습니다.

? 너무 많은 양의 내용물을 넣으면 파손 및 변형될 수 있습니다.

? 사용상의 부주의로 인해 제품이 변형될 경우에는 교환이나 환불이 불가합니다.

? 부품 수급 상황에 따라 보관함 구성품의 디자인이 변경될 수 있습니다.

');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. [젤스트립] 국가별 젤스트립 사이즈가 어떻게 되나요?', SYSDATE, 0, 2, '상품', '[KR/JP 젤스트립 사이즈]

국내 상품과 일본 상품의 사이즈는 동일하게 제작되었습니다.



오호라 젤스트립 네일은 총 2장의 베이직(Basic), 포인트(Point) 스트립으로 나뉘어져 있으며,

베이직 스트립의 젤스트립 가장 큰 가로 크기는 약 13mm, 가장 작은 크기는 7mm

포인트 스트립의 가장 큰 젤스트립의 크기는 가로 약 16mm, 가장 작은 젤스트립의 크기는 가로 약 7mm 입니다.

세로 길이는 모두 동일하게 약 22mm 정도로 상세 사이즈는 아래 표에서 확인하세요.









[US젤스트립 사이즈]

미국 고객을 대상으로 출시된 US 디자인으로, 국내에서 출시되고 있는 스트립 사이즈 대비 평균 1.06mm 크게 제작되었습니다.

평소 스트립의 사이즈가 작다고 느끼셨던 분들께 추천하며, 기존 제품에 만족하고 계신 분들도 무리 없이 사용하실 수 있습니다.



베이직 스트립의 젤스트립 가장 큰 가로 크기는 약16mm, 가장 작은 크기는 8mm

포인트 스트립의 가장 큰 젤스트립의 크기는 가로 약 18mm, 가장 작은 젤스트립의 크기는 가로 약 9.5mm 입니다.

세로 길이는 모두 동일하게 약 22mm 정도로 상세 사이즈는 아래 표에서 확인하세요.



');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 네이버페이로 주문했는데 젤램프 사은품이 오지 않았어요.', SYSDATE, 0, 1, '주문/결제/취소', '젤램프 무료 증정 이벤트는 오호라 사이트 신규 회원 가입 회원님들을 대상으로 첫 구매 고객에 한하여 혜택이 적용되는 이벤트입니다.
비회원 구매인 네이버페이는 혜택 증정이 어려운 점 양해 부탁드립니다.');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 교환/반품을 하고 싶은 경우 어떻게 하면 되나요?', SYSDATE, 0, 1, '교환/반품/환불', '교환/반품은 사유에 따라 반품 가능 여부 및 배송비 부과가 다를 수 있습니다.
오호라 교환/반품 규정 안내드립니다.

■단순 변심
미개봉 새 상품에 한해 상품 수령 후 주말 및 공휴일을 포함한 7일 이내 마이페이지 →주문내역 에서 직접 신청하실 수 있습니다.(배송비 고객 부담)

■제품 불량,오배송
상품 공급 일로부터 3개월 이내에 가능하며, 고객 센터를 통한 불량 검수 후 처리됩니다.

■사은품 젤램프 불량 교환 기준
- 배송 완료일로부터 90일 이내 불량(달력일 기준) : 무상교환
- 배송 완료일로부터 90일 이후 불량(달력일 기준) : 교환 및 반품 불가

■교환/반품 신청이 불가능한 경우
- 소비자의 귀책 사유에 의한 상품 훼손 및 사용에 의해 상품 가치가 현저히 감소된 경우 교환 및 반품이 가능하지 않습니다.
- 교환 및 반품으로 인해 사은품 혜택 기준에 미달되었을 경우, 사은품도 함께 보내주셔야 정상적으로 처리 가능합니다.

※ 오호라 고객센터
- 카카오톡 채널 @오호라(ohora) / 1:1 문의하기
- 운영시간 : 평일 09:00~18:00 (Lunch 12:30~13:30)');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 반품 비용은 어떻게 되나요?', SYSDATE, 0, 1, '교환/반품/환불', '
1)무료 배송
① 취소 후 잔액 5만원 이상 : 3,000원(반품 배송비)
② 취소 후 잔액 5만원 미만 : 6,000원(초도 배송비 + 반품 배송비)

?

2) 유료배송 : 3,000원(반품 배송비)



※단, 제주 및 특수 도서 산간 지역은 지역별로 3,000~8,000원의 별도 추가 운임 발생');

INSERT INTO ohora_fnq_Board (seq, writer, title, writedate, readed, tag, category, content) 
VALUES (ohora_fnq_seq.NEXTVAL, 'ohora', 'Q. 비회원 구매 시 첫 구매 혜택 적용이 안되나요?', SYSDATE, 0, 1, '회원', '비회원으로 구매하실 경우 첫 구매 혜택 적용이 되지 않습니다.
ohora 공식몰 회원 가입 후 구매하시면 다양한 혜택이 마련되어 있어 가입 후 구매를 권장드립니다.

[ohora 공식몰 회원 가입 혜택]
■ 신규 가입 첫 구매 고객 대상으로 젤램프(white) 무료 증정
■ 젤네일 팁 구매 시 프로 젤램프 무료 증정
■ 카카오 간편 회원 가입 시 무료배송 쿠폰 및 3,000원 할인 쿠폰 제공
■ 회원을 대상으로 다양한 이벤트 진행 소식 알림

 ? 카카오 간편 가입 바로가기 


* 젤램프 및 프로 젤램프는 ID당 최대 1개 증정되며, 한정 수량 소진 시 조기 종료 될 수 있습니다.');

