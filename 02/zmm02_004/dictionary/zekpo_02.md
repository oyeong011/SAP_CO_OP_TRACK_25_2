# Table: ZEKPO_02

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 |  | ZMATNR02 | ZMATNR02 | CHAR | 10 |  | - |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MENGE | 6 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | BPRME | 8 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 9 | PRDAT | 9 |  | PRDAT | DATUM | DATS | 8 |  | Date of last forecast |
| 10 | WERKS | 10 |  | ZWERKS02 | ZWERKS02 | CHAR | 4 |  | -# |
| 11 | LGORT | 11 |  | ZLGORT02 | ZLGORT02 | CHAR | 4 |  | - |
| 12 | STPRS | 12 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
