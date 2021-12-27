

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for album
-- ----------------------------
DROP TABLE IF EXISTS `album`;
CREATE TABLE `album`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `album_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `release_time` datetime(0) NULL DEFAULT NULL,
  `artist_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`, `artist_id`) USING BTREE,
  INDEX `artist_id`(`artist_id`) USING BTREE,
  CONSTRAINT `album_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for artist
-- ----------------------------
DROP TABLE IF EXISTS `artist`;
CREATE TABLE `artist`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `artist_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for genre
-- ----------------------------
DROP TABLE IF EXISTS `genre`;
CREATE TABLE `genre`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `genre_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '体裁',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for playlist
-- ----------------------------
DROP TABLE IF EXISTS `playlist`;
CREATE TABLE `playlist`  (
  `id` bigint(20) NOT NULL,
  `playlist_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列表名称',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '所属用户',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_times` int(11) NULL DEFAULT NULL COMMENT '修改次数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `playlist_name`(`playlist_name`, `user_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `playlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用于存储播放列表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for playlist_song
-- ----------------------------
DROP TABLE IF EXISTS `playlist_song`;
CREATE TABLE `playlist_song`  (
  `playlist_id` bigint(20) NOT NULL COMMENT '列表id',
  `song_id` bigint(20) NOT NULL COMMENT '歌曲id',
  PRIMARY KEY (`playlist_id`, `song_id`) USING BTREE,
  INDEX `song_id`(`song_id`) USING BTREE,
  CONSTRAINT `playlist_song_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `playlist_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用于存储列表中的歌曲' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for rating
-- ----------------------------
DROP TABLE IF EXISTS `rating`;
CREATE TABLE `rating`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '1--歌曲  2--专辑   3--播放列表',
  `song_album_playlist_id` bigint(20) NULL DEFAULT NULL COMMENT '歌曲或者专辑或者播放列表id 弱关联',
  `rate` int(11) NULL DEFAULT NULL COMMENT '评分 1-5',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '评价时间',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '评价用户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for song
-- ----------------------------
DROP TABLE IF EXISTS `song`;
CREATE TABLE `song`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `song_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '歌曲名',
  `type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '1---专辑歌曲  2---单曲',
  `album_id` bigint(20) NULL DEFAULT NULL COMMENT '弱关联，为专辑歌曲时才使用此字段',
  `title` bigint(20) NULL DEFAULT NULL COMMENT 'artist_id  制作者 ',
  `covers` bigint(20) NULL DEFAULT NULL COMMENT 'artist_id 演唱者',
  `release_time` datetime(0) NULL DEFAULT NULL COMMENT '发行时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `title`(`title`) USING BTREE,
  INDEX `covers`(`covers`) USING BTREE,
  CONSTRAINT `song_ibfk_1` FOREIGN KEY (`title`) REFERENCES `artist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `song_ibfk_2` FOREIGN KEY (`covers`) REFERENCES `artist` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for song_genre
-- ----------------------------
DROP TABLE IF EXISTS `song_genre`;
CREATE TABLE `song_genre`  (
  `song_id` bigint(20) NOT NULL,
  `genre_id` bigint(20) NOT NULL,
  PRIMARY KEY (`song_id`, `genre_id`) USING BTREE,
  INDEX `genre_id`(`genre_id`) USING BTREE,
  CONSTRAINT `song_genre_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `song` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `song_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_name`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
