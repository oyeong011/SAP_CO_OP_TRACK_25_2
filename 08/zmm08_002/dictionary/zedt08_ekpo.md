# Table: ZEDT08_EKPO

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MENGE | 6 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | BPRME | 8 |  | NETPR | WERTV6 | CURR | 11 |  | Net price |
| 9 | PRDAT | 9 |  | PRDAT | DATUM | DATS | 8 |  | Date of last forecast |
| 10 | WERKS | 10 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 11 | LGORT | 11 |  | LGORT_D | LGORT | CHAR | 4 |  | Storage Location |
| 12 | .INCLUDE | 12 |  | ZEDS08_002 |  |  | 0 |  | - |
| 13 | CRNAME | 13 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 14 | CRDATE | 14 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 15 | CRZEIT | 15 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 16 | AENAME | 16 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 17 | AEDATE | 17 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 18 | AEZEIT | 18 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
