# Table: ZMARA25

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | WERKS | 2 | X | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 3 | LGORT | 3 | X | ZLGORT25 | ZLGORT25 | CHAR | 4 |  | - |
| 4 | ZMATNR | 4 | X | ZMATNR25 | ZMATNR25 | CHAR | 10 |  | - |
| 5 | ZMATNAME | 5 |  | ZMATNAME25 | ZMATNAME25 | CHAR | 20 |  | -# |
| 6 | ZMTART | 6 |  | ZMTART25_02 | ZMTART25_02 | CHAR | 4 |  | - |
| 7 | ZMODEL | 7 |  | ZMODEL25 | ZMODEL25 | CHAR | 10 |  | - |
| 8 | STPRS | 8 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 9 | WAERS | 9 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 10 | MENGE | 10 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 11 | MEINS | 11 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 12 | .INCLUDE | 12 |  | ZEDS025_002 |  |  | 0 |  | - |
| 13 | CNAME | 13 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 14 | CRDATE | 14 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 15 | CRZEIT | 15 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 16 | AENAME | 16 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 17 | AEDATE | 17 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 18 | AEZEIT | 18 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
