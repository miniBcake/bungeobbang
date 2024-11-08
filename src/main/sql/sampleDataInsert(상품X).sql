-- 트리거 삭제(트리거 삭제가 필요하시면 삭제해주세요 아니라면 사용 X)
DROP TRIGGER IF exists fishshapedbread.after_payment_insert;
DROP TRIGGER IF exists fishshapedbread.after_order_detail_insert;
DROP TRIGGER IF exists fishshapedbread.after_order_update;
-- 트리거 삭제한다면, DDL에서 다시 생성해주세요

-- 기존 데이터 삭제
-- TRUNCATE, ALTER 자동 커밋
TRUNCATE table bb_order_detail;
delete from BB_ORDER;
alter table BB_ORDER auto_increment =1;
TRUNCATE table bb_payment;
TRUNCATE table BB_POINT;
TRUNCATE table BB_REPLY;
delete from BB_PRODUCT;
alter table BB_PRODUCT auto_increment =1;
delete from bb_product_category ;
alter table bb_product_category auto_increment =1;
TRUNCATE table BB_LIKE;
TRUNCATE table BB_DECLARE;
TRUNCATE table bb_store_menu ;
TRUNCATE table bb_store_work ;
TRUNCATE table bb_store_payment ;
delete from BB_STORE;
alter table BB_STORE auto_increment=1;
delete from BB_BOARD;
alter table BB_BOARD auto_increment=1;
delete from bb_board_category ;
alter table bb_board_category auto_increment=1;
delete from BB_MEMBER;
alter table bb_MEMBER auto_increment=1;
-- 외래 키 제약 조건 다시 활성화

-- INSERT 시 서버를 동작시켜 크롤링 상품 INSERT 이후에 SAMPLE DATA INSERT

-- 상품 카테고리 데이터
INSERT INTO bb_product_category (PRODUCT_CATEGORY_NUM,PRODUCT_CATEGORY_NAME)
VALUES (1,'문구/사무'),
       (2,'리빙'),
       (3,'패션/잡화'),
       (4,'디지털/IT'),
       (5,'홈데코');

-- Member 데이터
INSERT INTO bb_member (MEMBER_NUM, MEMBER_EMAIL, MEMBER_PASSWORD, MEMBER_NAME, MEMBER_NICKNAME, MEMBER_PHONE, MEMBER_PROFILE_WAY, MEMBER_ROLE)
VALUES (1,'admin', '1234', '관리자', '관리자', '010-1111-1111', 'default_profile.png', 'ADMIN'),
       (2,'cndgus0509@naver.com', 'admin1234!', '조충현', '충현핑', '010-1111-1112', 'default_profile.png', 'ADMIN'),
       (3,'rhalwls56', 'admin1234!', '고미진', '미진핑', '010-2222-2222', 'default_profile.png', 'ADMIN'),
       (4,'jjh0355@naver.com', 'admin1234!', '정재희', '재희핑', '010-3333-3333', 'default_profile.png', 'ADMIN'),
       (5,'jelkov@naver.com', 'admin1234!', '안제호', '제호핑', '010-3333-3334', 'default_profile.png', 'ADMIN'),
       (6,'wx_wns_@naver.com', 'admin1234!', '정재준', '재준핑', '010-3333-3335', 'default_profile.png', 'ADMIN'),
       (7,'minibcake@naver.com', 'admin1234!', '한지윤', '지윤핑', '010-3333-3336', 'default_profile.png', 'ADMIN'),
       (8,'user0@test.com', 'owner103!', '김무건', '듬직핑', '010-3333-3337', 'default_profile.png', 'USER'),
       (9,'user1@test.com', 'user123!', '허나윤', '나윤핑', '010-4444-4444', 'default_profile.png', 'USER'),
       (10,'user2@test.com', 'user456!', '이재형', '재형핑', '010-5555-5555', 'default_profile.png', 'USER'),
       (11,'user3@test.com', 'user789!', '김종민', '올라핑', '010-5555-5556', 'default_profile.png', 'USER'),
       (12,'user4@test.com', 'user101!', '남상도', '코딩핑', '010-5555-5557', 'default_profile.png', 'USER'),
       (13,'user5@test.com', 'user102!', '김선호', '선호핑', '010-5555-5558', 'default_profile.png', 'USER'),
       (14,'user6@test.com', 'user103!', '신다솜', '다람핑', '010-5555-5559', 'default_profile.png', 'USER'),
       (15,'user7@test.com', 'user104!', '주예나', '예나핑', '010-5555-5560', 'default_profile.png', 'USER'),
       (16,'user8@test.com', 'user105!', '장준희', '부끄핑', '010-5555-5561', 'default_profile.png', 'USER');


-- BB_STORE 샘플 데이터 (역삼역 부근 도로명주소)
TRUNCATE table BB_STORE; -- 테이블 초기화
INSERT INTO bb_store (STORE_NAME, STORE_ADDRESS, STORE_ADDRESS_DETAIL, STORE_CONTACT, STORE_CLOSED, STORE_SECRET)
VALUES 
-- 서울 종로구
('경복궁 붕어빵', '서울 종로구 사직로 161', '경복궁 앞', '02-1111-1111', 'N', 'N'),
('쌈지 붕어빵', '서울 종로구 인사동길 44', '쌈지길 입구', '02-1111-1111', 'N', 'N'),
('낙원 붕어빵', '서울 종로구 낙산길 41', '낙산공원 앞', '02-1111-1111', 'N', 'N'),
('한복입은 붕어', '서울 종로구 계동길 37', '북촌 한옥마을 언덕길', '02-1111-1111', 'N', 'N'),
-- 서울 강남
('코끼리 붕어빵', '서울특별시 강남구 압구정로 216', '코끼리상가 앞', '02-1111-1111', 'N', 'Y'),
('성창 붕어빵', '서울특별시 강남구 압구정로 336', '성창상가 앞', '02-1111-2222', 'N', 'Y'),
('상경 붕어빵', '서울특별시 강남구 테헤란로 120', '상경빌딩 앞', '02-1111-3333', 'N', 'Y'),
('메리츠 붕어빵', '서울특별시 강남구 강남대로 382', '메리츠타워 앞', '02-1111-4444', 'N', 'Y'),
('테헤란 붕어빵', '서울특별시 강남구 테헤란로 108', '테헤란빌딩 앞', '02-1111-5555', 'N', 'Y'),
('대륭 붕어빵', '서울특별시 강남구 강남대로 362', '대륭강남타워 앞', '02-1111-6666', 'N', 'N'),
('황금 붕어빵', '서울특별시 강남구 강남대로 318', '역삼타워 앞', '02-1111-7777', 'N', 'N'),
('잉꼬 붕어빵', '서울특별시 강남구 언주로 710', '인도', '02-1111-8888', 'N', 'N'),
('핑크 붕어빵', '서울특별시 강남구 언주로 702', '인도', '02-1111-9999', 'N', 'N'),
('컴컴 붕어빵', '서울특별시 강남구 강남대로 542', '인도', '02-1111-0000', 'N', 'N'),
('짱나 붕어빵', '서울특별시 강남구 강남대로 492', '인도', '02-1111-1010', 'N', 'N'),
('민물 붕어빵', '서울특별시 강남구 도산대로 114', '인도', '02-1111-2020', 'N', 'N'),
('도산 붕어빵', '서울특별시 강남구 도산대로 128', '인도', '02-1111-3030', 'N', 'N'),
('대원 붕어빵', '서울특별시 강남구 남부순환로 2947', '대원빌딩 앞', '02-1111-4040', 'N', 'N'),
('테헤란 붕어빵', '서울특별시 강남구 테헤란로 422', '횡단보도 앞', '02-1111-5050', 'N', 'N'),
('도곡 붕어빵', '서울특별시 강남구 도곡로 405', '횡단보도 앞', '02-1111-6060', 'N', 'N'),
('삼성 붕어빵', '서울특별시 강남구 삼성로 301', '횡단보도 앞', '02-1111-7070', 'N', 'N'),
('언주 붕어빵', '서울특별시 강남구 언주로 30길 57', '횡단보도 앞', '02-1111-8080', 'N', 'N'),
('양재 붕어빵', '서울특별시 강남구 강남대로 262', '양재캠코 앞', '02-1111-9090', 'N', 'N'),
('밤고개 붕어빵', '서울특별시 강남구 밤고개로1길 10', '횡단보도 앞', '02-1111-1112', 'N', 'N'),
('광평 붕어빵', '서울특별시 강남구 광평로56길 8-13', '횡단보도 앞', '02-1111-1212', 'N', 'N'),
('도산 붕어빵', '서울특별시 강남구 도산대로 111', '인도', '02-1111-1313', 'N', 'N'),
('선릉 붕어빵', '서울특별시 강남구 선릉로 93길 40', '인도', '02-1111-1414', 'N', 'N'),
('강남 붕어빵', '서울특별시 강남구 강남대로 388', '인도', '02-1111-1515', 'N', 'N'),
('강남 붕어빵', '서울특별시 강남구 강남대로 374', '인도', '02-1111-1616', 'N', 'N'),
('강남 붕어빵', '서울특별시 강남구 강남대로 78길 35', '인도', '02-1111-1717', 'N', 'N'),
('강남 붕어빵', '서울특별시 강남구 강남대로 324', '인도', '02-1111-1818', 'N', 'N'),
('일원 붕어빵', '서울특별시 강남구 광평로19길 15', '일원역 1번출구', '02-1111-1919', 'N', 'N'),
('선릉 붕어빵', '서울특별시 강남구 선릉로 806', '인도', '02-1111-2020', 'N', 'N'),
('압구정 붕어빵', '서울특별시 강남구 압구정로32길 38', '현대맨션 3동 앞', '02-1111-2121', 'N', 'N'),
('파이 붕어빵', '서울특별시 강남구 테헤란로 152', '강남파이낸스센터 뒤', '02-1111-2222', 'N', 'N'),
('금결 붕어빵', '서울특별시 강남구 테헤란로 202', '금융결제원 뒤', '02-1111-2323', 'N', 'N'),
('상록 붕어빵', '서울특별시 강남구 언주로 508', '상록회관 뒤', '02-1111-2424', 'N', 'N'),
('제일 붕어빵', '서울특별시 강남구 테헤란로83길 12', '제일주차장 앞', '02-1111-2525', 'N', 'N'),
('선경 붕어빵', '서울특별시 강남구 남부순환로395길 10', '선경3차아파트 앞', '02-1111-2626', 'N', 'N'),
('테헤란 붕어빵', '서울특별시 강남구 테헤란로69길 16', '인도', '02-1111-2727', 'N', 'N'),
('강남 붕어빵', '서울특별시 강남구 강남대로 562', '인도', '02-1111-2828', 'N', 'N'),
('강남 붕어빵', '서울특별시 강남구 강남대로 432', '인도', '02-1111-2929', 'N', 'N'),
-- 서울 학동  
('동현 붕어빵', '서울 강남구 도산대로 211', '동현빌딩 1F', '02-1111-2929', 'N', 'N'),
('도산 붕어빵', '서울 강남구 도산대로15길 32-10', '1층 현관 바로 옆', '02-1111-2929', 'N', 'N'),
('엘리에나 붕어빵', '서울 강남구 논현로 645', '엘리에나호텔 맞은편', '02-1111-2929', 'N', 'N'),
('오빠 붕어빵', '서울 강남구 언주로136길 10', '횡단보도 오른쪽', '02-1111-2929', 'N', 'N'),
('언니 붕어빵', '서울 강남구 언주로136길 10', '횡단보도 왼쪽', '02-1111-2929', 'N', 'N'),
('이야 붕어빵', '서울 강남구 논현로 636', '이디야빌딩 현관', '02-1111-2929', 'N', 'N'),
('논현 붕어빵', '서울 강남구 논현로 734', '인도', '02-1111-2929', 'N', 'N'),
('미학 붕어빵', '서울 강남구 학동로45길 7', '인도', '02-1111-2929', 'N', 'N'),
('청호 붕어빵', '서울 강남구 언주로148길 14', '청호상가빌딩 가동 2층', '02-1111-2929', 'N', 'N'),
('건희 붕어빵', '서울 강남구 언주로 711', '건설회관 2층', '02-1111-2929', 'N', 'N'),
('언주 붕어빵', '서울 강남구 언주로148길 8', '인도', '02-1111-2929', 'N', 'N'),
('밍현 붕어빵', '서울 강남구 논현로131길 10', '미현빌딩 1층', '02-1111-2929', 'N', 'N'),
('도미 붕어빵', '서울 강남구 도산대로15길 18', '4층 네기다이닝라운지', '02-1111-2929', 'N', 'N'),
('강남 붕어빵', '서울 강남구 언주로 640', '인도', '02-1111-2929', 'N', 'N'),
('태바 붕어빵', '서울 강남구 도산대로 150', '지상 3층 탭샵바', '02-1111-2929', 'N', 'N'),
('로이테 붕어빵','서울 강남구 선릉로131길 16', '1층 구테로이테', '02-1111-2929', 'N', 'N'),
('논현 붕어빵', '서울 강남구 논현동 167-3', '인도', '02-1111-2929', 'N', 'N'),
('상당 붕어빵', '서울 강남구 강남대로122길 15', '상당빌딩 지상 1층 101호', '02-1111-2929', 'N', 'N'),
('시스루 붕어빵', '서울 강남구 학동로25길 11', '씨플레이스 2층 101호', '02-1111-2929', 'N', 'N'),
('학길 붕어빵', '서울 강남구 학동로2길 55', '인도', '02-1111-2929', 'N', 'N'),
('강남 붕어빵', '서울 강남구 학동로42길 21', '1층 102호 (논현동, 규우빌딩)', '02-1111-2929', 'N', 'N'),
('라움 붕어빵', '서울 강남구 언주로 564', '라움아트센터', '02-1111-2929', 'N', 'N'),
('우시야 붕어빵', '서울 강남구 도산대로27길 16', '1층 우시야', '02-1111-2929', 'N', 'N'),
('강남 붕어빵', '서울 강남구 언주로 640', '인도', '02-1111-2929', 'N', 'N'),
('길치 붕어빵', '서울 강남구 언주로 708', '횡단보도 맞은편', '02-1111-2929', 'N', 'N'),
('진도켄 붕어빵', '서울 강남구 도산대로15길 9', '향남빌딩 지하1층 진도켄 이자카야 맞은편', '02-1111-2929', 'N', 'N'),
('강남 붕어빵', '서울 강남구 도산대로17길 4', '인도', '02-1111-2929', 'N', 'N'),
('새들러 붕어빵', '서울 강남구 도산대로17길 10', 'B1 새들러하우스', '02-1111-2929', 'N', 'N'),
('평일 붕어빵', '서울 강남구 강남대로136길 63', '수목금토 1층', '02-1111-2929', 'N', 'N'),
('태석 붕어빵', '서울 강남구 학동로 177', '태석빌딩 3층', '02-1111-2929', 'N', 'N'),
('선릉 붕어빵', '서울 강남구 선릉로129길 24', '인도', '02-1111-2929', 'N', 'N'),
('논현 붕어빵', '서울 강남구 논현로 740', '인도', '02-1111-2929', 'N', 'N'),
('멋진 붕어빵', '서울 강남구 학동로2길 57', '횡단보도 옆', '02-1111-2929', 'N', 'N'),
('호호 붕어빵', '서울 강남구 선릉로141길', '3-4 101호', '02-1111-2929', 'N', 'N'),
('16 붕어빵', '서울 강남구 논현로111길 16', '인도', '02-1111-2929', 'N', 'N'),
('잉어킹 붕어빵', '서울 강남구 학동로5길 5', '1층', '02-1111-2929', 'N', 'N'),
('CAFE_1209', '서울 강남구 언주로 709 1층', 'CAFE_1209', '02-1111-2929', 'N', 'N'),
('우정 붕어빵', '서울 강남구 도산대로30길 23', '1층 우정양곱창', '02-1111-2929', 'N', 'N'),
('강남 붕어빵', '서울 강남구 강남대로152길 67', '1층', '02-1111-2929', 'N', 'N'),
('학동 붕어빵', '서울 강남구 학동로53길 19', '인도', '02-1111-2929', 'N', 'N'),
('강남 붕어빵', '서울 강남구 도산대로 203', '인도', '02-1111-2929', 'N', 'N'),
('우제 붕어빵', '서울 강남구 논현로131길 7', '1층 우제홍 초밥 앞', '02-1111-2929', 'N', 'N'),
-- 서울 중구
('디자인 붕어빵', '서울 중구 을지로 281', '동대문디자인플라자', '02-1111-2929', 'N', 'N'),
-- 인천
('따끈한 붕어빵', '인천광역시 중구 도원동 73-2', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('금붕어집', '인천광역시 중구 북성동1가 102-45', '이디아 옆', '02-777-7778', 'N', 'N'),
('바삭붕어빵', '인천광역시 중구 북성동1가 3-61', '7-64', '02-777-7778', 'N', 'N'),
('행복한 붕어', '인천광역시 중구 북성동1가 75-11', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('길거리 붕어', '인천광역시 중구 북성동1가 98-13', '이디아 옆', '02-777-7778', 'N', 'N'),
('옛날 붕어빵', '인천광역시 중구 북성동1가 98-35', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('달달한 붕어집', '인천광역시 중구 사동 26-19', '이디아 옆', '02-777-7778', 'N', 'N'),
('골목 붕어빵', '인천광역시 중구 신생동 38-1, 38-2', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('포근한 붕어', '인천광역시 중구 신포동 15-2', '이디아 옆', '02-777-7778', 'N', 'N'),
('푸른강 붕어빵', '인천광역시 중구 신흥동3가 52', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('붕어마을', '인천광역시 중구 신흥동3가 7-207', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('웃는 붕어빵', '인천광역시 중구 신흥동3가 7-207', '이디아 옆', '02-777-7778', 'N', 'N'),
('해피붕어', '인천광역시 중구 신흥동3가 7-317', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('노란붕어', '인천광역시 중구 인현동 1-1', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('바다의 맛 붕어빵', '인천광역시 중구 인현동 20-15', '이디아 옆', '02-777-7778', 'N', 'N'),
('포장마차 붕어빵', '인천광역시 중구 인현동 27-48', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('행복붕어', '인천광역시 중구 항동7가 27-106', '이디아 옆', '02-777-7778', 'N', 'N'),
('붕어사랑', '인천광역시 중구 항동7가 27-170', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('달콤붕어', '인천광역시 중구 항동7가 58-2', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('새우맛 붕어빵', '인천광역시 중구 항동7가 86', '올리브영 인도', '02-777-7778', 'N', 'N'),
('노릇노릇 붕어', '인천광역시 미추홀구 주안동 188', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('붕어동네', '인천광역시 미추홀구 주안동 188', '이디아 옆', '02-777-7778', 'N', 'N'),
('따뜻한 붕어', '인천광역시 미추홀구 주안동 958', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('알뜰 붕어집', '인천광역시 미추홀구 주안동 958', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('사계절 붕어빵', '인천광역시 미추홀구 주안동 1598', '이디아 옆', '02-777-7778', 'N', 'N'),
('붕어네집', '인천광역시 미추홀구 주안동 1437-11', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('옛맛 붕어빵', '인천광역시 미추홀구 주안동 1463', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('왕붕어', '인천광역시 미추홀구 주안동 1463', '이디아 옆', '02-777-7778', 'N', 'N'),
('즐거운 붕어빵', '인천광역시 미추홀구 용현동 575-1', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('금붕어빵', '인천광역시 미추홀구 학익동 209-26', '이디아 옆', '02-777-7778', 'N', 'N'),
('쫄깃붕어', '인천광역시 미추홀구 숭의동 162-14', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('우리동네 붕어', '인천광역시 미추홀구 숭의동 58-5', '올리브영 인도', '02-777-7778', 'N', 'N'),
('구수한 붕어', '인천광역시 연수구 청학동 산47-3', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('반달 붕어빵', '인천광역시 연수구 청학동 96-1', '올리브영 인도', '02-777-7778', 'N', 'N'),
('고소한 붕어', '인천광역시 연수구 청학동 514', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('달달붕어네', '인천광역시 연수구 옥련동 631-4', '이디아 옆', '02-777-7778', 'N', 'N'),
('멋진 붕어빵', '인천광역시 연수구 옥련동 308-2', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('방금 구운 붕어', '인천광역시 연수구 동춘동 958-1', '올리브영 인도', '02-777-7778', 'N', 'N'),
('이웃집 붕어', '인천광역시 미추홀구 주안동 958', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('청정 붕어빵', '인천광역시 연수구 동춘동 955', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('어항 붕어집', '인천광역시 남동구 구월동 1322', '올리브영 인도', '02-777-7778', 'N', 'N'),
('즐거운 붕어', '인천광역시 남동구 구월동 787-1', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('맛있는 붕어빵', '인천광역시 남동구 구월동 1336', '올리브영 인도', '02-777-7778', 'N', 'N'),
('포근붕어', '인천광역시 남동구 구월동 1336', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('온정 붕어빵', '인천광역시 남동구 구월동 27', '이디아 옆', '02-777-7778', 'N', 'N'),
('손맛 붕어', '인천광역시 남동구 논현동 727', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('푹신붕어', '인천광역시 남동구 논현동 727', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('얼큰붕어', '인천광역시 남동구 장수동 605-18', '이디아 옆', '02-777-7778', 'N', 'N'),
('빙글붕어빵', '인천광역시 남동구 논현동 775-4', '올리브영 인도', '02-777-7778', 'N', 'N'),
('촉촉 붕어빵', '인천광역시 남동구 논현동 775-3', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('달달 붕어빵', '인천광역시 남동구 논현동 775-3', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('꼬마 붕어빵', '인천광역시 남동구 논현동 809', '이디아 옆', '02-777-7778', 'N', 'N'),
('모자 붕어빵', '인천광역시 남동구 논현동 809', '올리브영 인도', '02-777-7778', 'N', 'N'),
('아디 붕어빵', '인천광역시 남동구 논현동 111-339', '이디아 옆', '02-777-7778', 'N', 'N'),
('스타 붕어빵', '인천광역시 남동구 논현동 111-463', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('벅스 붕어빵', '인천광역시 남동구 구월동 1335-4', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('바나 붕어빵', '인천광역시 남동구 구월동 1465-2', '이디아 옆', '02-777-7778', 'N', 'N'),
('청하 붕어빵', '인천광역시 남동구 구월동 1336-9', '올리브영 인도', '02-777-7778', 'N', 'N'),
('잉어빵 붕어빵', '인천광역시 남동구 구월동 1335-4', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('우린 붕어빵', '인천광역시 남동구 구월동 1409-34', '이디아 옆', '02-777-7778', 'N', 'N'),
('미친 붕어빵', '인천광역시 남동구 논현동 728-10', '올리브영 인도', '02-777-7778', 'N', 'N'),
('얼짱 붕어빵', '인천광역시 남동구 논현동 728-10', '이디아 옆', '02-777-7778', 'N', 'N'),
('달큰 붕어빵', '인천광역시 남동구 논현동 109-104', '올리브영 인도', '02-777-7778', 'N', 'N'),
('꽁지 붕어빵', '인천광역시 남동구 만수동 1067', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('민물 붕어빵', '인천광역시 부평구 부평동 546-62', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('매콤 붕어빵', '인천광역시 부평구 부평동 126-10', '스타벅스 앞', '02-777-7778', 'N', 'N'),
('망고 붕어빵', '인천광역시 부평구 청천동 418-1', '이디아 옆', '02-777-7778', 'N', 'N'),
('사과 붕어빵', '인천광역시 부평구 부평동 431-40', '올리브영 인도', '02-777-7778', 'N', 'N'),
('여친 붕어빵', '인천광역시 서구 신현동 297-1', 'GS25 맞은편', '02-777-7778', 'N', 'N'),
('고민 붕어빵', '인천광역시 서구 가정동 574', '스타벅스 앞', '02-777-7778', 'N', 'N'),
-- 부산
('부산 붕어빵', '부산 동구 중앙대로 206', '부산역 앞', '02-777-7778', 'N', 'N'),
('자피 붕어빵', '부산 동구 중앙대로 197', '이재모피자 옆', '02-777-7778', 'N', 'N'),
('중앙 붕어빵', '부산 동구 중앙대로209번길 12', '인도', '02-777-7778', 'N', 'N'),
('용두산 붕어빵', '부산 중구 용두산길 37-55', '용두산미디어파크 입구', '02-777-7778', 'N', 'N'),
('부서 붕어빵', '부산 서구 구덕로 120', '서구청 앞', '02-777-7778', 'N', 'N'),
('진구 붕어빵', '부산 부산진구 시민공원로 30', '부산진구청 맞은편', '02-777-7778', 'N', 'N'),
('심청 붕어빵', '부산 동래구 온천장로107번길 32', '허심청 1층', '02-777-7778', 'N', 'N'),
('오륙도 붕어빵', '부산 남구 오륙도로 137', '오륙도스카이워크 입구', '02-777-7778', 'N', 'N'),
('수목 붕어빵', '부산 북구 산성로 299', '부산 화명수목원관리사업소 앞', '02-777-7778', 'N', 'N'),
('포장 붕어빵', '부산 해운대구 청사포로 116', '청사포정거장 입구', '02-777-7778', 'N', 'N'),
('감화 붕어빵', '부산 사하구 감내2로 203', '감천문화마을안내센터 입구', '02-777-7778', 'N', 'N'),
('금강 붕어빵', '부산 동래구 금샘로7번길 43', '금강식물원', '02-777-7778', 'N', 'N'),
-- 대구
('달성 붕어빵', '대구 중구 달성공원로 35', '달성공원', '02-777-7778', 'N', 'N'),
-- 광주
('헬로 붕어빵', '광주 동구 충장로 90', '갤러리존 1층 현관', '02-777-7778', 'N', 'N'),
-- 대전
('대동 붕어빵', '대전 동구 동대전로110번길 182', '대동하늘공원 입구', '02-777-7778', 'N', 'N'),
-- 울산
('국정원 붕어빵', '울산 중구 태화강국가정원길 154', '태화강 국가정원', '02-777-7778', 'N', 'N'),
-- 세종
('세종 붕어빵', '세종 한누리대로 2130', '세종 시청', '02-777-7778', 'N', 'N'),
-- 경기
('화성 붕어빵', '경기 수원시 장안구 영화동 320-2', '수원화성', '02-777-7778', 'N', 'N'),
-- 강원
('남이섬 붕어빵', '강원 춘천시 남산면 남이섬길 1', '남이섬 입구', '02-777-7778', 'N', 'N'),
-- 충북
('청주랜드 붕어빵', '충북 청주시 상당구 명암로 224', '청주랜드 동물원 입구', '02-777-7778', 'N', 'N'),
-- 충남
('소노벨 붕어빵', '충남 천안시 동남구 성남면 종합휴양지로 200', '소노벨 천안 오션어드벤처 입구', '02-777-7778', 'N', 'N'),
-- 전북
('한옥마을 붕어빵', '전북 전주시 완산구 기린대로 99', '전주 한옥마을 입구', '02-777-7778', 'N', 'N'),
-- 전남
('슈퍼 붕어빵', '전남 목포시 해안로127번길 14-2', '연희네 슈퍼 앞', '02-777-7778', 'N', 'N'),
-- 경북
('스고이 붕어빵', '경북 포항시 남구 구룡포읍 호미로 277', '구룡포 일본인 가옥 거리 입구', '02-777-7778', 'N', 'N'),
-- 경남
('진해 붕어빵', '경남 창원시 진해구 명동로 62', '진해해양공원 입구', '02-777-7778', 'N', 'N'),
-- 제주 특별자치시
('제국 붕어빵', '제주 제주시 공항로 2', '제주국제공항', '02-777-7778', 'N', 'N');

-- BB_DECLARE
TRUNCATE table BB_DECLARE;
INSERT INTO BB_DECLARE (STORE_NUM, DECLARE_CONTENT)
values (7, '폐점 신고'),(7, '폐점 신고'),(7, '폐점 신고');

INSERT INTO bb_payment (MEMBER_NUM, PAYMENT_AMOUNT, PAYMENT_NAME, IMP_UUID)
VALUES (1, 10000, '10000 포인트 구매', 'e7a1c1bc-1c4e-4d84-8b95-9b2aaffffac0'),
       (1, 15000, '15000 포인트 구매', 'e0f25d5e-31bb-4f5d-a5e0-01c7fc3c7b20'),
       (1, 20000, '20000 포인트 구매', '3c8a31a1-ec45-4d41-b12f-e6a60c0c6c80'),
       (2, 25000, '25000 포인트 구매', 'bcb68c74-6a87-4b67-b51f-ecf69cc6e600'),
       (2, 30000, '30000 포인트 구매', '11d1c063-b46d-4937-91f1-5e5a3fdc9c6e'),
       (2, 35000, '35000 포인트 구매', '583abb30-5248-4db8-a5b1-80b69f7b3e5e'),
       (3, 40000, '40000 포인트 구매', '682da79c-50f4-4c64-b4b4-f7dc54f9a134'),
       (3, 45000, '45000 포인트 구매', 'e6f12b6c-bf46-4e5f-b5b8-cfd79ec9f4bb'),
       (4, 50000, '50000 포인트 구매', 'b3e3f12c-e9c1-47ee-b6af-e0b13eabcfb3'),
       (5, 55000, '55000 포인트 구매', 'd4ac2f54-fb3c-4f1e-9a8c-1b4f1cb74d00'),
       (6, 60000, '60000 포인트 구매', 'c8f50c02-86e1-4cde-88d5-8cdb22f3e47c'),
       (7, 65000, '65000 포인트 구매', '501eecc6-fec8-45a0-b3e0-efc1a0c7f3b6');


-- BB_POINT 샘플 데이터(충전, 상품 구매 TRIGGER)
      
-- BB_STORE_MENU 샘플 데이터
INSERT INTO bb_store_menu (STORE_NUM, STORE_MENU_NORMAL, STORE_MENU_VEG, STORE_MENU_MINI, STORE_MENU_POTATO,
                           STORE_MENU_ICE, STORE_MENU_CHEESE, STORE_MENU_PASTRY, STORE_MENU_OTHER)
VALUES (1, 'Y', 'Y', 'N', 'Y', 'Y', 'Y', 'N', 'N'),
       (2, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'Y', 'N'),
       (3, 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y'),
       (4, 'Y', 'Y', 'N', 'N', 'Y', 'Y', 'N', 'Y'),
       (5, 'Y', 'N', 'Y', 'Y', 'N', 'N', 'Y', 'N'),
       (6, 'Y', 'Y', 'Y', 'N', 'Y', 'Y', 'N', 'Y'),
       (7, 'Y', 'N', 'N', 'Y', 'Y', 'N', 'Y', 'N'),
       (8, 'Y', 'Y', 'Y', 'Y', 'N', 'Y', 'N', 'Y'),
       (9, 'Y', 'N', 'Y', 'N', 'Y', 'Y', 'Y', 'N'),
       (10, 'Y', 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'Y'),
       (11, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (12, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (13, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (14, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (15, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (16, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (17, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (18, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (19, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (20, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (21, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (22, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (23, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (24, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (25, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (26, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (27, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (28, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (29, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (30, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (31, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (33, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (34, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (35, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (36, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (37, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (38, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (39, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (40, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (41, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (42, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (43, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (44, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (45, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (46, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (47, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (48, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (49, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N'),
       (50, 'Y', 'N', 'Y', 'Y', 'N', 'Y', 'N', 'N');
       
-- BB_STORE_PAYMENT 샘플 데이터
INSERT INTO bb_store_payment (STORE_NUM, STORE_PAYMENT_CASHMONEY, STORE_PAYMENT_CARD, STORE_PAYMENT_ACCOUNT)
VALUES (1, 'Y', 'Y', 'N'),
       (2, 'Y', 'Y', 'Y'),
       (3, 'N', 'Y', 'Y'),
       (4, 'Y', 'Y', 'N'),
       (5, 'N', 'Y', 'Y'),
       (6, 'Y', 'Y', 'Y'),
       (7, 'Y', 'N', 'Y'),
       (8, 'N', 'Y', 'Y'),
       (9, 'Y', 'Y', 'N'),
       (10, 'Y', 'Y', 'Y'),
       (11, 'N', 'Y', 'Y'),
       (12, 'Y', 'Y', 'Y'),
       (13, 'Y', 'Y', 'Y'),
       (14, 'Y', 'Y', 'Y'),
       (15, 'Y', 'Y', 'Y'),
       (16, 'Y', 'Y', 'Y'),
       (17, 'Y', 'Y', 'Y'),
       (18, 'Y', 'Y', 'Y'),
       (19, 'Y', 'Y', 'Y'),
       (20, 'Y', 'Y', 'Y'),
       (22, 'Y', 'Y', 'Y'),
       (23, 'Y', 'Y', 'Y'),
       (24, 'Y', 'Y', 'Y'),
       (25, 'Y', 'Y', 'Y'),
       (26, 'Y', 'Y', 'Y'),
       (27, 'Y', 'Y', 'Y'),
       (28, 'Y', 'Y', 'Y'),
       (29, 'Y', 'Y', 'Y'),
       (31, 'Y', 'Y', 'Y'),
       (32, 'Y', 'Y', 'Y'),
       (33, 'Y', 'Y', 'Y'),
       (34, 'Y', 'Y', 'Y'),
       (35, 'Y', 'Y', 'Y'),
       (36, 'Y', 'Y', 'Y'),
       (37, 'Y', 'Y', 'Y'),
       (38, 'Y', 'Y', 'Y'),
       (39, 'Y', 'Y', 'Y'),
       (41, 'Y', 'Y', 'Y'),
       (42, 'Y', 'Y', 'Y'),
       (43, 'Y', 'Y', 'Y'),
       (44, 'Y', 'Y', 'Y'),
       (45, 'Y', 'Y', 'Y'),
       (46, 'Y', 'Y', 'Y'),
       (47, 'Y', 'Y', 'Y'),
       (48, 'Y', 'Y', 'Y'),
       (49, 'Y', 'Y', 'Y'),
       (50, 'Y', 'Y', 'Y');

-- BB_STORE_WORK 샘플 데이터
INSERT INTO bb_store_work (STORE_NUM, STORE_WORK_WEEK, STORE_WORK_OPEN, STORE_WORK_CLOSE)
VALUES (1, 'MON', '2024-10-29 09:00:00', '2024-10-29 18:00:00'),
       (1, 'TUE', '2024-10-29 09:00:00', '2024-10-29 18:00:00'),
       (1, 'WED', '2024-10-29 09:00:00', '2024-10-29 18:00:00'),
       (2, 'MON', '2024-10-29 10:00:00', '2024-10-29 19:00:00'),
       (2, 'TUE', '2024-10-29 10:00:00', '2024-10-29 19:00:00'),
       (2, 'WED', '2024-10-29 10:00:00', '2024-10-29 19:00:00'),
       (3, 'THU', '2024-10-29 11:00:00', '2024-10-29 20:00:00'),
       (3, 'FRI', '2024-10-29 11:00:00', '2024-10-29 20:00:00'),
       (3, 'SAT', '2024-10-29 11:00:00', '2024-10-29 20:00:00'),
       (4, 'MON', '2024-10-29 08:00:00', '2024-10-29 17:00:00'),
       (4, 'TUE', '2024-10-29 08:00:00', '2024-10-29 17:00:00'),
       (5, 'WED', '2024-10-29 09:30:00', '2024-10-29 18:30:00'),
       (5, 'THU', '2024-10-29 09:30:00', '2024-10-29 18:30:00'),
       (6, 'FRI', '2024-10-29 10:30:00', '2024-10-29 19:30:00'),
       (6, 'SAT', '2024-10-29 10:30:00', '2024-10-29 19:30:00'),
       (7, 'SUN', '2024-10-29 12:00:00', '2024-10-29 21:00:00'),
       (8, 'MON', '2024-10-29 11:30:00', '2024-10-29 20:30:00'),
       (9, 'TUE', '2024-10-29 10:00:00', '2024-10-29 19:00:00'),
       (10, 'WED', '2024-10-29 09:00:00', '2024-10-29 18:00:00'),
       (10, 'THU', '2024-10-29 09:00:00', '2024-10-29 18:00:00'),
       (11, 'FRI', '2024-10-29 10:00:00','2024-10-29 19:00:00'),
       (11, 'SAT', '2024-10-29 10:00:00','2024-10-29 19:00:00'),
       (12, 'SUN', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (13, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (14, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (15, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (16, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (17, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (18, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (19, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (20, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (21, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (22, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (23, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (24, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (25, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (26, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (27, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (28, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (29, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (30, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (31, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (32, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (33, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (34, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (35, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (36, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (37, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (38, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (39, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (40, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (41, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (42, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (43, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (44, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (45, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (46, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (47, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (48, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (49, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00'),
       (50, 'MON', '2024-10-29 11:00:00','2024-10-29 20:00:00');

-- 게시글 카테고리 데이터
INSERT INTO bb_board_category (BOARD_CATEGORY_NUM, BOARD_CATEGORY_NAME)
VALUES (1, 'noticeBoard'),
       (2, 'boardList');

-- BB_BOARD 샘플 데이터
TRUNCATE table BB_BOARD;
INSERT INTO bb_board (BOARD_TITLE, BOARD_CONTENT, BOARD_FOLDER, MEMBER_NUM, BOARD_OPEN, BOARD_DELETE, BOARD_CATEGORY_NUM)
VALUES ('맛있는 붕어빵 후기', '정말 맛있었어요! 특히 팥앙금이 일품이에요', '/uploads/review1', 9, 'Y', 'N', 2),
       ('붕어빵 맛집 발견', '여기 붕어빵이 최고예요. 크기도 크고 맛도 좋아요', '/uploads/review2', 10, 'Y', 'N', 2),
       ('신메뉴 출시했습니다', '치즈붕어빵 새로 나왔어요. 많이 찾아주세요!', '/uploads/notice1', 3, 'Y', 'N', 2),
       ('역삼역 최고의 붕어빵', '퇴근길에 항상 들러서 먹고 있어요', '/uploads/review3', 11, 'Y', 'N', 2),
       ('가격 인상 안내', '원재료 가격 상승으로 인한 가격 인상 안내드립니다', '/uploads/notice2', 4, 'Y', 'N', 1),
       ('크림붕어빵 맛집', '크림붕어빵 여기가 진짜예요!', '/uploads/review4', 12, 'Y', 'N', 1),
       ('휴무 안내', '내일 임시 휴무입니다', '/uploads/notice3', 5, 'Y', 'N', 1),
       ('붕어빵 시식 이벤트', '오늘 5시부터 신메뉴 무료 시식회 있습니다', '/uploads/event1', 6, 'Y', 'N', 1),
       ('대박맛집 인증', '정말 맛있어서 재방문했어요', '/uploads/review5', 13, 'Y', 'N', 1),
       ('영업시간 변경 안내', '다음 주부터 영업시간이 변경됩니다', '/uploads/notice4', 7, 'Y', 'N', 2),
       ('붕어빵 최고!', '여기 붕어빵 강추합니다', '/uploads/review6', 14, 'Y', 'N', 2),
       ('이번주 할인 이벤트', '금주 전 메뉴 20% 할인합니다', '/uploads/event2', 8, 'Y', 'N', 2),
       ('맛있는 붕어빵 인증', '너무 맛있어서 후기 남깁니다', '/uploads/review7', 15, 'Y', 'N', 2),
       ('신메뉴 투표해주세요', '다음 신메뉴 설문조사 이벤트', '/uploads/event3', 3, 'Y', 'N', 2),
       ('직접 만든 팥앙금', '팥앙금을 직접 만들어서 더 맛있어요', '/uploads/review8', 16, 'Y', 'N', 1),
       ('가게 이전 안내', '다음달부터 이전된 장소에서 영업합니다', '/uploads/notice5', 4, 'Y', 'N', 1);

-- BB_LIKE 샘플 데이터
TRUNCATE table BB_LIKE
INSERT INTO bb_like (BOARD_NUM, MEMBER_NUM)
VALUES (1, 10),
       (1, 11),
       (1, 12),
       (2, 9),
       (2, 11),
       (2, 12),
       (3, 9),
       (3, 10),
       (3, 12),
       (4, 9),
       (4, 10),
       (4, 11),
       (5, 13),
       (5, 14),
       (5, 15),
       (6, 13),
       (6, 14),
       (6, 16),
       (7, 9),
       (7, 10),
       (8, 11),
       (8, 12),
       (9, 13),
       (9, 14);

-- BB_REPLY 샘플 데이터
TRUNCATE bb_reply 
INSERT INTO bb_reply (REPLY_CONTENT, MEMBER_NUM, BOARD_NUM)
VALUES ('저도 가보고 싶네요!', 10, 1),
       ('맛있어 보이네요~', 9, 2),
       ('기대됩니다!!', 11, 3),
       ('저도 자주 가는 곳이에요', 12, 4),
       ('가격이 올라도 맛있으면 괜찮아요', 13, 5),
       ('크림붕어빵 진짜 맛있어요', 14, 6),
       ('아쉽네요ㅠㅠ', 15, 7),
       ('시식회 꼭 가볼게요!', 16, 8),
       ('저도 동의합니다', 9, 9),
       ('영업시간 참고할게요', 10, 10),
       ('주말에 가보려구요', 11, 11),
       ('할인 소식 감사합니다', 12, 12),
       ('사진이 너무 맛있어보여요', 13, 13),
       ('투표 참여했습니다', 14, 14),
       ('팥앙금이 특히 맛있었어요', 15, 15),
       ('새로운 위치도 기대되네요', 16, 16),
       ('오늘 저녁에 가보려구요!', 9, 1),
       ('이번 주말에 꼭 가봐야겠어요', 10, 2),
       ('신메뉴 먹어보고 싶네요', 11, 3),
       ('역시 맛집이죠!!', 12, 4);

-- BB_ORDER 샘플 데이터
TRUNCATE BB_ORDER;
INSERT INTO BB_ORDER (MEMBER_NUM, ADMIN_CHECKED, ORDER_DATE, ORDER_ADDRESS) VALUES
(1, 'N', '2024-11-01 10:30:00', '서울 중구 을지로 281'),
(2, 'Y', '2024-11-02 14:20:00', '부산 해운대구 우동'),
(3, 'N', '2024-11-03 09:15:00', '부산 수영구 남천바다로 8 1층'),
(4, 'C', '2024-11-04 18:45:00', '대구 수성구 청호로 321 국립대구박물관'),
(5, 'Y', '2024-11-05 12:00:00', '대전 서구 탄방동 남선공원 종합체육관 관리사무실'),
(6, 'N', '2024-11-06 17:10:00', '광주 북구 우치로 677 광주패밀리랜드'),
(7, 'C', '2024-11-07 08:25:00', '경기 수원시 팔달구 정조로 825 화성행궁');

-- BB_ORDER_DETAIL 샘플 데이터
-- BB_ORDER_DETAIL 테이블에 샘플 데이터 삽입
TRUNCATE BB_ORDER_DETAIL;
INSERT INTO BB_ORDER_DETAIL (PRODUCT_NUM, ORDER_QUANTITY, ORDER_NUM) VALUES
(1, 2, 1),
(2, 1, 1),
(3, 3, 2),
(4, 1, 2),
(1, 5, 3),
(5, 2, 3),
(6, 1, 4),
(7, 4, 4),
(2, 3, 5),
(3, 2, 5),
(8, 1, 6),
(1, 2, 6),
(4, 3, 7),
(9, 1, 7);
-- PRODUCT_NUM과 ORDER_NUM 조합의 UNIQUE 고려해서, 샘플데이터 삽입




