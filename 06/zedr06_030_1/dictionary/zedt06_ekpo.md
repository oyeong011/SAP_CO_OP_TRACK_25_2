# Table: ZEDT06_EKPO

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 |  | ZMATNR06 | ZMATNR06 | CHAR | 10 |  | - |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MENGE | 6 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | BPRME | 8 |  | NETPR | WERTV6 | CURR | 11 |  | Net price |
| 9 | PRDAT | 9 |  | PRDAT | DATUM | DATS | 8 |  | Date of last forecast |
| 10 | WERKS | 10 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 11 | LGORT | 11 |  | LGORT_D | LGORT | CHAR | 4 |  | Storage Location |
