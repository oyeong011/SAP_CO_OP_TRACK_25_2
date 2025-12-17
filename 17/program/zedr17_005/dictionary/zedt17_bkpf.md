# Table: ZEDT17_BKPF

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BUKRS | 2 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BELNR | 4 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 5 | BLART | 5 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 6 | BLDAT | 6 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 7 | BUDAT | 7 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 8 | WAERS | 8 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 9 | BKTXT | 9 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 10 | STBLG | 10 |  | STBLG | BELNR | CHAR | 10 |  | Reverse Document Number |
| 11 | STJAH | 11 |  | STJAH | GJAHR | NUMC | 4 |  | Reverse document fiscal year |
| 12 | XSTOV | 12 |  | XSTOV | XFELD | CHAR | 1 |  | Indicator: Document is flagged for reversal |
| 13 | .INCLUDE | 13 |  | ZEDS17_002 |  |  | 0 |  | - |
| 14 | CRNAME | 14 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 15 | CRDATE | 15 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 16 | CRZEIT | 16 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 17 | AENAME | 17 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 18 | AEDATE | 18 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 19 | AEZEIT | 19 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
