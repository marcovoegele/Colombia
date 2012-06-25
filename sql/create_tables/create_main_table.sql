use colombia;

CREATE TABLE `main_table` (
  `Client ID` int(100) NOT NULL,
  `SKU` int(100) NOT NULL,
  `No. of SKU` int(100) NOT NULL,
  `Sum of Ordered Quantity` double NOT NULL,
  `Sum of Delivery Quantity` double NOT NULL,
  `Sum of Return Quantity` double NOT NULL,
  `Rejected ID` double DEFAULT NULL,
  `Sum of Net price delivered` double NOT NULL,
  `Sum of Net Price after returns` double NOT NULL,
  `Sum of Net Cartons` double NOT NULL,
  KEY `bogota_client_id` (`Client ID`),
  KEY `idx_clientid` (`Client ID`),
  KEY `idx_SKU` (`SKU`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

