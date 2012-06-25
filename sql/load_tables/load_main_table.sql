truncate colombia.main_table;

insert into colombia.main_table (`Client ID`, `SKU`, `No. of SKU`, `Sum of Ordered Quantity`, `Sum of Delivery Quantity`, `Sum of Return Quantity`, `Rejected ID`, `Sum of Net price delivered`, `Sum of Net Price after returns`, `Sum of Net Cartons`)
Select `Client ID`, `SKU`, count(`SKU`), sum(`Ordered Quantity`), sum(`Delivery Quantity`) , sum(`Return Quantity`), `Rejected ID`, sum(`Net price Delivered`), sum(`Net Price after returns`), sum(`Net Cartons`)
from colombia.bogota group by `Client ID`, `SKU`;
