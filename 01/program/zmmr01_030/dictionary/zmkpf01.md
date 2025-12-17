# Table: ZMKPF01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 |  | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | BLART | 4 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 5 | BLDAT | 5 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 6 | BUDAT | 6 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 7 | BKTXT | 7 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 8 | .INCLUDE | 8 |  | ZEDS01_002 |  |  | 0 |  | - |
| 9 | CRNAME | 9 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 10 | CRDATE | 10 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 11 | CRZEIT | 11 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
| 12 | AENAME | 12 |  | AENAME | UNAME | CHAR | 12 |  | Last Changed By |
| 13 | AEDATE | 13 |  | DATS | DATS | DATS | 8 |  | Field of type DATS |
| 14 | AEZEIT | 14 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
| 15 | XBLNR | 15 |  | XBLNR | XBLNR | CHAR | 16 |  | Reference Document Number |
| 16 | STORN | 16 |  | STORN | XFELD | CHAR | 1 |  | Indicator: Document is reversed |
