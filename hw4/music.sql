
-- ----------------------------
-- Table structure for artists
-- ----------------------------
DROP TABLE IF EXISTS `artists`;
CREATE TABLE `artists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `artist_name` (`artist_name`)
);

-- ----------------------------
-- Records of artists
-- ----------------------------
BEGIN;
INSERT INTO `artists` VALUES (3, 'Alan Walker');
INSERT INTO `artists` VALUES (4, 'Chainsmokers');
INSERT INTO `artists` VALUES (1, 'Jay Chou');
INSERT INTO `artists` VALUES (5, 'Maroon 5');
INSERT INTO `artists` VALUES (6, 'Martin Garrix');
INSERT INTO `artists` VALUES (2, 'Taylor Swift');
COMMIT;

-- ----------------------------
-- Table structure for albums
-- ----------------------------
DROP TABLE IF EXISTS `albums`;
CREATE TABLE `albums` (
  `id` int NOT NULL AUTO_INCREMENT,
  `album_name` varchar(50) NOT NULL,
  `release_date` date NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `albums_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`)
); 

-- ----------------------------
-- Records of albums
-- ----------------------------
BEGIN;
INSERT INTO `albums` VALUES (1, 'Different World', '2018-12-14', 3);
INSERT INTO `albums` VALUES (2, 'Darkside', '2018-07-27', 3);
INSERT INTO `albums` VALUES (3, 'V', '2014-06-16', 5);
INSERT INTO `albums` VALUES (4, 'JORDI', '2021-03-03', 5);
INSERT INTO `albums` VALUES (5, 'Overexposed', '2012-06-20', 5);
INSERT INTO `albums` VALUES (6, 'folklore', '2020-07-24', 2);
INSERT INTO `albums` VALUES (7, 'reputation', '2017-09-03', 2);
INSERT INTO `albums` VALUES (8, 'Qi Li Xiang', '2004-08-03', 1);
INSERT INTO `albums` VALUES (9, 'Deng Ni Xia Ke', '2018-07-19', 1);
INSERT INTO `albums` VALUES (10, 'Collage', '2016-09-04', 4);
INSERT INTO `albums` VALUES (11, 'World War Joy', '2019-12-06', 4);
INSERT INTO `albums` VALUES (12, 'Sick Boy', '2018-01-17', 4);
INSERT INTO `albums` VALUES (13, 'Ocean', '2018-06-15', 6);
INSERT INTO `albums` VALUES (14, 'Dont Look Down', '2015-03-17', 6);
INSERT INTO `albums` VALUES (15, 'Girls Like You', '2018-05-30', 5);
COMMIT;

-- ----------------------------
-- Table structure for genres
-- ----------------------------
DROP TABLE IF EXISTS `genres`;
CREATE TABLE `genres` (
  `id` int NOT NULL AUTO_INCREMENT,
  `genre` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
); 

-- ----------------------------
-- Records of genres
-- ----------------------------
BEGIN;
INSERT INTO `genres` VALUES (1, 'Pop');
INSERT INTO `genres` VALUES (2, 'Electronic');
INSERT INTO `genres` VALUES (3, 'Alternative');
INSERT INTO `genres` VALUES (4, 'Dance');
INSERT INTO `genres` VALUES (5, 'Funk');
COMMIT;

-- ----------------------------
-- Table structure for songs
-- ----------------------------
DROP TABLE IF EXISTS `songs`;
CREATE TABLE `songs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `song_title` varchar(20) NOT NULL,
  `type` varchar(2) NOT NULL,
  `release_date` date NOT NULL,
  `artist_id` int NOT NULL,
  `album_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `songs_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`id`),
  CONSTRAINT `songs_ibfk_2` FOREIGN KEY (`album_id`) REFERENCES `albums` (`id`)
); 
-- ----------------------------
-- Records of songs
-- ----------------------------
BEGIN;
INSERT INTO `songs` VALUES (1, 'Maps', '1', '2014-06-16', 5, 3);
INSERT INTO `songs` VALUES (2, 'Animals', '1', '2014-06-16', 5, 3);
INSERT INTO `songs` VALUES (3, 'Sugar', '1', '2014-06-16', 5, 3);
INSERT INTO `songs` VALUES (4, 'Payphone', '1', '2012-06-20', 5, 5);
INSERT INTO `songs` VALUES (5, 'Daylight', '1', '2012-06-20', 5, 5);
INSERT INTO `songs` VALUES (6, 'Ocean', '2', '2018-06-15', 6, 13);
INSERT INTO `songs` VALUES (7, 'Sick Boy', '2', '2018-01-17', 4, 12);
INSERT INTO `songs` VALUES (8, 'Lost Control', '1', '2018-12-14', 3, 1);
INSERT INTO `songs` VALUES (9, 'Lily', '1', '2018-12-14', 3, 1);
INSERT INTO `songs` VALUES (10, 'Darkside', '2', '2018-07-27', 3, 2);
INSERT INTO `songs` VALUES (11, 'Beautiful mistakes', '1', '2021-03-04', 5, 3);
INSERT INTO `songs` VALUES (12, 'Lost', '1', '2021-03-05', 5, 3);
INSERT INTO `songs` VALUES (13, 'the 1', '1', '2020-07-25', 2, 6);
INSERT INTO `songs` VALUES (14, 'cardigan', '1', '2020-07-26', 2, 6);
INSERT INTO `songs` VALUES (15, 'Ready for it', '1', '2017-09-04', 2, 7);
INSERT INTO `songs` VALUES (16, 'Delicate', '1', '2017-09-05', 2, 7);
INSERT INTO `songs` VALUES (17, 'Qi Li Xiang', '2', '2004-08-03', 1, 8);
INSERT INTO `songs` VALUES (18, 'Deng Ni Xia Ke', '2', '2018-07-20', 1, 9);
INSERT INTO `songs` VALUES (19, 'Girls Like You', '2', '2018-05-31', 5, 15);
COMMIT;


-- ----------------------------
-- Table structure for song_genre
-- ----------------------------
DROP TABLE IF EXISTS `song_genre`;
CREATE TABLE `song_genre` (
  `song_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`song_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `song_genre_ibfk_1` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`),
  CONSTRAINT `song_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
); 

-- ----------------------------
-- Records of song_genre
-- ----------------------------
BEGIN;
INSERT INTO `song_genre` VALUES (1, 1);
INSERT INTO `song_genre` VALUES (2, 1);
INSERT INTO `song_genre` VALUES (5, 1);
INSERT INTO `song_genre` VALUES (8, 1);
INSERT INTO `song_genre` VALUES (11, 1);
INSERT INTO `song_genre` VALUES (12, 1);
INSERT INTO `song_genre` VALUES (6, 2);
INSERT INTO `song_genre` VALUES (9, 2);
INSERT INTO `song_genre` VALUES (10, 2);
INSERT INTO `song_genre` VALUES (4, 3);
INSERT INTO `song_genre` VALUES (13, 3);
INSERT INTO `song_genre` VALUES (14, 3);
INSERT INTO `song_genre` VALUES (17, 3);
INSERT INTO `song_genre` VALUES (18, 3);
INSERT INTO `song_genre` VALUES (3, 4);
INSERT INTO `song_genre` VALUES (7, 4);
INSERT INTO `song_genre` VALUES (12, 5);
INSERT INTO `song_genre` VALUES (15, 5);
INSERT INTO `song_genre` VALUES (16, 5);
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
); 

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (2, 'Christnina');
INSERT INTO `users` VALUES (4, 'Jennie');
INSERT INTO `users` VALUES (5, 'Josh');
INSERT INTO `users` VALUES (1, 'Lyon');
INSERT INTO `users` VALUES (6, 'Mike');
INSERT INTO `users` VALUES (3, 'Steven');
COMMIT;

-- ----------------------------
-- Table structure for playlists
-- ----------------------------
DROP TABLE IF EXISTS `playlists`;
CREATE TABLE `playlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `playlist_title` varchar(50) NOT NULL,
  `created_date` date NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `playlist_title` (`playlist_title`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `playlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
); 

-- ----------------------------
-- Records of playlists
-- ----------------------------
BEGIN;
INSERT INTO `playlists` VALUES (1, 'Favorite', '2021-01-01', 1);
INSERT INTO `playlists` VALUES (2, 'Alan', '2010-01-01', 2);
INSERT INTO `playlists` VALUES (3, 'Zhou', '2013-01-01', 1);
INSERT INTO `playlists` VALUES (4, 'Chains', '2004-01-01', 3);
INSERT INTO `playlists` VALUES (5, 'Taylor', '1996-01-01', 4);
INSERT INTO `playlists` VALUES (6, 'relax', '1990-01-01', 5);
COMMIT;

-- ----------------------------
-- Table structure for playlist_song
-- ----------------------------
DROP TABLE IF EXISTS `playlist_song`;
CREATE TABLE `playlist_song` (
  `playlist_id` int NOT NULL,
  `song_id` int NOT NULL,
  PRIMARY KEY (`playlist_id`,`song_id`),
  KEY `song_id` (`song_id`),
  CONSTRAINT `playlist_song_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `playlists` (`id`),
  CONSTRAINT `playlist_song_ibfk_2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`id`)
); 

-- ----------------------------
-- Records of playlist_song
-- ----------------------------
BEGIN;
INSERT INTO `playlist_song` VALUES (6, 1);
INSERT INTO `playlist_song` VALUES (1, 5);
INSERT INTO `playlist_song` VALUES (6, 5);
INSERT INTO `playlist_song` VALUES (4, 7);
INSERT INTO `playlist_song` VALUES (2, 8);
INSERT INTO `playlist_song` VALUES (2, 9);
INSERT INTO `playlist_song` VALUES (1, 10);
INSERT INTO `playlist_song` VALUES (2, 10);
INSERT INTO `playlist_song` VALUES (5, 13);
INSERT INTO `playlist_song` VALUES (5, 14);
INSERT INTO `playlist_song` VALUES (6, 14);
INSERT INTO `playlist_song` VALUES (1, 15);
INSERT INTO `playlist_song` VALUES (5, 15);
INSERT INTO `playlist_song` VALUES (5, 16);
INSERT INTO `playlist_song` VALUES (3, 17);
INSERT INTO `playlist_song` VALUES (6, 17);
INSERT INTO `playlist_song` VALUES (3, 18);
COMMIT;

-- ----------------------------
-- Table structure for ratings
-- ----------------------------
DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(2) NOT NULL,
  `rating` tinyint NOT NULL,
  `created_date` date NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
); 
-- ----------------------------
-- Records of ratings
-- ----------------------------
BEGIN;
COMMIT;