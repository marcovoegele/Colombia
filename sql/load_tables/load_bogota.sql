-- Create index idx_clientid on colombia.bogota (`Client ID`);
-- Create index `idx_ordered quantity` on colombia.bogota (`Ordered Quantity`);


LOAD DATA LOCAL INFILE '/home/jvshahid/Documents/git/voegele/Marco/bogota_first_100.csv'
INTO TABLE colombia.bogota
Character set 'latin1'
FIELDS TERMINATED BY '|'
IGNORE 1 LINES
(`Sales Organization`,`Distribution Channel ID`,`Sector`,@InvoiceDate,`Client ID`,`Client name`,`Salesperson ID`,`Salesperson Name`,`Invoice`, @DeliveryDate,@ShipmentDocumentNo.,`SKU`,`Location`,@OrderedQuantity,`Net Price`,@DeliveryQuantity,@DeltaOrderedDelivery,`UOM`,`Currency`,@Cartons, @EquivalentCartons,`Net Price Delivered`,`Client Group`,@ReturnQuantity,`Returned Price`,`Net Price After Returns`,`Sales Area`,@NetQuantity,@NetCartons,`DC`,`Route ID`,@RejectedID,`Rejection Description`, `City Code`)
Set `Invoice Date`=STR_TO_DATE(@InvoiceDate, "%d/%m/%Y"),
`Delivery Date`=STR_TO_DATE(@DeliveryDate, "%d/%m/%Y"),
`Cartons`= replace(replace(@Cartons, ".", ""),",","."),
`Delivery Quantity`= replace(replace(@DeliveryQuantity, ".", ""),",","."),
`Net Quantity`= replace(replace(@NetQuantity, ".", ""),",","."),
`Return Quantity`= replace(replace(@ReturnQuantity, ".", ""),",","."),
`Ordered Quantity`= replace(replace(@OrderedQuantity, ".", ""),",","."),
`Delta Ordered - Delivery`= replace(replace(@DeltaOrderedDelivery, ".", ""),",","."),
`Equivalent Cartons`= replace(replace(@EquivalentCartons, ".", ""),",","."),
`Net Cartons`= replace(replace(@NetCartons, ".", ""),",","."),
`Rejected ID`= Nullif(@RejectedID, ""),
`Shipment Document No.`= Nullif(@ShipmentDocumentNo., "");
