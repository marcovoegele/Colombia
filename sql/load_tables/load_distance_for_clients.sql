-- Create index idx_clientid on colombia.bogota (`Client ID`);
-- Create index `idx_ordered quantity` on colombia.bogota (`Ordered Quantity`);


LOAD DATA LOCAL INFILE '/home/jvshahid/Downloads/distance_for_clients.csv'
INTO TABLE colombia.distance_for_clients
Character set 'latin1'
FIELDS TERMINATED BY ','
-- IGNORE 1 LINES
(client_id);
