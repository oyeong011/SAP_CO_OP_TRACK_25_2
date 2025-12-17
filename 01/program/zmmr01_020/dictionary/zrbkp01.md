# Table: ZRBKP01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | LIFNR | 4 |  | ZLIFNR01 | LIFNR | CHAR | 10 |  | -# |
| 5 | BUKRS | 5 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 6 | WAERS | 6 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 7 | KURSF | 7 |  | KURSF | KURSF | DEC | 9 |  | Exchange rate |
| 8 | BLART | 8 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 9 | BLDAT | 9 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 10 | BUDAT | 10 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 11 | RMWWR | 11 |  | RMWWR | WERT7 | CURR | 13 |  | Gross invoice amount in document currency |
| 12 | WMWST | 12 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 13 | MWSKZ | 13 |  | ZMWSKZ01 | ZTAXCODE01 | CHAR | 2 |  | - |
| 14 | BKTXT | 14 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 15 | TXKRS | 15 |  | TXKRS | TXKRS | CHAR | 1 |  | Foreign Currency Translation for Tax Items |
| 16 | STBLG | 16 |  | STBLG | BELNR | CHAR | 10 |  | Reverse Document Number |
| 17 | STJAH | 17 |  | STJAH | GJAHR | NUMC | 4 |  | Reverse document fiscal year |
| 18 | XREVR | 18 |  | FLAG | FLAG | CHAR | 1 |  | General Flag |
| 19 | .INCLUDE | 19 |  | ZEDS01_002 |  |  | 0 |  | - |
| 20 | CRNAME | 20 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 21 | CRDATE | 21 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 22 | CRZEIT | 22 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
| 23 | AENAME | 23 |  | AENAME | UNAME | CHAR | 12 |  | Last Changed By |
| 24 | AEDATE | 24 |  | DATS | DATS | DATS | 8 |  | Field of type DATS |
| 25 | AEZEIT | 25 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
