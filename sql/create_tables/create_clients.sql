use colombia;

CREATE TABLE `clients` (
  `Sales Zone` text NOT NULL,
  `Client ID` int(11) NOT NULL,
  `Client ID 2` text NOT NULL,
  `Client Name 1` text NOT NULL,
  `Client Name 2` text NOT NULL,
  `Address` text,
  `Phone` text NOT NULL,
  `Invoice ID` text,
  `Sales Office ID` int(11) DEFAULT NULL,
  `Town` text NOT NULL,
  `Town Class` text NOT NULL,
  `Client Group` text NOT NULL,
  `DC` int(11) NOT NULL,
  `Channel` text NOT NULL,
  `Urban Flag` text NOT NULL,
  `Sales Type` text NOT NULL,
  `?` int(11) NOT NULL,
  `Special Status` text,
  `??` text NOT NULL,
  `???` int(20) DEFAULT NULL,
  `District` text,
  `Transport Area` text NOT NULL,
  `Transport Hub` int(11) DEFAULT NULL,
  `Field 4` text,
  `Date` date NOT NULL,
  `Credit Limit` int(11) NOT NULL,
  KEY `idx_clients_clientid` (`Client ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

