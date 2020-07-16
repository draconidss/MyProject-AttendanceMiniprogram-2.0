/*
 Navicat Premium Data Transfer

 Source Server         : 47.100.59.153
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : 47.100.59.153:3306
 Source Schema         : attendance2

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 15/07/2020 23:44:38
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
) ENGINE = InnoDB AUTO_INCREMENT = 305 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (59, 1, 7, 1, '2020-06-14 02:04:24', NULL);
INSERT INTO `log` VALUES (60, 1, 7, 0, '2020-06-14 02:04:55', 31098);
INSERT INTO `log` VALUES (63, 1, 3, 1, '2020-06-14 02:10:42', NULL);
INSERT INTO `log` VALUES (64, 1, 3, 0, '2020-06-14 02:10:53', 10983);
INSERT INTO `log` VALUES (65, 1, 7, 1, '2020-06-14 02:12:02', NULL);
INSERT INTO `log` VALUES (66, 1, 7, 0, '2020-06-14 02:12:18', 16076);
INSERT INTO `log` VALUES (67, 1, 3, 1, '2020-06-14 02:19:32', NULL);
INSERT INTO `log` VALUES (68, 1, 3, 0, '2020-06-14 10:14:38', 28506027);
INSERT INTO `log` VALUES (71, 1, 3, 1, '2020-06-14 17:13:26', NULL);
INSERT INTO `log` VALUES (72, 1, 3, 0, '2020-06-14 19:16:26', 7379892);
INSERT INTO `log` VALUES (75, 1, 3, 1, '2020-06-15 00:28:29', NULL);
INSERT INTO `log` VALUES (76, 1, 3, 0, '2020-06-15 00:29:05', 36169);
INSERT INTO `log` VALUES (97, 1, 7, 1, '2020-06-15 02:30:42', NULL);
INSERT INTO `log` VALUES (98, 1, 7, 0, '2020-06-15 02:38:57', 494810);
INSERT INTO `log` VALUES (99, 1, 3, 1, '2020-06-15 02:39:03', NULL);
INSERT INTO `log` VALUES (100, 3, 3, 1, '2020-06-15 02:58:03', NULL);
INSERT INTO `log` VALUES (101, 1, 3, 0, '2020-06-15 03:05:08', 1565132);
INSERT INTO `log` VALUES (102, 1, 7, 1, '2020-06-15 03:05:16', NULL);
INSERT INTO `log` VALUES (103, 1, 7, 0, '2020-06-15 03:31:33', 1577398);
INSERT INTO `log` VALUES (113, 3, 7, 0, '2020-06-15 13:50:30', 1517840);
INSERT INTO `log` VALUES (114, 3, 5, 1, '2020-06-15 13:50:39', NULL);
INSERT INTO `log` VALUES (129, 10, 2, 1, '2020-06-15 20:28:39', NULL);
INSERT INTO `log` VALUES (130, 10, 2, 0, '2020-06-15 20:29:12', 32633);
INSERT INTO `log` VALUES (138, 1, 12, 1, '2020-06-15 23:30:56', NULL);
INSERT INTO `log` VALUES (139, 1, 12, 0, '2020-06-16 00:06:16', 2120310);
INSERT INTO `log` VALUES (140, 1, 7, 1, '2020-06-16 01:13:27', NULL);
INSERT INTO `log` VALUES (141, 1, 7, 0, '2020-06-16 01:14:58', 91176);
INSERT INTO `log` VALUES (142, 1, 7, 1, '2020-06-16 01:15:40', NULL);
INSERT INTO `log` VALUES (143, 1, 7, 0, '2020-06-16 01:18:37', 177353);
INSERT INTO `log` VALUES (146, 1, 13, 1, '2020-06-16 11:18:51', NULL);
INSERT INTO `log` VALUES (147, 1, 13, 0, '2020-06-16 11:44:18', 1526955);
INSERT INTO `log` VALUES (150, 13, 2, 1, '2020-06-16 14:16:49', NULL);
INSERT INTO `log` VALUES (151, 13, 2, 0, '2020-06-16 14:18:05', 75894);
INSERT INTO `log` VALUES (158, 1, 7, 1, '2020-06-16 14:29:48', NULL);
INSERT INTO `log` VALUES (159, 1, 7, 0, '2020-06-17 04:35:43', 50754567);
INSERT INTO `log` VALUES (162, 13, 5, 1, '2020-06-17 15:28:51', NULL);
INSERT INTO `log` VALUES (163, 13, 5, 0, '2020-06-17 15:29:47', 55730);
INSERT INTO `log` VALUES (164, 13, 3, 1, '2020-06-17 16:38:46', NULL);
INSERT INTO `log` VALUES (165, 1, 12, 1, '2020-06-17 17:31:40', NULL);
INSERT INTO `log` VALUES (166, 1, 12, 0, '2020-06-18 00:24:38', 24777877);
INSERT INTO `log` VALUES (168, 13, 3, 0, '2020-06-18 02:43:52', 36305590);
INSERT INTO `log` VALUES (169, 13, 1, 1, '2020-06-18 02:43:58', NULL);
INSERT INTO `log` VALUES (170, 13, 1, 0, '2020-06-18 03:16:17', 1938788);
INSERT INTO `log` VALUES (171, 13, 5, 1, '2020-06-18 14:27:47', NULL);
INSERT INTO `log` VALUES (173, 1, 9, 1, '2020-06-18 16:40:39', NULL);
INSERT INTO `log` VALUES (174, 1, 9, 0, '2020-06-19 02:53:19', 36759542);
INSERT INTO `log` VALUES (175, 1, 9, 1, '2020-06-19 03:17:32', NULL);
INSERT INTO `log` VALUES (176, 1, 9, 0, '2020-06-19 13:01:23', 35030549);
INSERT INTO `log` VALUES (177, 13, 5, 0, '2020-06-19 14:53:55', 87968475);
INSERT INTO `log` VALUES (178, 1, 8, 1, '2020-06-19 16:17:01', NULL);
INSERT INTO `log` VALUES (179, 14, 2, 1, '2020-06-19 18:37:36', NULL);
INSERT INTO `log` VALUES (180, 14, 2, 0, '2020-06-19 18:41:27', 231379);
INSERT INTO `log` VALUES (181, 1, 8, 0, '2020-06-19 21:02:44', 17143101);
INSERT INTO `log` VALUES (182, 1, 13, 1, '2020-06-19 21:24:32', NULL);
INSERT INTO `log` VALUES (183, 1, 13, 0, '2020-06-19 21:54:31', 1799382);
INSERT INTO `log` VALUES (184, 1, 7, 1, '2020-06-19 21:54:37', NULL);
INSERT INTO `log` VALUES (185, 1, 7, 0, '2020-06-20 00:23:37', 8940039);
INSERT INTO `log` VALUES (188, 1, 3, 1, '2020-06-20 03:37:32', NULL);
INSERT INTO `log` VALUES (189, 1, 3, 0, '2020-06-20 23:18:41', 70869341);
INSERT INTO `log` VALUES (190, 1, 10, 1, '2020-06-20 23:22:45', NULL);
INSERT INTO `log` VALUES (191, 1, 10, 0, '2020-06-20 23:33:10', 625122);
INSERT INTO `log` VALUES (194, 1, 4, 1, '2020-06-20 23:38:49', NULL);
INSERT INTO `log` VALUES (195, 1, 4, 0, '2020-06-21 00:04:28', 1539471);
INSERT INTO `log` VALUES (196, 1, 4, 1, '2020-06-21 11:50:08', NULL);
INSERT INTO `log` VALUES (197, 1, 4, 0, '2020-06-21 11:50:44', 36038);
INSERT INTO `log` VALUES (198, 1, 6, 1, '2020-06-21 11:51:09', NULL);
INSERT INTO `log` VALUES (199, 1, 6, 0, '2020-06-21 11:51:24', 15443);
INSERT INTO `log` VALUES (200, 1, 11, 1, '2020-06-21 11:53:58', NULL);
INSERT INTO `log` VALUES (201, 13, 11, 1, '2020-06-21 12:35:48', NULL);
INSERT INTO `log` VALUES (202, 1, 11, 0, '2020-06-21 18:39:40', 24342313);
INSERT INTO `log` VALUES (203, 13, 11, 0, '2020-06-21 18:55:59', 22811291);
INSERT INTO `log` VALUES (204, 1, 6, 1, '2020-06-23 02:03:05', NULL);
INSERT INTO `log` VALUES (205, 1, 6, 0, '2020-06-23 13:29:11', 41165719);
INSERT INTO `log` VALUES (206, 1, 8, 1, '2020-06-23 23:52:26', NULL);
INSERT INTO `log` VALUES (207, 1, 8, 0, '2020-06-24 00:46:59', 3273226);
INSERT INTO `log` VALUES (208, 16, 10, 1, '2020-06-24 07:24:18', NULL);
INSERT INTO `log` VALUES (209, 1, 8, 1, '2020-06-25 00:50:35', NULL);
INSERT INTO `log` VALUES (210, 1, 8, 0, '2020-06-25 12:14:29', 41034125);
INSERT INTO `log` VALUES (211, 16, 10, 0, '2020-06-24 07:54:18', 1800000);
INSERT INTO `log` VALUES (212, 16, 7, 1, '2020-06-26 07:47:36', NULL);
INSERT INTO `log` VALUES (213, 16, 7, 0, '2020-06-26 07:49:46', 129875);
INSERT INTO `log` VALUES (214, 16, 4, 1, '2020-06-26 07:50:02', NULL);
INSERT INTO `log` VALUES (215, 16, 4, 0, '2020-06-26 07:50:29', 26820);
INSERT INTO `log` VALUES (216, 16, 2, 1, '2020-06-26 07:50:38', NULL);
INSERT INTO `log` VALUES (217, 16, 2, 0, '2020-06-26 07:51:10', 31889);
INSERT INTO `log` VALUES (218, 16, 10, 1, '2020-06-26 07:55:58', NULL);
INSERT INTO `log` VALUES (219, 16, 10, 0, '2020-06-26 07:56:50', 51669);
INSERT INTO `log` VALUES (220, 1, 10, 1, '2020-06-28 00:39:58', NULL);
INSERT INTO `log` VALUES (221, 1, 10, 0, '2020-06-28 00:41:38', 99833);
INSERT INTO `log` VALUES (222, 15, 10, 1, '2020-06-28 00:45:58', NULL);
INSERT INTO `log` VALUES (223, 15, 10, 0, '2020-06-28 00:51:24', 325558);
INSERT INTO `log` VALUES (224, 15, 3, 1, '2020-06-28 01:50:00', NULL);
INSERT INTO `log` VALUES (225, 1, 10, 1, '2020-06-28 01:39:09', NULL);
INSERT INTO `log` VALUES (226, 1, 10, 0, '2020-06-28 02:27:54', 2924861);
INSERT INTO `log` VALUES (227, 1, 13, 1, '2020-06-28 02:53:26', NULL);
INSERT INTO `log` VALUES (228, 1, 13, 0, '2020-06-28 02:53:50', 23844);
INSERT INTO `log` VALUES (229, 1, 4, 1, '2020-06-28 16:50:40', NULL);
INSERT INTO `log` VALUES (230, 1, 4, 0, '2020-06-28 17:03:13', 752683);
INSERT INTO `log` VALUES (231, 1, 8, 1, '2020-06-28 20:54:24', NULL);
INSERT INTO `log` VALUES (232, 1, 8, 0, '2020-06-28 21:30:43', 2178737);
INSERT INTO `log` VALUES (233, 1, 4, 1, '2020-06-28 21:33:28', NULL);
INSERT INTO `log` VALUES (234, 1, 4, 0, '2020-06-29 00:14:35', 9666866);
INSERT INTO `log` VALUES (235, 18, 5, 1, '2020-06-30 19:26:46', NULL);
INSERT INTO `log` VALUES (236, 19, 5, 1, '2020-06-30 19:29:30', NULL);
INSERT INTO `log` VALUES (237, 19, 5, 0, '2020-06-30 19:30:42', 72420);
INSERT INTO `log` VALUES (238, 18, 5, 0, '2020-06-30 19:38:42', 716451);
INSERT INTO `log` VALUES (239, 22, 10, 1, '2020-07-01 09:30:53', NULL);
INSERT INTO `log` VALUES (240, 1, 9, 1, '2020-07-01 09:31:05', NULL);
INSERT INTO `log` VALUES (241, 22, 10, 0, '2020-07-01 09:38:15', 442214);
INSERT INTO `log` VALUES (242, 1, 9, 0, '2020-07-01 09:41:43', 637596);
INSERT INTO `log` VALUES (243, 22, 9, 1, '2020-07-01 09:50:19', NULL);
INSERT INTO `log` VALUES (244, 1, 9, 1, '2020-07-01 09:51:02', NULL);
INSERT INTO `log` VALUES (245, 22, 9, 0, '2020-07-01 09:52:32', 133033);
INSERT INTO `log` VALUES (246, 1, 9, 0, '2020-07-01 09:53:00', 118291);
INSERT INTO `log` VALUES (247, 23, 2, 1, '2020-07-01 16:21:36', NULL);
INSERT INTO `log` VALUES (248, 1, 2, 1, '2020-07-01 17:34:39', NULL);
INSERT INTO `log` VALUES (249, 1, 2, 0, '2020-07-01 18:09:44', 2104992);
INSERT INTO `log` VALUES (250, 1, 2, 1, '2020-07-01 19:45:21', NULL);
INSERT INTO `log` VALUES (251, 1, 2, 0, '2020-07-01 23:43:00', 14259457);
INSERT INTO `log` VALUES (252, 22, 4, 1, '2020-07-03 11:39:36', NULL);
INSERT INTO `log` VALUES (253, 1, 13, 1, '2020-07-03 17:17:26', NULL);
INSERT INTO `log` VALUES (254, 1, 13, 0, '2020-07-03 17:18:11', 44854);
INSERT INTO `log` VALUES (255, 1, 11, 1, '2020-07-05 00:11:55', NULL);
INSERT INTO `log` VALUES (256, 1, 11, 0, '2020-07-05 00:12:03', 8426);
INSERT INTO `log` VALUES (257, 1, 10, 1, '2020-07-05 00:12:11', NULL);
INSERT INTO `log` VALUES (258, 1, 10, 0, '2020-07-05 00:15:04', 172919);
INSERT INTO `log` VALUES (259, 1, 7, 1, '2020-07-05 00:36:05', NULL);
INSERT INTO `log` VALUES (260, 1, 7, 0, '2020-07-05 00:36:10', 4909);
INSERT INTO `log` VALUES (261, 1, 9, 1, '2020-07-05 00:39:13', NULL);
INSERT INTO `log` VALUES (262, 1, 9, 0, '2020-07-05 00:39:23', 10238);
INSERT INTO `log` VALUES (263, 1, 9, 1, '2020-07-05 00:41:38', NULL);
INSERT INTO `log` VALUES (264, 1, 9, 0, '2020-07-05 00:41:52', 14031);
INSERT INTO `log` VALUES (265, 1, 10, 1, '2020-07-05 00:44:26', NULL);
INSERT INTO `log` VALUES (266, 1, 10, 0, '2020-07-05 00:44:30', 4357);
INSERT INTO `log` VALUES (267, 15, 3, 0, '2020-06-28 02:50:00', 3600000);
INSERT INTO `log` VALUES (268, 1, 13, 1, '2020-07-06 16:14:38', NULL);
INSERT INTO `log` VALUES (269, 22, 4, 0, '2020-07-06 17:10:46', 279070298);
INSERT INTO `log` VALUES (270, 22, 8, 1, '2020-07-06 17:10:57', NULL);
INSERT INTO `log` VALUES (271, 22, 8, 0, '2020-07-06 17:11:01', 3586);
INSERT INTO `log` VALUES (272, 22, 4, 1, '2020-07-06 17:11:06', NULL);
INSERT INTO `log` VALUES (273, 22, 4, 0, '2020-07-06 17:14:25', 199102);
INSERT INTO `log` VALUES (274, 1, 13, 0, '2020-07-06 17:21:49', 4030745);
INSERT INTO `log` VALUES (275, 1, 7, 1, '2020-07-06 17:30:32', NULL);
INSERT INTO `log` VALUES (276, 1, 7, 0, '2020-07-06 17:49:02', 1109638);
INSERT INTO `log` VALUES (277, 1, 5, 1, '2020-07-06 21:00:39', NULL);
INSERT INTO `log` VALUES (278, 1, 5, 0, '2020-07-06 21:00:51', 12366);
INSERT INTO `log` VALUES (279, 1, 5, 1, '2020-07-06 21:01:00', NULL);
INSERT INTO `log` VALUES (280, 1, 5, 0, '2020-07-06 21:03:28', 147896);
INSERT INTO `log` VALUES (281, 24, 3, 1, '2020-07-08 14:25:11', NULL);
INSERT INTO `log` VALUES (282, 25, 2, 1, '2020-07-09 23:29:16', NULL);
INSERT INTO `log` VALUES (283, 25, 2, 0, '2020-07-09 23:34:01', 284519);
INSERT INTO `log` VALUES (284, 24, 3, 0, '2020-07-09 23:34:08', 119336739);
INSERT INTO `log` VALUES (285, 24, 3, 1, '2020-07-09 23:34:18', NULL);
INSERT INTO `log` VALUES (286, 24, 3, 0, '2020-07-09 23:34:34', 15653);
INSERT INTO `log` VALUES (287, 24, 10, 1, '2020-07-09 23:34:43', NULL);
INSERT INTO `log` VALUES (288, 1, 10, 1, '2020-07-10 02:03:25', NULL);
INSERT INTO `log` VALUES (289, 1, 10, 0, '2020-07-10 12:15:55', 36750229);
INSERT INTO `log` VALUES (290, 1, 6, 1, '2020-07-10 15:18:00', NULL);
INSERT INTO `log` VALUES (291, 1, 6, 0, '2020-07-10 16:18:01', 3600738);
INSERT INTO `log` VALUES (292, 26, 5, 1, '2020-07-10 16:28:45', NULL);
INSERT INTO `log` VALUES (293, 26, 5, 0, '2020-07-10 16:30:19', 93504);
INSERT INTO `log` VALUES (294, 26, 11, 1, '2020-07-10 16:30:29', NULL);
INSERT INTO `log` VALUES (295, 26, 11, 0, '2020-07-10 16:30:37', 8257);
INSERT INTO `log` VALUES (296, 1, 5, 1, '2020-07-10 16:31:17', NULL);
INSERT INTO `log` VALUES (297, 1, 5, 0, '2020-07-10 16:34:25', 188084);
INSERT INTO `log` VALUES (298, 1, 9, 1, '2020-07-12 22:17:29', NULL);
INSERT INTO `log` VALUES (299, 1, 9, 0, '2020-07-12 22:27:11', 581542);
INSERT INTO `log` VALUES (300, 27, 11, 1, '2020-07-13 18:11:08', NULL);
INSERT INTO `log` VALUES (301, 1, 11, 1, '2020-07-13 18:44:11', NULL);
INSERT INTO `log` VALUES (302, 1, 11, 0, '2020-07-13 18:46:07', 116253);
INSERT INTO `log` VALUES (303, 1, 10, 1, '2020-07-14 01:06:31', NULL);
INSERT INTO `log` VALUES (304, 1, 10, 0, '2020-07-14 17:57:22', 60650969);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (1, 1, 0, 1, 0, 0);
INSERT INTO `member` VALUES (2, 2, 0, 0, 0, 0);
INSERT INTO `member` VALUES (2, 1, 0, 0, 4, 16364449);
INSERT INTO `member` VALUES (5, 1, 0, 1, 26, 11331787);
INSERT INTO `member` VALUES (7, 1, 0, 1, 20, 63197064);
INSERT INTO `member` VALUES (3, 1, 0, 1, 12, 108367544);
INSERT INTO `member` VALUES (12, 1, 0, 1, 4, 26898187);
INSERT INTO `member` VALUES (13, 1, 0, 1, 10, 7425780);
INSERT INTO `member` VALUES (2, 13, 0, 1, 2, 75894);
INSERT INTO `member` VALUES (5, 13, 0, 1, 4, 88024205);
INSERT INTO `member` VALUES (3, 13, 0, 1, 2, 36305590);
INSERT INTO `member` VALUES (1, 13, 0, 0, 2, 1938788);
INSERT INTO `member` VALUES (9, 1, 0, 1, 14, 73151789);
INSERT INTO `member` VALUES (8, 1, 0, 1, 8, 63629189);
INSERT INTO `member` VALUES (2, 14, 0, 0, 2, 231379);
INSERT INTO `member` VALUES (10, 1, 0, 1, 14, 101228290);
INSERT INTO `member` VALUES (4, 1, 0, 1, 8, 11995058);
INSERT INTO `member` VALUES (6, 1, 0, 1, 6, 44781900);
INSERT INTO `member` VALUES (11, 1, 0, 1, 6, 24466992);
INSERT INTO `member` VALUES (11, 13, 0, 0, 2, 22811291);
INSERT INTO `member` VALUES (2, 15, 0, 0, 0, 0);
INSERT INTO `member` VALUES (14, 14, 0, 1, 0, 0);
INSERT INTO `member` VALUES (1, 2, 0, 1, 0, 0);
INSERT INTO `member` VALUES (1, 15, 0, 1, 0, 0);
INSERT INTO `member` VALUES (10, 16, 0, 1, 4, 1851669);
INSERT INTO `member` VALUES (7, 16, 0, 0, 2, 129875);
INSERT INTO `member` VALUES (4, 16, 0, 0, 2, 26820);
INSERT INTO `member` VALUES (2, 16, 0, 0, 2, 31889);
INSERT INTO `member` VALUES (10, 15, 0, 0, 2, 325558);
INSERT INTO `member` VALUES (3, 15, 1, 1, 1, 0);
INSERT INTO `member` VALUES (13, 13, 0, 1, 0, 0);
INSERT INTO `member` VALUES (4, 15, 0, 1, 0, 0);
INSERT INTO `member` VALUES (4, 13, 0, 1, 0, 0);
INSERT INTO `member` VALUES (4, 14, 0, 1, 0, 0);
INSERT INTO `member` VALUES (5, 18, 0, 0, 2, 716451);
INSERT INTO `member` VALUES (5, 19, 0, 0, 2, 72420);
INSERT INTO `member` VALUES (9, 20, 0, 1, 0, 0);
INSERT INTO `member` VALUES (12, 20, 0, 1, 0, 0);
INSERT INTO `member` VALUES (2, 20, 0, 0, 0, 0);
INSERT INTO `member` VALUES (10, 22, 0, 0, 2, 442214);
INSERT INTO `member` VALUES (9, 22, 0, 0, 2, 133033);
INSERT INTO `member` VALUES (2, 23, 1, 1, 1, 0);
INSERT INTO `member` VALUES (4, 22, 0, 0, 4, 279269400);
INSERT INTO `member` VALUES (9, 18, 0, 1, 0, 0);
INSERT INTO `member` VALUES (8, 22, 0, 0, 2, 3586);
INSERT INTO `member` VALUES (3, 24, 0, 0, 4, 119352392);
INSERT INTO `member` VALUES (6, 22, 0, 1, 0, 0);
INSERT INTO `member` VALUES (2, 25, 0, 1, 2, 284519);
INSERT INTO `member` VALUES (10, 24, 1, 0, 1, 0);
INSERT INTO `member` VALUES (13, 2, 0, 0, 0, 0);
INSERT INTO `member` VALUES (13, 2, 0, 0, 0, 0);
INSERT INTO `member` VALUES (13, 2, 0, 1, 0, 0);
INSERT INTO `member` VALUES (9, 15, 0, 0, 0, 0);
INSERT INTO `member` VALUES (13, 18, 0, 1, 0, 0);
INSERT INTO `member` VALUES (7, 18, 0, 1, 0, 0);
INSERT INTO `member` VALUES (11, 18, 0, 0, 0, 0);
INSERT INTO `member` VALUES (11, 2, 0, 1, 0, 0);
INSERT INTO `member` VALUES (5, 26, 0, 0, 2, 93504);
INSERT INTO `member` VALUES (11, 26, 0, 0, 2, 8257);
INSERT INTO `member` VALUES (10, 20, 0, 1, 0, 0);
INSERT INTO `member` VALUES (11, 27, 1, 0, 1, 0);
INSERT INTO `member` VALUES (15, 26, 0, 1, 0, 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, '化学实验室一', '岭南师范学院综合楼B911', 0);
INSERT INTO `room` VALUES (2, '生物解刨室', '岭南师范学院综合楼B913', 1);
INSERT INTO `room` VALUES (3, '微机操作实验室', '岭南师范学院综合楼B901', 1);
INSERT INTO `room` VALUES (4, 'Linux实验室', '岭南师范学院教三104', 1);
INSERT INTO `room` VALUES (5, '化学气压室', '岭南师范学院教三105', 1);
INSERT INTO `room` VALUES (6, '动物学实验室', '岭南师范学院教三106', 1);
INSERT INTO `room` VALUES (7, '微生物实验室', '岭南师范学院教三107', 1);
INSERT INTO `room` VALUES (8, '热学实验室', '岭南师范学院教三108', 1);
INSERT INTO `room` VALUES (9, '综合物理实验室', '岭南师范学院教三109', 1);
INSERT INTO `room` VALUES (10, '数据挖掘实验室', '岭南师范学院教三110', 1);
INSERT INTO `room` VALUES (11, '实验室B', '岭南师范学院实验室B', 1);
INSERT INTO `room` VALUES (12, '实验室demo', '地址demo', 1);
INSERT INTO `room` VALUES (13, '实验室A', '实验室A', 1);
INSERT INTO `room` VALUES (14, '实验室C', '岭南师范学院实验室C', 0);
INSERT INTO `room` VALUES (15, '化学综合实验室', '岭南师范学院化学综合实验室', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roomadmin
-- ----------------------------
INSERT INTO `roomadmin` VALUES (1, 1, 1, '本实验室明天9点到晚上17点将进行装修', '2020-01-05 08:00:00', 1);
INSERT INTO `roomadmin` VALUES (2, 2, 2, '本实验室明天9点到晚上17点将进行装修', '2020-01-05 09:00:00', 1);
INSERT INTO `roomadmin` VALUES (3, 2, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-15 13:31:43', 1);
INSERT INTO `roomadmin` VALUES (4, 3, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:06:35', 0);
INSERT INTO `roomadmin` VALUES (5, 4, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:06:55', 0);
INSERT INTO `roomadmin` VALUES (6, 5, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:07:13', 1);
INSERT INTO `roomadmin` VALUES (7, 6, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:07:23', 1);
INSERT INTO `roomadmin` VALUES (8, 7, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:07:37', 1);
INSERT INTO `roomadmin` VALUES (9, 8, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:07:47', 1);
INSERT INTO `roomadmin` VALUES (10, 9, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:07:57', 0);
INSERT INTO `roomadmin` VALUES (11, 10, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:08:07', 0);
INSERT INTO `roomadmin` VALUES (12, 11, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:08:19', 1);
INSERT INTO `roomadmin` VALUES (13, 12, 1, '本实验室明天9点到晚上17点将进行装修', '2020-06-16 01:08:35', 1);
INSERT INTO `roomadmin` VALUES (14, 12, 1, '公告demo', '2020-06-17 11:20:59', 0);
INSERT INTO `roomadmin` VALUES (15, 3, 1, '公告demo', '2020-06-17 17:30:12', 0);
INSERT INTO `roomadmin` VALUES (16, 3, 13, '来一条公告', '2020-06-18 14:45:30', 0);
INSERT INTO `roomadmin` VALUES (18, 13, 1, '来一条公告', '2020-06-20 15:42:08', 0);
INSERT INTO `roomadmin` VALUES (19, 13, 1, '来一条公告在实验室A', '2020-06-20 15:54:12', 0);
INSERT INTO `roomadmin` VALUES (20, 13, 1, '第二条公告', '2020-06-23 01:14:38', 1);
INSERT INTO `roomadmin` VALUES (21, 13, 1, 'null', '2020-06-23 01:45:09', 0);
INSERT INTO `roomadmin` VALUES (22, 12, 1, '第二条公告', '2020-06-23 01:57:26', 1);
INSERT INTO `roomadmin` VALUES (23, 12, 1, '第三条公告', '2020-06-24 00:24:41', 1);
INSERT INTO `roomadmin` VALUES (24, 3, 1, '来一条公告', '2020-06-28 01:38:02', 0);
INSERT INTO `roomadmin` VALUES (25, 4, 1, '来一条公告', '2020-06-28 02:54:25', 1);
INSERT INTO `roomadmin` VALUES (26, 9, 1, '来第二条公告', '2020-07-01 09:51:59', 1);
INSERT INTO `roomadmin` VALUES (27, 2, 1, '目前测试阶段，在我的页面下方可点击成为超级管理员解锁超管功能', '2020-07-01 19:44:10', 1);

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
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '15322533185', NULL, '陈龙', '0.00.0', 1);
INSERT INTO `user` VALUES (2, '18933573671', '3481723658@qq.com', '李华', '0.00.0', 2);
INSERT INTO `user` VALUES (13, '18028405303', NULL, '陈胖胖', NULL, 2);
INSERT INTO `user` VALUES (14, '15360157720', NULL, '周航', NULL, 2);
INSERT INTO `user` VALUES (15, '18933573672', NULL, '梅先英', NULL, 1);
INSERT INTO `user` VALUES (16, '15322533186', NULL, '王烁斌', NULL, 1);
INSERT INTO `user` VALUES (17, '13686861559', NULL, '王雨', NULL, 2);
INSERT INTO `user` VALUES (18, '13169181551', NULL, '刘锦生', NULL, 2);
INSERT INTO `user` VALUES (19, '18476837450', NULL, '吴鸿发', NULL, 1);
INSERT INTO `user` VALUES (20, '13542031513', NULL, '欧泽金', NULL, 2);
INSERT INTO `user` VALUES (22, '18211343520', NULL, '陆伟逊', NULL, 1);
INSERT INTO `user` VALUES (23, '18603228158', NULL, '许老师', NULL, 2);
INSERT INTO `user` VALUES (24, '13539825541', NULL, '张', NULL, 1);
INSERT INTO `user` VALUES (25, '13910656886', NULL, '郝奇', NULL, 1);
INSERT INTO `user` VALUES (26, '13005680397', NULL, '邵森', NULL, 1);
INSERT INTO `user` VALUES (27, '13650642116', NULL, '陈先生', NULL, 1);

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wxuser
-- ----------------------------
INSERT INTO `wxuser` VALUES (26, 'od6Es5AT-MRUoKUl6h8lHmW7Ft6A', 'S.', 'https://wx.qlogo.cn/mmopen/vi_32/Iy77C7T0bwvUQWMjQRBWzNgjiazTGP0cygE5DGfiaEhzoCE99T6jJLQPdkLBmyFO3nrPU2k9XKcMYAwWJULu4cow/132', '2020-07-10 16:27:15', '2020-07-10 16:27:15');
INSERT INTO `wxuser` VALUES (22, 'od6Es5AWK336EPVeVeOQEiK8xEFQ', '陆家三少', 'https://wx.qlogo.cn/mmopen/vi_32/ymj2Grr595Kt2OfibHYzKCPbzw74cjZMmq460Vu24u8FjgxCCLy671BD5dDh59JXHt2fuibgibP0uyxkwObUBbZrw/132', '2020-07-01 09:29:13', '2020-07-01 09:29:13');
INSERT INTO `wxuser` VALUES (NULL, 'od6Es5BIUKX_aGsuXHPUrr-NGZJI', '神经蛙', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q3auHgzwzM7wXlFfSDxn5Dr1DfiamkpA5oW66picFl6I8XYOfjjBBAcCR7LY6NSw4vfUrF5hGaD87zhjFaKm6SZA/132', '2020-07-15 09:15:06', '2020-07-15 09:15:06');
INSERT INTO `wxuser` VALUES (20, 'od6Es5CitAKXb_GDbtzJx66C4c6Q', 'Regain', 'https://wx.qlogo.cn/mmopen/vi_32/0ITbQ6rIVOm7SXvOLsOg46ibEKwJUUicqI5FXllKV5xBf0gTzbND9lEzTHkOKsTrZkXkpPOZTfOUaWgNsf6UyrxQ/132', '2020-06-30 19:34:26', '2020-06-30 19:34:26');
INSERT INTO `wxuser` VALUES (15, 'od6Es5Drw6hLknbgC71EPXU8nHBc', '梅先英', 'https://wx.qlogo.cn/mmopen/vi_32/dVfNDZrxLgZXjPagC4Hdia81HKDz6fHAm7xj0htzHzbDAzb9eovyg20PGe4aC8hqQE2jlAldJCC6ibFwfcSXfQRg/132', '2020-06-21 18:33:27', '2020-06-21 18:33:27');
INSERT INTO `wxuser` VALUES (25, 'od6Es5DzC7-OS5pbp24epajSHVjQ', '郝奇', 'https://thirdwx.qlogo.cn/mmopen/vi_32/Q3auHgzwzM5PFchBk4y6Nniah1E2TevYWJRRib1TFg047oYXmMRbG2YKqT88eOapj7nRkz5TmziaGhSEvo2khwE1Q/132', '2020-07-08 15:09:54', '2020-07-08 15:09:54');
INSERT INTO `wxuser` VALUES (27, 'od6Es5F1SnPA7n2JBu6NLyZwJh3Q', '钧哥CXY', 'https://wx.qlogo.cn/mmopen/vi_32/VFLAchic0YUWFSYTMrKY4icbPNhs9m8uTP8BOrf0qBqnYLiacfxnQYzozeSnzfaIialLoO8DMJ9RIYa0KmuvvYtwvg/132', '2020-07-13 17:55:24', '2020-07-13 17:55:24');
INSERT INTO `wxuser` VALUES (16, 'od6Es5GTBr3DnVNJ1gUUKbZDWbS0', 'Matthew.', 'https://wx.qlogo.cn/mmopen/vi_32/baHRzT5u1LTKEaIUaOH5XRZ8jxbPMNwYAILsBZWvuCEIjLLamawnficH4odWSzCxI1kXqvRTGbibfuGFnWOSgMSQ/132', '2020-06-23 23:10:10', '2020-06-23 23:10:10');
INSERT INTO `wxuser` VALUES (NULL, 'od6Es5GVBUSgbLaT_R9cBHyqdFxQ', 'Wang Ziyuan', 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83epgCWg7R9dvtyfr0n7iaibRM4RNIyHcCcYUNIbUiaftZ7b4S17DWzWeNBj3nMiaZvE4ibFfcJpNonxObuw/132', '2020-06-28 10:49:02', '2020-06-28 10:49:02');
INSERT INTO `wxuser` VALUES (13, 'od6Es5GYjg2bN0BjRo7tuXT5FFLs', '阿龙龙龙', 'https://wx.qlogo.cn/mmopen/vi_32/1Nu9LYj4CuRScCG2rovEYIQqG0DWiazuib7o4xAoaoO0ImW6icMUKs3pOy5TzTa79FaVv7JMPEnmcZ5naytxiaAyBA/132', '2020-06-16 12:10:08', '2020-06-16 12:10:08');
INSERT INTO `wxuser` VALUES (NULL, 'od6Es5IGwEyTIfuqQ7kK93tPme9Y', 'Richard Yang', 'https://wx.qlogo.cn/mmopen/vi_32/BINMXuV5icJAdPkueUoDoTMhwCWjWHlBz0ZplzSrd6JVx5A7QcMAPad9uNkO6EIicgF1AAgSqic7CUxP1ibHTibjM4w/132', '2020-07-09 23:22:40', '2020-07-09 23:22:40');
INSERT INTO `wxuser` VALUES (17, 'od6Es5Iw630iN0sr9T2HZGoGKwrE', 'W.Y', 'https://wx.qlogo.cn/mmopen/vi_32/gXOldSbLkcSAIPreklB9DmCPSpxoUWeMpJjLDK9FmGupXBkIbJAZuttA7ADEmvGc7IkZj1IrNs6CxXu1FAB8icA/132', '2020-06-24 17:17:56', '2020-06-24 17:17:56');
INSERT INTO `wxuser` VALUES (19, 'od6Es5JinJKP6_2W9m__TIxx1X3Y', '发', 'https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTL0IIsto47YAbxYsWZ9EgG9zT2mFqIonSpZAoLKRvtQT977T0gFh1LScnZzzTDCQwbpmCChI36UrA/132', '2020-06-30 19:28:40', '2020-06-30 19:28:40');
INSERT INTO `wxuser` VALUES (14, 'od6Es5JQizsE6wWHYStQg_KOAEgw', '『周航』', 'https://wx.qlogo.cn/mmopen/vi_32/cZN9xAaxlYGWbfCAl8TVfWYWg6ibsviakmEfuelIsmCuJq6Yhmv2WaEPXcCJQjz2iaR3UwObjn5WINsibPCDtR5NJA/132', '2020-06-19 18:35:21', '2020-06-19 18:35:21');
INSERT INTO `wxuser` VALUES (24, 'od6Es5KkvjNpAGFIyf7nqMZ90dSU', '张俊炜', 'https://wx.qlogo.cn/mmopen/vi_32/ocgrbCsOYxD8QnEzOfhibTYHbI6tZgccYwaBEhpG1BqzIjaxvE6xD9Pks70tS9YZeia2A5a1IHMtmk2YbXVUo2Pg/132', '2020-07-08 14:23:14', '2020-07-08 14:23:14');
INSERT INTO `wxuser` VALUES (18, 'od6Es5KnF3uInDohcQ6xy2e9dGcg', 'MM-时光票务', 'https://wx.qlogo.cn/mmopen/vi_32/ibkNANf6Ptbkyviaw4xibXnAibqzGcdDbREyunAibEIgDyvqA9B6AHwrorr9J8GSVcEhnXU0oClwXQZLOnibKmmJtTOg/132', '2020-06-30 19:25:51', '2020-06-30 19:25:51');
INSERT INTO `wxuser` VALUES (2, 'od6Es5L1Q6HvorEiUsa5N6eHlo5o', '+T', 'https://wx.qlogo.cn/mmopen/vi_32/U74glmWRaf6DibbSrPjy7OGr9MibkjvqX8YvRzcEPbMQRaJxjvuCqCoZqtwaMc5TAc91axBhtTLmCdtMdraRwZTg/132', '2020-02-03 08:00:00', '2020-01-02 08:00:00');
INSERT INTO `wxuser` VALUES (1, 'od6Es5NOTRaVHRvEZNnow2WLqN7Q', 'Morty㍿', 'https://wx.qlogo.cn/mmopen/vi_32/gzMS93L5HxDu7YgEUXqmrrXw6xBq8DnGKibtddgIBibpCHh6a9DGqtl40CswSNUnd3hH99wk8jSXgkZyeNeUpM0g/132', '2020-06-12 23:32:05', '2020-06-12 23:32:05');
INSERT INTO `wxuser` VALUES (23, 'od6Es5OZdrJPiihM3FTjDmuK_0lo', '会飞的大海', 'https://wx.qlogo.cn/mmopen/vi_32/YiacSiaYfNyFK4UokAJr9UxibX5m1iaZsP4SPNpNTfAbGgnKGrTTuziaZqhyfdqewUibUNS1kNVc51450jln277XnaicA/132', '2020-07-01 16:19:09', '2020-07-01 16:19:09');

SET FOREIGN_KEY_CHECKS = 1;
