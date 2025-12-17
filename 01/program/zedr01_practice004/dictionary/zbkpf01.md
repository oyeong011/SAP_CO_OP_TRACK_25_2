# Table: ZBKPF01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BUKRS | 2 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 3 | BELNR | 3 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 4 | GJAHR | 4 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 5 | BLART | 5 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 6 | BLDAT | 6 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 7 | BUDAT | 7 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 8 | CPUDT | 8 |  | CPUDT | DATUM | DATS | 8 |  | Day On Which Accounting Document Was Entered |
| 9 | CPUTM | 9 |  | CPUTM | UZEIT | TIMS | 6 |  | Time of Entry |
| 10 | KURSF | 10 |  | KURSF | KURSF | DEC | 9 |  | Exchange rate |
| 11 | WAERS | 11 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 12 | TCODE | 12 |  | TCODE | TCODE | CHAR | 20 |  | Transaction Code |
| 13 | XBLNR | 13 |  | XBLNR | XBLNR | CHAR | 16 |  | Reference Document Number |
| 14 | BKTXT | 14 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 15 | STBLG | 15 |  | STBLG | BELNR | CHAR | 10 |  | Reverse Document Number |
| 16 | STJAH | 16 |  | STJAH | GJAHR | NUMC | 4 |  | Reverse document fiscal year |
| 17 | XSTOV | 17 |  | XSTOV | XFELD | CHAR | 1 |  | Indicator: Document is flagged for reversal |
| 18 | .INCLUDE | 18 |  | ZEDS01_002 |  |  | 0 |  | - |
| 19 | CRNAME | 19 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 20 | CRDATE | 20 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 21 | CRZEIT | 21 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
| 22 | AENAME | 22 |  | AENAME | UNAME | CHAR | 12 |  | Last Changed By |
| 23 | AEDATE | 23 |  | DATS | DATS | DATS | 8 |  | Field of type DATS |
| 24 | AEZEIT | 24 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
