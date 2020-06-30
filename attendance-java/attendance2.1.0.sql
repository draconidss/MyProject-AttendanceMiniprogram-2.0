/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50729
 Source Host           : localhost:3306
 Source Schema         : attendance2

 Target Server Type    : MySQL
 Target Server Version : 50729
 File Encoding         : 65001

 Date: 15/06/2020 00:48:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `lid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `rid` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `lDate` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
  `during` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`lid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (1, 1, 1, 1, '2020-05-25 20:00:00', NULL);
INSERT INTO `log` VALUES (2, 1, 1, 0, '2020-05-26 22:00:00', 7200000);
INSERT INTO `log` VALUES (3, 2, 2, 1, '2020-05-27 21:00:00', NULL);
INSERT INTO `log` VALUES (4, 2, 2, 0, '2020-05-28 22:00:00', 90000000);
INSERT INTO `log` VALUES (49, 1, 2, 1, '2020-06-13 13:50:20', NULL);
INSERT INTO `log` VALUES (50, 1, 2, 0, '2020-06-13 13:50:38', 17799);
INSERT INTO `log` VALUES (51, 1, 1, 1, '2020-06-13 13:51:03', NULL);
INSERT INTO `log` VALUES (52, 1, 1, 0, '2020-06-13 13:51:34', 30804);
INSERT INTO `log` VALUES (53, 1, 1, 1, '2020-06-13 13:52:29', NULL);
INSERT INTO `log` VALUES (54, 1, 1, 0, '2020-06-13 13:52:55', 26158);
INSERT INTO `log` VALUES (55, 1, 5, 1, '2020-06-13 13:53:38', NULL);
INSERT INTO `log` VALUES (56, 1, 5, 0, '2020-06-13 14:50:11', 3393285);
INSERT INTO `log` VALUES (57, 1, 1, 1, '2020-06-13 14:51:04', NULL);
INSERT INTO `log` VALUES (58, 1, 1, 0, '2020-06-14 01:59:13', 40089174);
INSERT INTO `log` VALUES (59, 1, 7, 1, '2020-06-14 02:04:24', NULL);
INSERT INTO `log` VALUES (60, 1, 7, 0, '2020-06-14 02:04:55', 31098);
INSERT INTO `log` VALUES (61, 1, 1, 1, '2020-06-14 02:05:29', NULL);
INSERT INTO `log` VALUES (62, 1, 1, 0, '2020-06-14 02:07:35', 126386);
INSERT INTO `log` VALUES (63, 1, 3, 1, '2020-06-14 02:10:42', NULL);
INSERT INTO `log` VALUES (64, 1, 3, 0, '2020-06-14 02:10:53', 10983);
INSERT INTO `log` VALUES (65, 1, 7, 1, '2020-06-14 02:12:02', NULL);
INSERT INTO `log` VALUES (66, 1, 7, 0, '2020-06-14 02:12:18', 16076);
INSERT INTO `log` VALUES (67, 1, 3, 1, '2020-06-14 02:19:32', NULL);
INSERT INTO `log` VALUES (68, 1, 3, 0, '2020-06-14 10:14:38', 28506027);
INSERT INTO `log` VALUES (69, 1, 5, 1, '2020-06-14 10:22:31', NULL);
INSERT INTO `log` VALUES (70, 1, 5, 0, '2020-06-14 10:38:59', 987847);
INSERT INTO `log` VALUES (71, 1, 3, 1, '2020-06-14 17:13:26', NULL);
INSERT INTO `log` VALUES (72, 1, 3, 0, '2020-06-14 19:16:26', 7379892);
INSERT INTO `log` VALUES (73, 1, 1, 1, '2020-06-14 19:24:32', NULL);
INSERT INTO `log` VALUES (74, 1, 1, 0, '2020-06-15 00:11:53', 17241047);
INSERT INTO `log` VALUES (75, 1, 3, 1, '2020-06-15 00:28:29', NULL);
INSERT INTO `log` VALUES (76, 1, 3, 0, '2020-06-15 00:29:05', 36169);
INSERT INTO `log` VALUES (77, 1, 1, 1, '2020-06-15 00:29:14', NULL);
INSERT INTO `log` VALUES (78, 1, 1, 0, '2020-06-15 00:29:25', 11465);
INSERT INTO `log` VALUES (79, 1, 1, 1, '2020-06-15 00:33:28', NULL);
INSERT INTO `log` VALUES (80, 1, 1, 0, '2020-06-15 00:36:14', 166210);
INSERT INTO `log` VALUES (81, 1, 2, 1, '2020-06-15 00:36:28', NULL);
INSERT INTO `log` VALUES (82, 1, 2, 0, '2020-06-15 00:36:49', 21250);
INSERT INTO `log` VALUES (83, 1, 1, 1, '2020-06-15 00:39:33', NULL);
INSERT INTO `log` VALUES (84, 1, 1, 0, '2020-06-15 00:40:20', 46659);
INSERT INTO `log` VALUES (85, 1, 1, 1, '2020-06-15 00:40:40', NULL);
INSERT INTO `log` VALUES (86, 1, 1, 0, '2020-06-15 00:41:15', 35121);
INSERT INTO `log` VALUES (87, 1, 5, 1, '2020-06-15 00:41:33', NULL);
INSERT INTO `log` VALUES (88, 1, 5, 0, '2020-06-15 00:41:54', 20576);
INSERT INTO `log` VALUES (89, 1, 1, 1, '2020-06-15 00:41:58', NULL);
INSERT INTO `log` VALUES (90, 1, 1, 0, '2020-06-15 00:44:59', 180688);
INSERT INTO `log` VALUES (91, 1, 2, 1, '2020-06-15 00:45:06', NULL);
INSERT INTO `log` VALUES (92, 1, 2, 0, '2020-06-15 00:45:12', 5846);
INSERT INTO `log` VALUES (93, 1, 1, 1, '2020-06-15 00:45:22', NULL);

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `rid` int(11) NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `isAdmin` int(11) NULL DEFAULT 0,
  `log` int(11) NULL DEFAULT 0,
  `duration` bigint(20) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (1, 1, 1, 1, 25, 65153712);
INSERT INTO `member` VALUES (2, 2, 0, 1, 2, 90000000);
INSERT INTO `member` VALUES (2, 1, 0, 1, 6, 44895);
INSERT INTO `member` VALUES (5, 1, 0, 1, 6, 4401708);
INSERT INTO `member` VALUES (7, 1, 0, 1, 4, 47174);
INSERT INTO `member` VALUES (3, 1, 0, 1, 8, 35933071);

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `rid` int(11) NOT NULL AUTO_INCREMENT,
  `rname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `del` int(11) NULL DEFAULT 1,
  PRIMARY KEY (`rid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, '综B902', '岭南师范学院综合楼B911', 1);
INSERT INTO `room` VALUES (2, '综B913', '岭南师范学院综合楼B913', 1);
INSERT INTO `room` VALUES (3, '综B901', '岭南师范学院综合楼B901', 1);
INSERT INTO `room` VALUES (4, '教三104', '岭南师范学院教三104', 0);
INSERT INTO `room` VALUES (5, '教三105', '岭南师范学院教三105', 1);
INSERT INTO `room` VALUES (6, '教三106', '岭南师范学院教三106', 0);
INSERT INTO `room` VALUES (7, '教三107', '岭南师范学院教三107', 1);
INSERT INTO `room` VALUES (8, '教三108', '岭南师范学院教三108', 0);
INSERT INTO `room` VALUES (9, '教三109', '岭南师范学院教三109', 0);
INSERT INTO `room` VALUES (10, '教三110', '岭南师范学院教三110', 0);

-- ----------------------------
-- Table structure for roomadmin
-- ----------------------------
DROP TABLE IF EXISTS `roomadmin`;
CREATE TABLE `roomadmin`  (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `notice` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `nDate` datetime(0) NULL DEFAULT NULL,
  `del` int(11) NULL DEFAULT 1,
  PRIMARY KEY (`aid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roomadmin
-- ----------------------------
INSERT INTO `roomadmin` VALUES (1, 1, 1, '公告：uid为1,rId为1，公告示例', '2020-01-05 08:00:00', 1);
INSERT INTO `roomadmin` VALUES (2, 2, 2, '公告：uid为2,rId为2，公告示例', '2020-01-05 09:00:00', 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `realName` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `level` int(11) NULL DEFAULT 2,
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '15322533185', NULL, '陈龙', '0.00.0', 1);
INSERT INTO `user` VALUES (2, '18933573671', '3481723658@qq.com', '李华', '0.00.0', 2);
INSERT INTO `user` VALUES (3, '18028405303', '66666@qq.com', '简自豪', '0.00.0', 2);

-- ----------------------------
-- Table structure for wxuser
-- ----------------------------
DROP TABLE IF EXISTS `wxuser`;
CREATE TABLE `wxuser`  (
  `uid` int(11) NULL DEFAULT NULL,
  `openid` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nickName` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `avatarUrl` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `regDate` datetime(0) NOT NULL,
  `lastLoginDate` datetime(0) NOT NULL,
  PRIMARY KEY (`openid`) USING BTREE,
  UNIQUE INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wxuser
-- ----------------------------
INSERT INTO `wxuser` VALUES (3, 'od6Es5GYjg2bN0BjRo7tuXT5FFLs', 'demoData', 'demoData', '2020-06-03 00:12:00', '2020-06-03 01:14:16');
INSERT INTO `wxuser` VALUES (2, 'od6Es5L1Q6HvorEiUsa5N6eHlo5o', '+T', 'https://wx.qlogo.cn/mmopen/vi_32/U74glmWRaf6DibbSrPjy7OGr9MibkjvqX8YvRzcEPbMQRaJxjvuCqCoZqtwaMc5TAc91axBhtTLmCdtMdraRwZTg/132', '2020-02-03 08:00:00', '2020-01-02 08:00:00');
INSERT INTO `wxuser` VALUES (1, 'od6Es5NOTRaVHRvEZNnow2WLqN7Q', 'Morty', 'https://wx.qlogo.cn/mmopen/vi_32/gzMS93L5HxDu7YgEUXqmrrXw6xBq8DnGKibtddgIBibpCHh6a9DGqtl40CswSNUnd3q9cw5a07QibzibKI639Hn3nA/132', '2020-06-12 23:32:05', '2020-06-12 23:32:05');

SET FOREIGN_KEY_CHECKS = 1;
