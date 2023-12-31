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

INSERT INTO `admin` (A_ID, A_NAME, A_PASSWORD) VALUES ('A001', '张老师', '123456');
INSERT INTO `admin` (A_ID, A_NAME, A_PASSWORD) VALUES ('A002', '李老师', '123456');
INSERT INTO `admin` (A_ID, A_NAME, A_PASSWORD) VALUES ('A003', '王老师', '123456');

INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0001', '张伟', '男', '13000000000', 'student1@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0002', '李明', '男', '13000000001', 'student2@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0003', '李英', '女', '13000000002', 'student3@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0004', '王丽', '女', '13000000003', 'student4@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0005', '张涛', '男', '13000000004', 'student5@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0006', '李勇', '男', '13000000005', 'student6@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0007', '刘芳', '女', '13000000006', 'student7@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0008', '王刚', '男', '13000000007', 'student8@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0009', '陈诚', '男', '13000000008', 'student9@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0010', '刘飞', '男', '13000000009', 'student10@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0011', '张建军', '男', '13000000010', 'student11@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0012', '李国庆', '男', '13000000011', 'student12@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0013', '韩梅梅', '女', '13000000012', 'student13@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0014', '马冬梅', '女', '13000000013', 'student14@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0015', '李亮', '男', '13000000014', 'student15@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0016', '张怡', '女', '13000000015', 'student16@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0017', '王瑞', '男', '13000000016', 'student17@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0018', '陈晓', '女', '13000000017', 'student18@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0019', '李一诺', '女', '13000000018', 'student19@xmu.edu.cn', '123456');
INSERT INTO user (U_ID, U_NAME, U_GENDER, U_PHONE, U_EMAIL, U_PASSWORD) VALUES ('U0020', '张建国', '男', '13000000019', 'student20@xmu.edu.cn', '123456');

INSERT INTO bookshelf (BS_ID, BS_BOOKCATEGORY) VALUES ('BS1', '长篇小说');
INSERT INTO bookshelf (BS_ID, BS_BOOKCATEGORY) VALUES ('BS2', '外国文学');
INSERT INTO bookshelf (BS_ID, BS_BOOKCATEGORY) VALUES ('BS3', '经典名著');
INSERT INTO bookshelf (BS_ID, BS_BOOKCATEGORY) VALUES ('BS4', '科幻小说');
INSERT INTO bookshelf (BS_ID, BS_BOOKCATEGORY) VALUES ('BS5', '散文集');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00001', '红楼梦', '曹雪芹', '人民文学出版社', 1992, 15, 15, 'BS3', '9787020002207', 59.7, '《红楼梦》是一部百科全书式的长篇小说。以宝黛爱情悲剧为主线，以四大家族的荣辱兴衰为背景，描绘出18世纪中国封建社会的方方面面，以及封建专制下新兴资本主义民主思想的萌动。结构宏大、情节委婉、细节精致，人物形象栩栩如生，声口毕现，堪称中国古代小说中的经典。\r\n由红楼梦研究所校注、人民文学出版社出版的《红楼梦》以庚辰（1760）本《脂砚斋重评石头记》为底本，以甲戌（1754）本、已卯（1759）本、蒙古王府本、戚蓼生序本、舒元炜序本、郑振铎藏本、红楼梦稿本、列宁格勒藏本（俄藏本）、程甲本、程乙本等众多版本为参校本，是一个博采众长、非常适合大众阅读的本子；同时，对底本的重要修改，皆出校记，读者可因以了解《红楼梦》的不同版本状况。\r\n红学所的校注本已印行二十五年，其间1994年曾做过一次修订，又十几年过去，2008年推出修订第三版，体现了新的校注成果和科研成果。\r\n关于《红楼梦》的作者，原本就有多种说法及推想，“前八十回曹雪芹著、后四十回高鹗续”的说法只是其中之一，这次修订中校注者改为“前八十回曹雪芹著；后四十回无名氏续，程伟元、高鹗整理”，应当是一种更科学的表述，体现了校注者对这一问题的新的认识。现在这个修订后的《红楼梦》是更加完善。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00002', '活着', '余华', '作家出版社', 2012, 10, 10, 'BS1', '9787506365437', 20, '《活着(新版)》讲述了农村人福贵悲惨的人生遭遇。福贵本是个阔少爷，可他嗜赌如命，终于赌光了家业，一贫如洗。他的父亲被他活活气死，母亲则在穷困中患了重病，福贵前去求药，却在途中被国民党抓去当壮丁。经过几番波折回到家里，才知道母亲早已去世，妻子家珍含辛茹苦地养大两个儿女。此后更加悲惨的命运一次又一次降临到福贵身上，他的妻子、儿女和孙子相继死去，最后只剩福贵和一头老牛相依为命，但老人依旧活着，仿佛比往日更加洒脱与坚强。《活着(新版)》荣获意大利格林扎纳•卡佛文学奖最高奖项（1998年）、台湾《中国时报》10本好书奖（1994年）、香港“博益”15本好书奖（1994年）、第三届世界华文“冰心文学奖”（2002年），入选香港《亚洲周刊》评选的“20世纪中文小说百年百强”、中国百位批评家和文学编辑评选的“20世纪90年代最有影响的10部作品”。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00003', '百年孤独', '加西亚·马尔克斯', '南海出版公司', 2011, 10, 10, 'BS2', '9787544253994', 39.5, '《百年孤独》是魔幻现实主义文学的代表作，描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪最重要的经典文学巨著之一。1982年加西亚•马尔克斯获得诺贝尔文学奖，奠定世界级文学大师的地位，很大程度上乃是凭借《百年孤独》的巨大影响。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00004', '三体全集', '刘慈欣', '重庆出版社', 2012, 10, 10, 'BS4', '9787229042066', 168, '三体三部曲 (《三体》《三体Ⅱ·黑暗森林》《三体Ⅲ·死神永生》) ，原名“地球往事三部曲”，是中国著名科幻作家刘慈欣的首个长篇系列，由科幻世界杂志社策划制作，重庆出版集团出版。小说讲述了文革期间一次偶然的星际通讯引发的三体世界对地球的入侵以及之后人类文明与三体文明三百多年的恩怨情仇。三体三部曲出版后十分畅销，并深受读者和主流媒体好评，被普遍认为是中国科幻文学的里程碑之作，为中国科幻确立了一个新高度。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00005', '三国演义', '罗贯中', '人民文学出版社', 1998, 15, 15, 'BS3', '9787020008728', 39.5, '《三国演义》又名《三国志演义》、《三国志通俗演义》，是我国小说史上最著名最杰出的长篇章回体历史小说。 《三国演义》的作者是元末明初人罗贯中，由毛纶，毛宗岗父子批改。在其成书前，“三国故事”已经历了数百年的历史发展过程。在唐代，三国故事已广为流传，连儿童都很熟悉。随着市民文艺的发展，宋代的“说话”艺人，已有专门说三国故事的，当时称为“说三分”。元代出现的《三国志平话》，实际上是从说书人使用的本子，虽较简略粗糙，但已初肯《三国演义》的规模。罗贯中在群众传说和民间艺人创作的基础上，又依据陈寿《三国志》及裴松之注中所征引的资料（还包括《世说新语》及注中的资料），经过巨大的创作劳动，写在了规模宏伟的巨著——《三国志通俗演义》全书24卷，240回。后来经过毛纶，毛宗岗父子批改，形成我们现在所见的《三国演义》120回版');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00006', '白夜行', '东野圭吾', '南海出版公司', 2013, 8, 8, 'BS1', '9787544258609', 39.5, '东野圭吾万千书迷心中的无冕之王\r\n周刊文春推理小说年度BEST10第1名\r\n本格推理小说年度BEST10第2名\r\n《白夜行》是东野圭吾迄今口碑最好的长篇杰作，具备经典名著的一切要素：\r\n一宗离奇命案牵出跨度近20年步步惊心的故事：悲凉的爱情、吊诡的命运、令人发指的犯罪、复杂人性的对决与救赎……\r\n-------------------------------------------------------------------\r\n1973年，大阪的一栋废弃建筑中发现一名遭利器刺死的男子。案件扑朔迷离，悬而未决。\r\n此后20年间，案件滋生出的恶逐渐萌芽生长，绽放出恶之花。案件相关者的人生逐渐被越来越重的阴影笼罩……\r\n“我的天空里没有太阳，总是黑夜，但并不暗，因为有东西代替了太阳。虽然没有太阳那么明亮，但对我来说已经足够。\r\n凭借着这份光，我便能把黑夜当成白天。\r\n我从来就没有太阳，所以不怕失去。”\r\n“只希望能手牵手在太阳下散步”，这句象征本书故事内核的绝望念想，有如一个美丽的幌子，随着无数凌乱、压抑、悲凉的事件片段如纪录片一样一一还原，最后一丝温情也被完全抛弃，万千读者在一曲救赎罪恶的爱情之中悲切动容。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00007', '平凡的世界', '路遥', '人民文学出版社', 2005, 12, 12, 'BS1', '9787020049295', 64, '《平凡的世界》是一部现实主义小说，也是一部小说形式的家族史。作者浓缩了中国西北农村的历史变迁过程，在小说中全景式地表现了中国当代城乡的社会生活。在近十年的广阔背景下，通过复杂的矛盾纠葛，刻划社会各阶层众多普通人的形象。劳动与爱情，挫折与追求，痛苦与欢乐，日常生活与巨大社会冲突，纷繁地交织在一起，深刻地展示了普通人在大时代历史进程中所走过的艰难曲折的道路。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00008', '围城', '钱锺书', '人民文学出版社', 1991, 10, 10, 'BS1', '9787020024759', 19, '《围城》是钱钟书所著的长篇小说。第一版于1947年由上海晨光出版公司出版。1949年之后，由于政治等方面的原因，本书长期无法在中国大陆和台湾重印，仅在香港出现过盗印本。1980年由作者重新修订之后，在中国大陆地区由人民文学出版社刊印。此后作者又曾小幅修改过几次。《围城》 自从出版以来，就受到许多人的推崇。由于1949年后长期无法重印，这本书逐渐淡出人们的视野。1960年代，旅美汉学家夏志清在《中国现代小说史》(A History of Modern Chinese Fiction)中对本书作出很高的评价，这才重新引起人们对它的关注。人们对它的评价一般集中在两方面，幽默的语言和对生活深刻的观察。从1990年代开始，也有人提出对本书的不同看法，认为这是一部被“拔高”的小说，并不是一部出色的作品。很多人认为这是一部幽默作品。除了各具特色的人物语言之外，作者夹叙其间的文字也显着机智与幽默。这是本书的一大特色。也有人认为这是作者卖弄文字，语言显得尖酸刻薄。但这一说法并不为大多数人接受。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00009', '白鹿原', '陈忠实', '人民文学出版社', 2012, 10, 10, 'BS1', '9787020090297', 39, '在从清末民初到建国之初的半个世纪里，一阵阵狂风掠过了白鹿原上空，而每一次的变动都震荡着它的内在结构：打乱了再恢复，恢复了再打乱，细腻地反映出白姓和鹿姓两大家族祖孙三代的恩怨纷争。陈忠实先生在这里，人物的命运是纵线，百回千转，社会历史的演进是横面，愈拓愈宽，传统文化的兴衰则是全书的精神主体，以至人、社会历史、文化精神三者之间相互激荡，相互作用，共同推进了作品的时空，在我们眼前铺开了一轴恢宏的、动态的、极富纵深感的关于我们民族灵魂的现实主义的画卷。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00010', '肖申克的救赎', '斯蒂芬·金', '人民文学出版社', 2006, 5, 5, 'BS2', '9787020054985', 29.9, '这本书收入斯蒂芬·金的四部中篇小说，是他作品中的杰出代表作。其英文版一经推出，即登上《纽约时报》畅销书排行榜的冠军之位，当年在美国狂销二十八万册。目前，这本书已经被翻译成三十一种语言，同时创下了收录的四篇小说中有三篇被改编成轰动一时的电影的记录。\r\n其中最为著名是曾获奥斯卡奖七项提名、被称为电影史上最完美影片的《肖申克救赎》（又译《刺激一九九五》）。这部小说展现了斯蒂芬·金于擅长的惊悚题材之外的过人功力。书中的另两篇小说《纳粹高徒》与《尸体》拍成电影后也赢得了极佳的口碑。其中《尸体》还被视为斯蒂芬·金最具自传色彩的作品。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00011', '我与地坛', '史铁生', '春风文艺出版社', 2002, 8, 8, 'BS5', '9787531324362', 25.0, '收有“午餐半小时”、“我的遥远的清平湾”、“命若琴弦”、“第一人称”、“两个故事”等15篇史铁生的代表作。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00012', '追风筝的人', '卡勒德·胡赛尼', '上海人民出版社', 2006, 5, 5, 'BS2', '9787208061644', 29.0, '12岁的阿富汗富家少爷阿米尔与仆人哈桑情同手足。然而，在一场风筝比赛后，发生了一件悲惨不堪的事，阿米尔为自己的懦弱感到自责和痛苦，逼走了哈桑，不久，自己也跟随父亲逃往美国。\r\n成年后的阿米尔始终无法原谅自己当年对哈桑的背叛。为了赎罪，阿米尔再度踏上暌违二十多年的故乡，希望能为不幸的好友尽最后一点心力，却发现一个惊天谎言，儿时的噩梦再度重演，阿米尔该如何抉择？\r\n故事如此残忍而又美丽，作者以温暖细腻的笔法勾勒人性的本质与救赎，读来令人荡气回肠。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00013', '鼠疫', '阿尔尼·加缪', '上海译文出版社', 2013, 7, 7, 'BS2', '9787532761753', 34, '阿尔贝•加缪（1913—1960）是法国声名卓著的小说家、散文家和剧作家，“存在主义”文学的大师。1957年因“热情而冷静地阐明了当代向人类良知提出的种种问题”而获诺贝尔文学奖，是有史以来最年轻的诺奖获奖作家之一。\r\n加缪在他的小说、戏剧、随笔和论著中深刻地揭示出人在异己的世界中的孤独、个人与自身的日益异化，以及罪恶和死亡的不可避免，但他在揭示出世界的荒诞的同时却并不绝望和颓丧，他主张要在荒诞中奋起反抗，在绝望中坚持真理和正义，他为世人指出了一条基督教和马克思主义以外的自由人道主义道路。他直面惨淡人生的勇气，他“知其不可而为之”的大无畏精神使他在第二次世界大战之后不仅在法国，而且在欧洲并最终在全世界成为他那一代人的代言人和下一代人的精神导师。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00014', '史记(全十册)', '司马迁/张守节', '中华书局', 1982, 15, 15, 'BS3', '9787101003048', 125, '史记是我国第一部通史。在史记之前，有以年代为次的“编年史”如春秋，有以地域为限的“国别史”如国语、战国策，有以文告档卷形式保存下来的“政治史”如尚书，可是没有上下几千年，包罗各方面，而又融会贯通，脉络分明，像史记那样的通史。\r\n唐刘知几的史通分叙六家，统归二体。所谓“二体”，就是“编年体”和“纪传体”，而史记是纪传体的创始。从此以后，历代的所谓“正史，从汉书到明史，尽管名目有改变（例如汉书改“书”为“志”，晋书改世家”为“载记”），门类有短缺（例如汉书无“世家”，后汉书、三国志等都无“表”、“志及世家”），但都有“纪”有“传”，绝无例外地沿袭了史记的体例。\r\n据司马迁自序，史记全书本纪十二篇，表十篇，书八篇，世家三十篇，列传七十篇（包括太史公自序），共一百三十篇。今本史记一百三十卷，篇数跟司马迁自序所说的相符。但汉书司马迁传说其中“十篇缺，有录无书。三国魏张晏注：“迁没之后，亡景纪、武纪、礼书、乐书、兵书（按：即律书）、汉兴以来将相年表、日者传、三王世家、龟策列传、传靳列传。兀成之间，褚先生补缺，作武帝纪、三王世家、龟策、日者列传，言辞鄙陋，非迁本意也。可见司马迁编写史记，只能说是基本上完成，其中有若干篇，或者没有写定，或者已经定稿而后来散失了。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00015', '西游记', '吴承恩', '人民文学出版社', 2004, 15, 15, 'BS3', '9787020008735', 47.2, '《西游记》主要描写的是孙悟空保唐僧西天取经，历经九九八十一难的故事。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00016', '美丽新世界', '奥尔德斯·赫胥黎', '上海译文出版社', 2017, 5, 5, 'BS2', '9787532774685', 45, '出版于一九三二年的《美丽新世界》是奥尔德斯•赫胥黎最杰出的代表作，是二十世纪最著名的反乌托邦文学经典之一，与奥威尔的《一九八四》、扎米亚京的《我们》并称为“反乌托邦”三部曲，在国内外文学界和思想界影响深远。这是一部寓言作品，展现了赫胥黎眼中的人类社会的未来图景：通过最有效的科学和心理工程，人类从遗传和基因上就已经被先天设计为各种等级的社会成员，完全沦为驯顺的机器，个性和自由被扼杀，文学艺术濒于毁灭。继《美丽新世界》这部寓言小说杰作之后，赫胥黎又于一九五八年出版了论著《重返美丽新世界》，在这部雄辩的作品中，作者运用其丰富的社会学和人类学知识，比较了现代社会与他在《美丽新世界》中所构想的寓言性图景的方方面面，像人口过剩、宣传和洗脑以及化学劝诱等，认为他早年悲观的预言正在成为现实。本书将赫胥黎这两部最经典的名著全部收入。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00017', '边城', '沈从文', '北岳文艺出版社', 2002, 7, 7, 'BS1', '9787537823425', 12, '《边城》是沈从文的代表作，写于一九三三年至一九三四年初。这篇作品如沈从文的其他湘西作品，着眼于普通人、善良人的命运变迁，描摹了湘女翠翠阴差阳错的生活悲剧，诚如作者所言：“一切充满了善，然而到处是不凑巧。既然是不凑巧，因之素朴的善终难免产生悲剧。”\r\n《边城》写出了一种如梦似幻之美，像摆渡、教子、救人、助人、送葬这些日常小事，在作者来都显得相当理想化，颇有几分“君子田”的气象。当然，矛盾也并非不存在，明眼人一看便知，作者所用的背景材料中便隐伏着社会矛盾的影子。作者亦不曾讳言他的写作意图是支持“民族复兴大业的人”，“给他们一种勇气和信心”。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00018', '安娜·卡列尼娜', '列夫·托尔斯泰', '上海文艺出版社', 2007, 8, 8, 'BS2', '9787532132256', 37, '《安娜·卡列尼娜》是托尔斯泰第二部里程碑式的长篇小说，创作于 1873—1877年。作品由两条既平行又相互联系的线索构成：一条是安娜与卡列宁、伏伦斯基之间的家庭、婚姻和爱情纠葛；一条是列文和吉娣的爱情生活及列文进行的庄园改革。安娜是一个上流社会的贵妇人，年轻漂亮，追求个性解放和爱情自由，而她的丈夫却是一个性情冷漠的“官僚机器 ”。一次在车站上，安娜和年轻军官伏伦斯基邂逅，后者为她的美貌所吸引，拼命追求。最终安娜堕入情网，毅然抛夫别子和伏伦斯基同居。但对儿子的思念和周围环境的压力使她陷入痛苦和不安中，而且她逐渐发现伏伦斯基并非一个专情的理想人物。在相继失去儿子和精神上最后一根支柱 ——伏伦斯基后，经过一次和伏伦斯基的口角，安娜发现自己再也无法在这个虚伪的社会中生活下去，绝望之余，她选择了卧轨自杀。小说揭露了 19世纪六七十年代俄罗斯上流社会的丑恶与虚伪，同时也表达了作者处在社会转型期时所进行的复杂的道德探索和思想探索。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00019', '水浒传', '施耐庵', '人民文学出版社', 1997, 15, 15, 'BS3', '9787020008742', 50.6, '《水浒传》是我国第一部以农民起义为题材的长篇章回小说，是我国文学史上一座巍然屹立的丰碑，也是世界文学宝库中一颗光彩夺目的明珠。数百年来，它一直深受我国人民的喜爱，并被译为多种文字，成为我国流传最为广泛的古代长篇小说之一。\r\n《水浒传》具体而生动地描写了以宋江为首的农民起义发生、发展直至失财的整个过程，揭露了封建社会的黑暗、腐朽和统治阶级的种种罪恶，热情歌颂了起义英雄的反抗精神和正义行动，塑造了一大批梁山好汉的光辉形象，形象地揭示了封建社会“官逼民反”的客观真理和农民起义失败的内在原因。');

INSERT INTO book (B_ID, B_NAME, B_AUTHOR, B_PRESS, B_PUB_YEAR, B_TOTAL_COLLECTION, B_CUR_COLLECTION, B_BS_ID, B_ISBN, B_PRICE, B_DESCRIPTION) VALUES ('B00020', '挪威的森林', '村上春树', '上海译文出版社', 2014, 5, 5, 'BS2', '9787532765546', 48, '《挪威的森林》系日本著名作家村上春树的重要作品之一。汉堡机场一曲忧郁的《挪威的森林》，复苏了主人公渡边感伤的二十岁记忆：娴静缅腆、多愁善感的直子，是他动情倾心的女孩，那缠绵的病况，如水的柔情，甚至在她花烛香销之后，仍令他无时或忘；神采飞扬、野性未脱的绿子，是他邂逅相遇的情人，那迷人的活力、大胆的表白，即使是他山盟已订之时，也觉她难以抗拒。悲欢恋情，如激弦，如幽曲，掩卷犹余音颤袅；奇句妙语，如泉涌，如露凝，读来真口角噙香。《挪威的森林》是纯而又纯的青春情感，百分之百的恋爱小说。');

INSERT INTO borrow_record (BR_U_ID, BR_B_ID,BR_BORROW_DATE, BR_EXPECT_RETURN_DATE) VALUES ('U0003', 'B00006', '2023-07-19', '2023-08-02');
INSERT INTO borrow_record (BR_U_ID, BR_B_ID,BR_BORROW_DATE, BR_EXPECT_RETURN_DATE) VALUES ('U0015', 'B00009', '2023-07-25', '2023-08-08');
INSERT INTO borrow_record (BR_U_ID, BR_B_ID,BR_BORROW_DATE, BR_EXPECT_RETURN_DATE) VALUES ('U0019', 'B00002', '2023-07-20', '2023-08-03');
INSERT INTO borrow_record (BR_U_ID, BR_B_ID,BR_BORROW_DATE, BR_EXPECT_RETURN_DATE) VALUES ('U0008', 'B00013', '2023-07-27', '2023-08-10');
INSERT INTO borrow_record (BR_U_ID, BR_B_ID,BR_BORROW_DATE, BR_EXPECT_RETURN_DATE) VALUES ('U0004', 'B00018', '2023-07-19', '2023-08-02');

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
