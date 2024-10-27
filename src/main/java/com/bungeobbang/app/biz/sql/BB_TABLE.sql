
-- fishshapedbread.bb_product_category definition

CREATE TABLE `bb_product_category` (
  `PRODUCT_CATEGORY_NUM` int NOT NULL AUTO_INCREMENT,
  `PRODUCT_CATEGORY_NAME` varchar(30) NOT NULL,
  PRIMARY KEY (`PRODUCT_CATEGORY_NUM`),
  UNIQUE KEY `PRODUCT_CATEGORY_NAME` (`PRODUCT_CATEGORY_NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- fishshapedbread.bb_product definition

CREATE TABLE `bb_product` (
  `PRODUCT_NUM` int NOT NULL AUTO_INCREMENT,
  `PRODUCT_NAME` varchar(100) NOT NULL,
  `PRODUCT_PRICE` int NOT NULL,
  `PRODUCT_PROFILE_WAY` varchar(500) NOT NULL,
  `PRODUCT_CATEGORY_NUM` int DEFAULT NULL,
  PRIMARY KEY (`PRODUCT_NUM`),
  KEY `PRODUCT_CATEGORY_NUM` (`PRODUCT_CATEGORY_NUM`),
  CONSTRAINT `bb_product_ibfk_2` FOREIGN KEY (`PRODUCT_CATEGORY_NUM`) REFERENCES `bb_product_category` (`PRODUCT_CATEGORY_NUM`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- fishshapedbread.bb_member definition

CREATE TABLE `bb_member` (
  `MEMBER_NUM` int NOT NULL AUTO_INCREMENT,
  `MEMBER_EMAIL` varchar(200) NOT NULL,
  `MEMBER_PASSWORD` varchar(100) NOT NULL,
  `MEMBER_NAME` varchar(30) NOT NULL,
  `MEMBER_NICKNAME` varchar(50) NOT NULL,
  `MEMBER_PHONE` varchar(20) DEFAULT NULL,
  `MEMBER_PROFILE_WAY` varchar(500) DEFAULT NULL,
  `MEMBER_ROLE` varchar(30) DEFAULT 'USER',
  `MEMBER_HIREDAY` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MEMBER_NUM`),
  UNIQUE KEY `MEMBER_EMAIL` (`MEMBER_EMAIL`),
  UNIQUE KEY `MEMBER_NICKNAME` (`MEMBER_NICKNAME`),
  CONSTRAINT `bb_member_chk_1` CHECK ((`MEMBER_ROLE` in (_utf8mb4'USER',_utf8mb4'ADMIN',_utf8mb4'ONER')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- fishshapedbread.bb_store definition

CREATE TABLE `bb_store` (
  `STORE_NUM` int NOT NULL AUTO_INCREMENT,
  `STORE_NAME` varchar(100) NOT NULL,
  `STORE_ADDRESS` varchar(500) NOT NULL,
  `STORE_ADDRESS_DETAIL` varchar(100) NOT NULL,
  `STORE_CONTACT` varchar(20) DEFAULT NULL,
  `STORE_CLOSED` char(1) DEFAULT 'N',
  `STORE_SECRET` char(1) DEFAULT 'N',
  PRIMARY KEY (`STORE_NUM`),
  CONSTRAINT `bb_store_chk_1` CHECK ((`STORE_CLOSED` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_chk_2` CHECK ((`STORE_SECRET` in (_utf8mb4'Y',_utf8mb4'N')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_declare definition

CREATE TABLE `bb_declare` (
  `DECLARE_NUM` int NOT NULL AUTO_INCREMENT,
  `STORE_NUM` int DEFAULT NULL,
  `DECLARE_CONTENT` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`DECLARE_NUM`),
  KEY `STORE_NUM` (`STORE_NUM`),
  CONSTRAINT `bb_declare_ibfk_2` FOREIGN KEY (`STORE_NUM`) REFERENCES `bb_store` (`STORE_NUM`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_payment definition

CREATE TABLE `bb_payment` (
  `PAYMENT_NUM` int NOT NULL AUTO_INCREMENT,
  `MEMBER_NUM` int DEFAULT NULL,
  `PAYMENT_AMOUNT` int DEFAULT NULL,
  PRIMARY KEY (`PAYMENT_NUM`),
  KEY `MEMBER_NUM` (`MEMBER_NUM`),
  CONSTRAINT `bb_payment_ibfk_1` FOREIGN KEY (`MEMBER_NUM`) REFERENCES `bb_member` (`MEMBER_NUM`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_point definition

CREATE TABLE `bb_point` (
  `POINT_NUM` int NOT NULL AUTO_INCREMENT,
  `MEMBER_NUM` int DEFAULT NULL,
  `POINT_PLUS` int DEFAULT NULL,
  `POINT_MINUS` int DEFAULT NULL,
  `POINT_CONTENT` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`POINT_NUM`),
  KEY `MEMBER_NUM` (`MEMBER_NUM`),
  CONSTRAINT `bb_point_ibfk_1` FOREIGN KEY (`MEMBER_NUM`) REFERENCES `bb_member` (`MEMBER_NUM`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_store_menu definition

CREATE TABLE `bb_store_menu` (
  `STORE_MENU_NUM` int NOT NULL AUTO_INCREMENT,
  `STORE_NUM` int NOT NULL,
  `STORE_MENU_NORMAL` varchar(1) DEFAULT 'N',
  `STORE_MENU_VEG` char(1) DEFAULT 'N',
  `STORE_MENU_MINI` char(1) DEFAULT 'N',
  `STORE_MENU_POTATO` char(1) DEFAULT 'N',
  `STORE_MENU_ICE` char(1) DEFAULT 'N',
  `STORE_MENU_CHEESE` char(1) DEFAULT 'N',
  `STORE_MENU_PASTRY` char(1) DEFAULT 'N',
  `STORE_MENU_OTHER` char(1) DEFAULT 'N',
  PRIMARY KEY (`STORE_MENU_NUM`),
  UNIQUE KEY `STORE_NUM` (`STORE_NUM`),
  CONSTRAINT `bb_store_menu_ibfk_1` FOREIGN KEY (`STORE_NUM`) REFERENCES `bb_store` (`STORE_NUM`) ON DELETE CASCADE,
  CONSTRAINT `bb_store_menu_chk_2` CHECK ((`STORE_MENU_VEG` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_menu_chk_3` CHECK ((`STORE_MENU_MINI` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_menu_chk_4` CHECK ((`STORE_MENU_POTATO` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_menu_chk_5` CHECK ((`STORE_MENU_ICE` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_menu_chk_6` CHECK ((`STORE_MENU_CHEESE` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_menu_chk_7` CHECK ((`STORE_MENU_PASTRY` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_menu_chk_8` CHECK ((`STORE_MENU_OTHER` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `check_store_menu_normal` CHECK ((`STORE_MENU_NORMAL` in (_utf8mb4'Y',_utf8mb4'N')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_store_payment definition

CREATE TABLE `bb_store_payment` (
  `STORE_PAYMENT_NUM` int NOT NULL AUTO_INCREMENT,
  `STORE_NUM` int NOT NULL,
  `STORE_PAYMENT_CASHMONEY` char(1) DEFAULT 'N',
  `STORE_PAYMENT_CARD` char(1) DEFAULT 'N',
  `STORE_PAYMENT_ACCOUNT` char(1) DEFAULT 'N',
  PRIMARY KEY (`STORE_PAYMENT_NUM`),
  UNIQUE KEY `STORE_NUM` (`STORE_NUM`),
  CONSTRAINT `bb_store_payment_ibfk_1` FOREIGN KEY (`STORE_NUM`) REFERENCES `bb_store` (`STORE_NUM`) ON DELETE CASCADE,
  CONSTRAINT `bb_store_payment_chk_1` CHECK ((`STORE_PAYMENT_CASHMONEY` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_payment_chk_2` CHECK ((`STORE_PAYMENT_CARD` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_store_payment_chk_3` CHECK ((`STORE_PAYMENT_ACCOUNT` in (_utf8mb4'Y',_utf8mb4'N')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_store_work definition

CREATE TABLE `bb_store_work` (
  `WORK_NUM` int NOT NULL AUTO_INCREMENT,
  `STORE_NUM` int NOT NULL,
  `STORE_WORK_WEEK` char(3) NOT NULL,
  `STORE_WORK_OPEN` datetime NOT NULL,
  `STORE_WORK_CLOSE` datetime NOT NULL,
  PRIMARY KEY (`WORK_NUM`),
  UNIQUE KEY `STORE_NUM` (`STORE_NUM`),
  CONSTRAINT `bb_store_work_ibfk_1` FOREIGN KEY (`STORE_NUM`) REFERENCES `bb_store` (`STORE_NUM`) ON DELETE CASCADE,
  CONSTRAINT `bb_store_work_chk_1` CHECK ((`STORE_WORK_WEEK` in (_utf8mb4'MON',_utf8mb4'TUE',_utf8mb4'WED',_utf8mb4'THU',_utf8mb4'FRI',_utf8mb4'SAT',_utf8mb4'SUN')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_board_category definition

CREATE TABLE `bb_board_category` (
  `BOARD_CATEGORY_NUM` int NOT NULL AUTO_INCREMENT,
  `BOARD_CATEGORY_NAME` varchar(30) NOT NULL,
  PRIMARY KEY (`BOARD_CATEGORY_NUM`),
  UNIQUE KEY `BOARD_CATEGORY_NAME` (`BOARD_CATEGORY_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- fishshapedbread.bb_board definition

CREATE TABLE `bb_board` (
  `BOARD_NUM` int NOT NULL AUTO_INCREMENT,
  `BOARD_TITLE` varchar(500) NOT NULL,
  `BOARD_CONTENT` varchar(1000) DEFAULT NULL,
  `BOARD_FOLDER` varchar(1000) DEFAULT NULL,
  `MEMBER_NUM` int DEFAULT NULL,
  `BOARD_WRITE_DAY` datetime DEFAULT CURRENT_TIMESTAMP,
  `BOARD_OPEN` char(1) DEFAULT 'N',
  `BOARD_CATEGORY_NUM` int DEFAULT NULL,
  `STORE_NUM` int DEFAULT NULL,
  `PRODUCT_NUM` int DEFAULT NULL,
  `BOARD_DELETE` char(1) DEFAULT 'N',
  PRIMARY KEY (`BOARD_NUM`),
  KEY `MEMBER_NUM` (`MEMBER_NUM`),
  KEY `BOARD_CATEGORY_NUM` (`BOARD_CATEGORY_NUM`),
  KEY `STORE_NUM` (`STORE_NUM`),
  KEY `bb_board_ibfk_4` (`PRODUCT_NUM`),
  CONSTRAINT `bb_board_ibfk_1` FOREIGN KEY (`MEMBER_NUM`) REFERENCES `bb_member` (`MEMBER_NUM`) ON DELETE SET NULL,
  CONSTRAINT `bb_board_ibfk_2` FOREIGN KEY (`BOARD_CATEGORY_NUM`) REFERENCES `bb_board_category` (`BOARD_CATEGORY_NUM`) ON DELETE CASCADE,
  CONSTRAINT `bb_board_ibfk_3` FOREIGN KEY (`STORE_NUM`) REFERENCES `bb_store` (`STORE_NUM`) ON DELETE CASCADE,
  CONSTRAINT `bb_board_ibfk_4` FOREIGN KEY (`PRODUCT_NUM`) REFERENCES `bb_product` (`PRODUCT_NUM`) ON DELETE CASCADE,
  CONSTRAINT `bb_board_chk_1` CHECK ((`BOARD_OPEN` in (_utf8mb4'Y',_utf8mb4'N'))),
  CONSTRAINT `bb_board_chk_2` CHECK ((`BOARD_DELETE` in (_utf8mb4'Y',_utf8mb4'N')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_like definition

CREATE TABLE `bb_like` (
  `LIKE_NUM` int NOT NULL AUTO_INCREMENT,
  `BOARD_NUM` int NOT NULL,
  `MEMBER_NUM` int DEFAULT NULL,
  PRIMARY KEY (`LIKE_NUM`),
  KEY `BOARD_NUM` (`BOARD_NUM`),
  KEY `MEMBER_NUM` (`MEMBER_NUM`),
  CONSTRAINT `bb_like_ibfk_1` FOREIGN KEY (`BOARD_NUM`) REFERENCES `bb_board` (`BOARD_NUM`) ON DELETE CASCADE,
  CONSTRAINT `bb_like_ibfk_2` FOREIGN KEY (`MEMBER_NUM`) REFERENCES `bb_member` (`MEMBER_NUM`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_order definition

CREATE TABLE `bb_order` (
  `ORDER_NUM` int NOT NULL AUTO_INCREMENT,
  `MEMBER_NUM` int DEFAULT NULL,
  `PRODUCT_NUM` int DEFAULT NULL,
  `ORDER_STATUS` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ORDER_NUM`),
  KEY `MEMBER_NUM` (`MEMBER_NUM`),
  KEY `PRODUCT_NUM` (`PRODUCT_NUM`),
  CONSTRAINT `bb_order_ibfk_1` FOREIGN KEY (`MEMBER_NUM`) REFERENCES `bb_member` (`MEMBER_NUM`) ON DELETE SET NULL,
  CONSTRAINT `bb_order_ibfk_2` FOREIGN KEY (`PRODUCT_NUM`) REFERENCES `bb_product` (`PRODUCT_NUM`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- fishshapedbread.bb_reply definition

CREATE TABLE `bb_reply` (
  `REPLY_NUM` int NOT NULL AUTO_INCREMENT,
  `REPLY_CONTENT` varchar(500) NOT NULL,
  `MEMBER_NUM` int DEFAULT NULL,
  `REPLY_WRITE_DAY` datetime DEFAULT CURRENT_TIMESTAMP,
  `BOARD_NUM` int DEFAULT NULL,
  PRIMARY KEY (`REPLY_NUM`),
  KEY `MEMBER_NUM` (`MEMBER_NUM`),
  KEY `BOARD_NUM` (`BOARD_NUM`),
  CONSTRAINT `bb_reply_ibfk_1` FOREIGN KEY (`MEMBER_NUM`) REFERENCES `bb_member` (`MEMBER_NUM`) ON DELETE SET NULL,
  CONSTRAINT `bb_reply_ibfk_2` FOREIGN KEY (`BOARD_NUM`) REFERENCES `bb_board` (`BOARD_NUM`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- fishshapedbread.bb_view_board_join source

create or replace
algorithm = UNDEFINED view `fishshapedbread`.`bb_view_board_join` as
select
    `bb`.`BOARD_NUM` as `BOARD_NUM`,
    `bb`.`BOARD_TITLE` as `BOARD_TITLE`,
    `bb`.`BOARD_CONTENT` as `BOARD_CONTENT`,
    `bb`.`BOARD_WRITE_DAY` as `BOARD_WRITE_DAY`,
    `bb`.`BOARD_OPEN` as `BOARD_OPEN`,
    `bb`.`BOARD_DELETE` as `BOARD_DELETE`,
    `bm`.`MEMBER_NUM` as `MEMBER_NUM`,
    `bm`.`MEMBER_NICKNAME` as `MEMBER_NICKNAME`,
    ifnull(`bl2`.`LIKE_CNT`, 0) as `LIKE_CNT`,
    `bbc`.`BOARD_CATEGORY_NUM` as `BOARD_CATEGORY_NUM`,
    `bbc`.`BOARD_CATEGORY_NAME` as `BOARD_CATEGORY_NAME`
from
    (((`fishshapedbread`.`bb_board` `bb`
left join `fishshapedbread`.`bb_member` `bm` on
    ((`bb`.`MEMBER_NUM` = `bm`.`MEMBER_NUM`)))
left join (
    select
        `fishshapedbread`.`bb_like`.`BOARD_NUM` as `BOARD_NUM`,
        count(0) as `LIKE_CNT`
    from
        `fishshapedbread`.`bb_like`
    group by
        `fishshapedbread`.`bb_like`.`BOARD_NUM`) `bl2` on
    ((`bb`.`BOARD_NUM` = `bl2`.`BOARD_NUM`)))
left join `fishshapedbread`.`bb_board_category` `bbc` on
    ((`bb`.`BOARD_CATEGORY_NUM` = `bbc`.`BOARD_CATEGORY_NUM`)));


-- fishshapedbread.bb_view_product_join source

create or replace
algorithm = UNDEFINED view `fishshapedbread`.`bb_view_product_join` as
select
    `bp`.`PRODUCT_NUM` as `PRODUCT_NUM`,
    `bp`.`PRODUCT_NAME` as `PRODUCT_NAME`,
    `bp`.`PRODUCT_PRICE` as `PRODUCT_PRICE`,
    `bp`.`PRODUCT_PROFILE_WAY` as `PRODUCT_PROFILE_WAY`,
    `bb`.`BOARD_NUM` as `BOARD_NUM`,
    `bp`.`PRODUCT_CATEGORY_NUM` as `PRODUCT_CATEGORY_NUM`,
    `bpc`.`PRODUCT_CATEGORY_NAME` as `PRODUCT_CATEGORY_NAME`,
    `bb`.`BOARD_TITLE` as `BOARD_TITLE`,
    `bb`.`BOARD_CONTENT` as `BOARD_CONTENT`
from
    ((`fishshapedbread`.`bb_product` `bp`
join `fishshapedbread`.`bb_product_category` `bpc` on
    ((`bp`.`PRODUCT_CATEGORY_NUM` = `bpc`.`PRODUCT_CATEGORY_NUM`)))
left join `fishshapedbread`.`bb_board` `bb` on
    ((`bp`.`PRODUCT_NUM` = `bb`.`PRODUCT_NUM`)));


-- fishshapedbread.bb_view_store_join source

create or replace
algorithm = UNDEFINED view `fishshapedbread`.`bb_view_store_join` as
select
    `s`.`STORE_NUM` as `STORE_NUM`,
    `s`.`STORE_NAME` as `STORE_NAME`,
    `s`.`STORE_ADDRESS` as `STORE_ADDRESS`,
    `s`.`STORE_ADDRESS_DETAIL` as `STORE_ADDRESS_DETAIL`,
    `s`.`STORE_CONTACT` as `STORE_CONTACT`,
    `s`.`STORE_CLOSED` as `STORE_CLOSED`,
    `s`.`STORE_SECRET` as `STORE_SECRET`,
    `sm`.`STORE_MENU_NORMAL` as `STORE_MENU_NORMAL`,
    `sm`.`STORE_MENU_VEG` as `STORE_MENU_VEG`,
    `sm`.`STORE_MENU_MINI` as `STORE_MENU_MINI`,
    `sm`.`STORE_MENU_POTATO` as `STORE_MENU_POTATO`,
    `sm`.`STORE_MENU_ICE` as `STORE_MENU_ICE`,
    `sm`.`STORE_MENU_CHEESE` as `STORE_MENU_CHEESE`,
    `sm`.`STORE_MENU_PASTRY` as `STORE_MENU_PASTRY`,
    `sm`.`STORE_MENU_OTHER` as `STORE_MENU_OTHER`,
    `sp`.`STORE_PAYMENT_CASHMONEY` as `STORE_PAYMENT_CASHMONEY`,
    `sp`.`STORE_PAYMENT_CARD` as `STORE_PAYMENT_CARD`,
    `sp`.`STORE_PAYMENT_ACCOUNT` as `STORE_PAYMENT_ACCOUNT`,
    `sw`.`STORE_WORK_WEEK` as `STORE_WORK_WEEK`,
    `sw`.`STORE_WORK_OPEN` as `STORE_WORK_OPEN`,
    `sw`.`STORE_WORK_CLOSE` as `STORE_WORK_CLOSE`,
    (case
        when ((
        select
            count(0)
        from
            `fishshapedbread`.`bb_declare`
        where
            (`fishshapedbread`.`bb_declare`.`STORE_NUM` = `s`.`STORE_NUM`)) > 0) then 'Y'
        else 'N'
    end) as `STORE_DECLARED`
from
    ((((`fishshapedbread`.`bb_store` `s`
join `fishshapedbread`.`bb_store_menu` `sm` on
    ((`s`.`STORE_NUM` = `sm`.`STORE_NUM`)))
join `fishshapedbread`.`bb_store_payment` `sp` on
    ((`s`.`STORE_NUM` = `sp`.`STORE_NUM`)))
join `fishshapedbread`.`bb_store_work` `sw` on
    ((`s`.`STORE_NUM` = `sw`.`STORE_NUM`)))
join `fishshapedbread`.`bb_declare` `d` on
    ((`s`.`STORE_NUM` = `d`.`STORE_NUM`)));