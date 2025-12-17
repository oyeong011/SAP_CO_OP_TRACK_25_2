# Table: ZEKPO_22

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 |  | ZMATNR22 | ZMATNR22 | CHAR | 10 |  | - |
| 5 | MAKTX | 5 |  | ZMATNAME22 |  | CHAR | 20 |  | -# |
| 6 | MENGE | 6 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | STPRS | 8 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 9 | PRDAT | 9 |  | PREDT | DATUM | DATS | 8 |  | Date of Price Determination |
| 10 | WERKS | 10 |  | ZWERKS22 | ZWERKS22 | CHAR | 4 |  | -# |
| 11 | LGORT | 11 |  | ZLGORT22 | ZLGORT22 | CHAR | 4 |  | - |
| 12 | MWSKZ | 12 |  | ZMWSKZ22 | ZMWSKZ22 | CHAR | 2 |  | - |
| 13 | BPRME | 13 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
