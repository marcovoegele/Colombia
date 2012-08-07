use colombia;

CREATE TABLE IF NOT EXISTS `clients_distances` (
  `client_1_id` int(11) NOT NULL,
  `client_2_id` int(11) NOT NULL,
  `distance` float DEFAULT NULL,
  `time` float DEFAULT NULL,
  UNIQUE KEY `clients_distance_1_2` (`client_1_id`,`client_2_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `distance_for_clients` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

