/*
 Navicat Premium Data Transfer

 Source Server         : library
 Source Server Type    : MySQL
 Source Server Version : 80100
 Source Host           : localhost:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 80100
 File Encoding         : 65001

 Date: 21/07/2023 20:02:03
*/

CREATE DATABASE BOOKS_MANAGEMENT;
USE BOOKS_MANAGEMENT;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `A_ID` varchar(15) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `A_NAME` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci UNIQUE NOT NULL,
  `A_PASSWORD` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  PRIMARY KEY (`A_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf16 COLLATE = utf16_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `U_ID` varchar(14) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `U_NAME` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci UNIQUE NOT NULL,
  `U_GENDER` varchar(2) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `U_PHONE` varchar(11) CHARACTER SET utf16 COLLATE utf16_general_ci NULL DEFAULT NULL,
  `U_EMAIL` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci NULL DEFAULT NULL,
  `U_PASSWORD` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  PRIMARY KEY (`U_ID`) USING BTREE,
  CONSTRAINT `CHECK_U_GENDER` CHECK (`U_GENDER` in (_utf8mb4'女',_utf8mb4'男'))
) ENGINE = InnoDB CHARACTER SET = utf16 COLLATE = utf16_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for bookshelf
-- ----------------------------
DROP TABLE IF EXISTS `bookshelf`;
CREATE TABLE `bookshelf`  (
  `BS_ID` varchar(12) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `BS_BOOKCATEGORY` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`BS_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf16 COLLATE = utf16_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `B_ID` varchar(12) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `B_NAME` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `B_AUTHOR` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `B_PRESS` varchar(30) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL COMMENT '出版社',
  `B_PUB_YEAR` int NULL DEFAULT NULL,
  `B_TOTAL_COLLECTION` int NULL DEFAULT NULL,
  `B_CUR_COLLECTION` int NULL DEFAULT NULL,
  `B_BS_ID` varchar(12) CHARACTER SET utf16 COLLATE utf16_general_ci NULL DEFAULT NULL,
  `B_ISBN` varchar(13) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `B_PRICE` decimal(6, 2) NULL DEFAULT NULL,
  `B_DESCRIPTION` varchar(1024) CHARACTER SET utf16 COLLATE utf16_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`B_ID`) USING BTREE,
  INDEX `FK_BOOK_BOOKSHELF_B_BS_ID`(`B_BS_ID` ASC) USING BTREE,
  CONSTRAINT `FK_BOOK_BOOKSHELF_B_BS_ID` FOREIGN KEY (`B_BS_ID`) REFERENCES `bookshelf` (`BS_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `CHECK_B_CUR_COLLECTION` CHECK ((`B_CUR_COLLECTION` >= 0) and (`B_CUR_COLLECTION` <= `B_TOTAL_COLLECTION`)),
  CONSTRAINT `CHECK_B_PRICE` CHECK (`B_PRICE` >= 0),
  CONSTRAINT `CHECK_B_TOTAL_COLLECTION` CHECK (`B_TOTAL_COLLECTION` >= 0)
) ENGINE = InnoDB CHARACTER SET = utf16 COLLATE = utf16_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for borrow_record
-- ----------------------------
DROP TABLE IF EXISTS `borrow_record`;
CREATE TABLE `borrow_record`  (
  `BR_U_ID` varchar(14) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `BR_B_ID` varchar(12) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL,
  `BR_BORROW_DATE` date NOT NULL,
  `BR_EXPECT_RETURN_DATE` date NOT NULL,
  `BR_RETURN_DATE` date NULL DEFAULT NULL,
  INDEX `FK_BR_BOOK_BID`(`BR_B_ID` ASC) USING BTREE,
  INDEX `FK_BR_USER_UID`(`BR_U_ID` ASC) USING BTREE,
  CONSTRAINT `FK_BR_BOOK_BID` FOREIGN KEY (`BR_B_ID`) REFERENCES `book` (`B_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_BR_USER_UID` FOREIGN KEY (`BR_U_ID`) REFERENCES `user` (`U_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf16 COLLATE = utf16_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Triggers structure for table borrow_record
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_borrow`;
delimiter ;;
CREATE TRIGGER `trigger_borrow` AFTER INSERT ON `borrow_record` FOR EACH ROW BEGIN
		update book set book.B_CUR_COLLECTION=book.B_CUR_COLLECTION-1 where NEW.BR_B_ID=book.B_ID;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table borrow_record
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_return`;
delimiter ;;
CREATE TRIGGER `trigger_return` AFTER UPDATE ON `borrow_record` FOR EACH ROW BEGIN	
	IF NEW.BR_RETURN_DATE IS NOT NULL AND OLD.BR_RETURN_DATE IS NULL THEN
		update book set book.B_CUR_COLLECTION=book.B_CUR_COLLECTION+1 where NEW.BR_B_ID=book.B_ID;
	END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;


-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('Admin001', 'xmu1', '123123');
INSERT INTO `admin` VALUES ('Admin002', 'xmu2', '123123');
INSERT INTO `admin` VALUES ('Admin003', 'xmu3', '123123');

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('U101', 'stu1', '男', '13333333333', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U102', 'stu2', '女', '13444444444', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U103', 'stu3', '男', '13555555555', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U104', 'stu1', '男', '13333333333', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U105', 'stu2', '女', '13444444444', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U106', 'stu3', '男', '13555555555', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U107', 'stu1', '男', '13333333333', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U108', 'stu2', '女', '13444444444', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U109', 'stu3', '男', '13555555555', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U110', 'stu1', '男', '13333333333', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U111', 'stu2', '女', '13444444444', '123456789@qq.com', '123123');
INSERT INTO `user` VALUES ('U112', 'stu3', '男', '13555555555', '123456789@qq.com', '123123');

-- ----------------------------
-- Records of bookshelf
-- ----------------------------
INSERT INTO `bookshelf` VALUES ('1', '小说');
INSERT INTO `bookshelf` VALUES ('2', '科幻');

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('B1001', 'A', 'XX', 'XX', 2000, 10, 10, '1', '11111', 999.00, 'empty..');
INSERT INTO `book` VALUES ('B1002', 'B', 'XX', 'XX', 2000, 10, 10, '1', '11112', 999.00, 'empty..');
INSERT INTO `book` VALUES ('B1003', 'C', 'XX', 'XX', 2000, 10, 10, '1', '11113', 999.00, 'empty..');
INSERT INTO `book` VALUES ('B1004', 'D', 'XX', 'XX', 2000, 10, 10, '2', '11114', 999.00, 'empty..');

-- ----------------------------
-- Test Use Only
-- ----------------------------

-- select * from admin;
-- select * from bookshelf;
-- select * from user;

-- select * from book;
-- select * from borrow_record;

-- -- state 1
-- -- 借书 B1001
-- insert into borrow_record values("U101", "B1001", curdate(), DATE_ADD(curdate(), interval 7 day), null);
-- insert into borrow_record values("U103", "B1001", curdate(), DATE_ADD(curdate(), interval 7 day), null);
-- -- state 2
-- -- 还书 B1001
-- update borrow_record set br_return_date=curdate() where br_u_id='U101' and br_b_id='B1001' and BR_RETURN_DATE is null;
-- -- state 3
-- -- 续借 B1001
-- update borrow_record set br_expect_return_date=DATE_ADD(BR_EXPECT_RETURN_DATE, interval 3 day) where br_u_id='U103' and br_b_id='B1001' and BR_RETURN_DATE is null;

