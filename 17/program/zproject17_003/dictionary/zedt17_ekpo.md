# Table: ZEDT17_EKPO

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | ZMATNR | 4 |  | ZMATNR17 | ZMATNR17 | CHAR | 10 |  | - |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MENGE | 6 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | BPRME | 8 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 9 | PRDAT | 9 |  | PRDAT | DATUM | DATS | 8 |  | Date of last forecast |
| 10 | ZWERKS | 10 |  | ZWERKS17 | ZWERKS17 | CHAR | 4 |  | -# |
| 11 | ZLGORT | 11 |  | ZLGORT17 | ZLGORT17 | CHAR | 4 |  | - |
| 12 | STPRS | 12 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 13 | .INCLUDE | 13 |  | ZEDS17_002 |  |  | 0 |  | - |
| 14 | CRNAME | 14 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 15 | CRDATE | 15 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 16 | CRZEIT | 16 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 17 | AENAME | 17 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 18 | AEDATE | 18 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 19 | AEZEIT | 19 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
