LOAD DATA LOCAL INFILE '/home/jvshahid/Documents/git/voegele/Marco/list_of_products.csv'
INTO TABLE colombia.products
Character set 'latin1'
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'  
IGNORE 1 LINES
(`SKU`,`SKU Description`,`UOM 1`,`UOM 2`, `Item Group`, `Old SKU`, @ItemClass, `????`, `?????`,	@UPCCode, @ItemsperUnit, @CurrencyID, @Weight, `Weight Units`, @Cube, `Cube Units`, @GrossWeight, `Units Gross Weight`)
set `Cube` = replace(@Cube, ",", ""),
`UPC Code`= Nullif (@UPCCode, ""),
`Item Class`= Nullif (@ItemClass, ""),
`Weight`= replace(@Weight, ",", ""),
`Gross Weight`= replace(@GrossWeight, ",", ""),
`Items per Unit`= replace(@ItemsperUnit, ",", ""),
`Currency ID`= replace(@CurrencyID, ",", "");
