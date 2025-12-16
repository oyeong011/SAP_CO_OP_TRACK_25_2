# Table: ZEDT25_ZEKPO

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 |  | ZMATNR25 | ZMATNR25 | CHAR | 10 |  | - |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MENGE | 6 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | PRDAT | 8 |  | PRDAT | DATUM | DATS | 8 |  | Date of last forecast |
| 9 | WERKS | 9 |  | ZWERKS25 | ZWERKS25 | CHAR | 4 |  | Plant |
| 10 | LGORT | 10 |  | ZLGORT25 | ZLGORT25 | CHAR | 4 |  | - |
| 11 | STPRS | 11 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 12 | BPRME | 12 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
