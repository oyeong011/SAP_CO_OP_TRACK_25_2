# Table: ZEDT08_MAT

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | WERKS | 2 | X | ZWERKS08 | ZWERKS08 | CHAR | 5 |  | -# |
| 3 | LGORT | 3 | X | ZLGORT08 | ZLGORT08 | CHAR | 4 |  | - |
| 4 | ZMATNR | 4 | X | ZMATNR08 | ZMATNR08 | CHAR | 10 |  | - |
| 5 | ZMATNAME | 5 |  | ZMATNAME08 | ZMATNAME08 | CHAR | 20 |  | -# |
| 6 | ZMATDES | 6 |  | ZMATDES08 | ZMATDES08 | CHAR | 250 |  | - - |
| 7 | ZMTART | 7 |  | ZMTART08 | ZMTART08 | CHAR | 3 |  | - |
| 8 | STPRS | 8 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 9 | WAERS | 9 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 10 | MENGE | 10 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 11 | MEINS | 11 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 12 | BRGEW | 12 |  | BRGEW | MENG13 | QUAN | 13 |  | Gross Weight |
| 13 | GEWEI | 13 |  | GEWEI | MEINS | UNIT | 3 | X | Weight Unit |
| 14 | ZMATEXP | 14 |  | ZMATEXP08 | ZMATEXP08 | DATS | 8 |  | - |
| 15 | .INCLUDE | 15 |  | ZEDS08_002 |  |  | 0 |  | - |
| 16 | CRNAME | 16 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 17 | CRDATE | 17 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 18 | CRZEIT | 18 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 19 | AENAME | 19 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 20 | AEDATE | 20 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 21 | AEZEIT | 21 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
