# Table: ZMAT01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | WERKS | 2 | X | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 3 | LGORT | 3 | X | LGORT_D | LGORT | CHAR | 4 |  | Storage Location |
| 4 | MATNR | 4 | X | ZMATNR01 | MATNR | CHAR | 18 |  | - |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MTART | 6 |  | ZMTART01 | ZMTART01 | CHAR | 4 |  | - |
| 7 | MATKL | 7 |  | MATKL | MATKL | CHAR | 9 |  | Material Group |
| 8 | VPRSV | 8 |  | VPRSV | VPRSV | CHAR | 1 |  | Price control indicator |
| 9 | STPRS | 9 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 10 | VERPR | 10 |  | VERPR | WERT11V | CURR | 11 |  | Moving Average Price/Periodic Unit Price |
| 11 | WAERS | 11 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 12 | MEINS | 12 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 13 | VRKME | 13 |  | VRKME | MEINS | UNIT | 3 | X | Sales Unit |
| 14 | BKLAS | 14 |  | BKLAS | BKLAS | CHAR | 4 |  | Valuation Class |
| 15 | ZBRAND | 15 |  | ZBRAND01 | CHAR30 | CHAR | 30 |  | - -# |
| 16 | ZMODEL | 16 |  | ZMODEL01 | CHAR30 | CHAR | 30 |  | - - |
| 17 | ZDESC1 | 17 |  | ZDESC1_01 | CHAR30 | CHAR | 30 |  | - - |
| 18 | ACTIVE | 18 |  | ACTIVE | F_MODUS | CHAR | 1 |  | The field and its attributes are active |
| 19 | .INCLUDE | 19 |  | ZEDS01_002 |  |  | 0 |  | - |
| 20 | CRNAME | 20 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 21 | CRDATE | 21 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 22 | CRZEIT | 22 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
| 23 | AENAME | 23 |  | AENAME | UNAME | CHAR | 12 |  | Last Changed By |
| 24 | AEDATE | 24 |  | DATS | DATS | DATS | 8 |  | Field of type DATS |
| 25 | AEZEIT | 25 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
