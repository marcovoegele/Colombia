-- ALTER TABLE `colombia`.`clients` CHANGE COLUMN `Client ID` `Client ID` TEXT NOT NULL
-- , ADD PRIMARY KEY (`Client ID`(256));

-- truncate colombia.clients;
LOAD DATA LOCAL INFILE '/home/jvshahid/Documents/git/voegele/Marco/list_of_clients.csv'
INTO TABLE colombia.clients
Character set 'latin1'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`Sales Zone`, @ClientID, `Client Name 1`, `Client Name 2`, @Address, @Phone, @InvoiceID, @SalesOfficeID, `Town`, `Town Class`, `Client Group`, `DC`, `Channel`, `Urban Flag`, `Sales Type`, `?`, `Special Status`, `??`, @`???`, `District`, `Transport Area`, @TransportHub, `Field 4`, @Date, @CreditLimit)
Set `Date`=STR_TO_DATE(@Date, "%d/%m/%Y"),
`Credit Limit`= replace(@CreditLimit, ",", ""),
`Client ID`= @ClientID,
`Client ID 2`= @ClientID,
`Phone`= replace(@Phone, "- ()", ""),
`Invoice ID`= replace(@InvoiceID, "- ()", ""),
`Invoice ID`= Nullif(@InvoiceID, ""),
`Transport Hub`= Nullif(@TransportHub, ""),
`Address`= Nullif(@Address, ""),
`Sales Office ID`= Nullif(@SalesOfficeID, ""),
`???`= Nullif(@`???`, "");

use colombia;
SET SQL_SAFE_UPDATES=0;
delete from colombia.clients where `Client ID` = 0;
