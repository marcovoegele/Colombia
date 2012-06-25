use colombia;

CREATE TABLE `corrected_addresses` (
  `ClientID` int(11) NOT NULL,
  `ClientName` int(11) NOT NULL,
  `Address` text NOT NULL,
  `Town` text NOT NULL,
  `Country` text NOT NULL,
  `CorrectedAddress` text NOT NULL,
  `MarcoLatitude` double NOT NULL,
  `MarcoLongtitude` double NOT NULL,
  `Latitude` double,
  `Longtitude` double
) ENGINE=InnoDB DEFAULT CHARSET=latin1

