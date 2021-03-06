use colombia;

CREATE TABLE `bogota` (
  `Sales Organization` int(11) NOT NULL,
  `Distribution Channel ID` int(11) NOT NULL,
  `Sector` int(11) NOT NULL,
  `Invoice Date` date NOT NULL,
  `Client ID` int(11) NOT NULL,
  `Client name` text NOT NULL,
  `Salesperson ID` int(11) NOT NULL,
  `Salesperson name` text NOT NULL,
  `Invoice` int(11) NOT NULL,
  `Delivery Date` date NOT NULL,
  `Shipment Document no.` int(11) DEFAULT NULL,
  `SKU` int(11) NOT NULL,
  `Location` int(11) NOT NULL,
  `Ordered Quantity` double NOT NULL,
  `Net Price` int(11) NOT NULL,
  `Delivery Quantity` double NOT NULL,
  `Delta Ordered - Delivery` double NOT NULL,
  `UOM` text NOT NULL,
  `Currency` text NOT NULL,
  `Cartons` double NOT NULL,
  `Equivalent Cartons` double NOT NULL,
  `Net price delivered` int(11) NOT NULL,
  `Client Group` text NOT NULL,
  `Return Quantity` double NOT NULL,
  `Returned Price` int(11) NOT NULL,
  `Net Price after returns` int(11) NOT NULL,
  `Sales Area` int(11) NOT NULL,
  `Net Quantity` double NOT NULL,
  `Net Cartons` double NOT NULL,
  `DC` text NOT NULL,
  `Route ID` text NOT NULL,
  `Rejected ID` int(11) DEFAULT NULL,
  `Rejection description` text NOT NULL,
  `City code` int(11) NOT NULL,
  KEY `bogota_client_id` (`Client ID`),
  KEY `idx_orderedquantity` (`Ordered Quantity`),
  KEY `orderedquantity_idx` (`Ordered Quantity`),
  KEY `idx_clientid` (`Client ID`),
  KEY `idx_ordered quantity` (`Ordered Quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
