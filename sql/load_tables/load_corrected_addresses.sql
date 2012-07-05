-- ALTER TABLE `colombia`.`clients` CHANGE COLUMN `Client ID` `Client ID` TEXT NOT NULL
-- , ADD PRIMARY KEY (`Client ID`(256));

-- truncate colombia.clients;
LOAD DATA LOCAL INFILE '/home/jvshahid/Documents/git/voegele/Marco/list_of_corrected_addresses_1.csv'
INTO TABLE colombia.corrected_addresses
Character set 'latin1'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`ClientID`, `ClientName`, `Address`, `CorrectedAddress`, Town, Country, @long_lat)
Set `MarcoLatitude`=SUBSTRING_INDEX(@long_lat, ',', 1),
    `MarcoLongtitude`=SUBSTRING_INDEX(@long_lat, ',', -1),
    `Longtitude`=NULL,
    `Latitude`=NULL;
