# Table: ZEKPO_15

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 |  | ZMATNR15 | ZMATNR15 | CHAR | 10 |  | - |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MENGE | 6 |  | BSTMG | MENG13 | QUAN | 13 |  | Purchase Order Quantity |
| 7 | WEMNG | 7 |  | WEMNG | MENG13 | QUAN | 13 |  | Quantity of Goods Received |
| 8 | MEINS | 8 |  | BSTME | MEINS | UNIT | 3 | X | Purchase Order Unit of Measure |
| 9 | STPRS | 9 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 10 | PRDAT | 10 |  | PREDT | DATUM | DATS | 8 |  | Date of Price Determination |
| 11 | WERKS | 11 |  | ZWERKS15 | ZWERKS15 | CHAR | 4 |  | -# |
| 12 | LGORT | 12 |  | ZLGORT15 | ZLGORT15 | CHAR | 4 |  | - |
| 13 | ELIKZ | 13 |  | ELIKZ | XFELD | CHAR | 1 |  | "Delivery Completed" Indicator |
