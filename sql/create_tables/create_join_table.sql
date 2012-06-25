use colombia;

CREATE TABLE `join_table` (
  `Client ID` int(100) NOT NULL,
  `Client name 1` text,
  `SKU` int(100) NOT NULL,
  `No. of SKU` int(100) NOT NULL,
  `Sum of Ordered Quantity` double NOT NULL,
  `Sum of Delivery Quantity` double NOT NULL,
  `Sum of Return Quantity` double NOT NULL,
  `Rejected ID` double DEFAULT NULL,
  `Sum of Net Cartons` double NOT NULL,
  `Sum of Net price delivered` double NOT NULL,
  `Sum of Net Price after returns` double NOT NULL,
  `DC` int(11) DEFAULT NULL,
  `Channel` text,
  `Town` text,
  KEY `idx_clientid` (`Client ID`),
  KEY `idx_SKU` (`SKU`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
