use colombia;

CREATE TABLE `products` (
  `SKU` int(11) NOT NULL,
  `SKU Description` text NOT NULL,
  `UOM 1` text NOT NULL,
  `UOM 2` text NOT NULL,
  `Item Group` int(11) NOT NULL,
  `Old SKU` text NOT NULL,
  `Item Class` int(11) DEFAULT NULL,
  `????` int(11) NOT NULL,
  `?????` int(11) NOT NULL,
  `UPC Code` double DEFAULT NULL,
  `Items per Unit` int(11) NOT NULL,
  `Currency ID` int(11) NOT NULL,
  `Weight` double NOT NULL,
  `Weight Units` text NOT NULL,
  `Cube` double NOT NULL,
  `Cube Units` text NOT NULL,
  `Gross Weight` double NOT NULL,
  `Units Gross Weight` text NOT NULL,
  KEY `idx_products_sku` (`SKU`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1

