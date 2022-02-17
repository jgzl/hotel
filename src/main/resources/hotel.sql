/*
 Navicat Premium Data Transfer

 Source Server         : mysql7
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : localhost:3306
 Source Schema         : hotel

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 17/02/2022 20:46:25
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for check_in
-- ----------------------------
DROP TABLE IF EXISTS `check_in`;
CREATE TABLE `check_in` (
  `check_in_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '入住id',
  `order_id` int(11) NOT NULL COMMENT '订单号',
  `room_number` varchar(8) NOT NULL COMMENT '房间号',
  `room_type` varchar(16) NOT NULL COMMENT '房间类型',
  `peo_count` int(11) NOT NULL DEFAULT '1' COMMENT '入住人数',
  `persons` varchar(255) NOT NULL COMMENT '入住人',
  `ids` varchar(255) NOT NULL COMMENT '身份证号',
  `check_in_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入住时间',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`check_in_id`),
  UNIQUE KEY `uqe_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='入住退房登记表';

-- ----------------------------
-- Records of check_in
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for department_info
-- ----------------------------
DROP TABLE IF EXISTS `department_info`;
CREATE TABLE `department_info` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `departmen` varchar(16) NOT NULL DEFAULT '可用' COMMENT '部门',
  `remark` varchar(32) DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `uqe_status` (`departmen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门信息表';

-- ----------------------------
-- Records of department_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for hotel_info
-- ----------------------------
DROP TABLE IF EXISTS `hotel_info`;
CREATE TABLE `hotel_info` (
  `hotel_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '酒店id',
  `hotel_name` varchar(16) NOT NULL COMMENT '酒店名',
  `phone` varchar(16) DEFAULT NULL COMMENT '手机号',
  `telephone` varchar(16) NOT NULL COMMENT '电话号码',
  `email` varchar(16) NOT NULL COMMENT '电子邮箱',
  `address` varchar(32) NOT NULL COMMENT '地址',
  `website` varchar(16) NOT NULL COMMENT '网站',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`hotel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='酒店信息表';

-- ----------------------------
-- Records of hotel_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单号',
  `order_type` varchar(8) NOT NULL COMMENT '预订方式',
  `phone` varchar(16) NOT NULL COMMENT '手机号',
  `room_type` varchar(16) NOT NULL COMMENT '房间类型',
  `num_of_room` int(11) NOT NULL DEFAULT '1' COMMENT '房间数',
  `order_date` date NOT NULL COMMENT '预订日期',
  `order_days` int(11) NOT NULL DEFAULT '1' COMMENT '预定天数',
  `order_status` int(11) NOT NULL DEFAULT '0' COMMENT '订单状态:0-已下单，1-已付款，2-已消费，-1-已取消，-2-被删除',
  `order_cost` double NOT NULL COMMENT '订单费用',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单信息表';

-- ----------------------------
-- Records of order_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_type
-- ----------------------------
DROP TABLE IF EXISTS `order_type`;
CREATE TABLE `order_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'typeId',
  `type` varchar(16) NOT NULL COMMENT '方式',
  `remark` varchar(32) DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预订方式表';

-- ----------------------------
-- Records of order_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for room_info
-- ----------------------------
DROP TABLE IF EXISTS `room_info`;
CREATE TABLE `room_info` (
  `room_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '房间id',
  `room_number` varchar(8) NOT NULL COMMENT '房间号码',
  `type_id` int(11) NOT NULL COMMENT '房间类型ID',
  `room_type` varchar(16) NOT NULL COMMENT '房间类型',
  `room_price` double NOT NULL DEFAULT '0' COMMENT '房间价格',
  `room_discount` double NOT NULL DEFAULT '0' COMMENT '房间折扣',
  `room_status` int(11) NOT NULL DEFAULT '1' COMMENT '房间状态:1-可预订，0-已被预订，-1：已入住，-2：不可用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `uqe_room_number` (`room_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='房间信息表';

-- ----------------------------
-- Records of room_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type` (
  `type_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `room_type` varchar(16) NOT NULL COMMENT '类型名',
  `remark` varchar(128) DEFAULT NULL COMMENT '房型备注',
  `price` double NOT NULL DEFAULT '0' COMMENT '预定价格',
  `discount` double NOT NULL COMMENT '预定折扣',
  `area` int(11) NOT NULL DEFAULT '12' COMMENT '房间大小:m2',
  `bed_num` int(11) NOT NULL DEFAULT '1' COMMENT '床位',
  `bed_size` varchar(16) NOT NULL DEFAULT '1.5m*1.8m' COMMENT '床位大小',
  `window` int(11) NOT NULL DEFAULT '0' COMMENT '是否有窗：0-无，1-有',
  `rest` int(11) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `uqe_room_type` (`room_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='房间类型表';

-- ----------------------------
-- Records of room_type
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(16) NOT NULL COMMENT '用户名',
  `password` varchar(256) NOT NULL COMMENT '密码',
  `name` varchar(16) NOT NULL COMMENT '姓名',
  `gender` char(2) NOT NULL DEFAULT '男' COMMENT '性别',
  `phone` varchar(16) NOT NULL COMMENT '手机号码',
  `email` varchar(16) DEFAULT NULL COMMENT '邮箱地址',
  `address` varchar(32) DEFAULT NULL COMMENT '地址',
  `idcard` varchar(32) NOT NULL COMMENT '身份证号码',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uqe_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='注册用户信息表';

-- ----------------------------
-- Records of user_info
-- ----------------------------
BEGIN;
INSERT INTO `user_info` VALUES (1, 'consumer1', 'e10adc3949ba59abbe56e057f20f883e', '消费者1', '男', '17621000000', 'admin@admin.cn', '北京', '00000001', '2022-02-17 12:36:00', '2022-02-17 12:37:50');
COMMIT;

-- ----------------------------
-- Table structure for worker_info
-- ----------------------------
DROP TABLE IF EXISTS `worker_info`;
CREATE TABLE `worker_info` (
  `worker_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '操作员id',
  `role` varchar(8) NOT NULL DEFAULT 'worker' COMMENT '角色:worker/admin',
  `username` varchar(16) NOT NULL COMMENT '用户名',
  `password` varchar(256) NOT NULL COMMENT '密码',
  `name` varchar(8) NOT NULL COMMENT '姓名',
  `gender` char(2) NOT NULL DEFAULT '男' COMMENT '性别',
  `phone` varchar(16) NOT NULL COMMENT '手机号码',
  `department` int(11) DEFAULT NULL COMMENT '部门',
  `email` varchar(16) DEFAULT NULL COMMENT '邮箱地址',
  `address` varchar(32) DEFAULT NULL COMMENT '地址',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`worker_id`),
  UNIQUE KEY `uqe_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='工作人员信息表';

-- ----------------------------
-- Records of worker_info
-- ----------------------------
BEGIN;
INSERT INTO `worker_info` VALUES (1, 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '超级管理员', '男', '17621000000', 1, 'admin@admin.cn', '北京', '2022-02-17 12:39:31', '2022-02-17 12:40:56');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
