# Table: ZEDT17_RBKP

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUKRS | 4 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 5 | LIFNR | 5 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 6 | EBELN | 6 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 7 | BLART | 7 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 8 | BLDAT | 8 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 9 | BUDAT | 9 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 10 | WAERS | 10 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 11 | BKTXT | 11 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 12 | ZTERM | 12 |  | ZTERM17 | ZTERM17 | CHAR | 4 |  | - |
| 13 | ZFBDT | 13 |  | ZFBDT17 | DATS | DATS | 8 |  | -# |
| 14 | .INCLUDE | 14 |  | ZEDS17_002 |  |  | 0 |  | - |
| 15 | CRNAME | 15 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 16 | CRDATE | 16 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 17 | CRZEIT | 17 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 18 | AENAME | 18 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 19 | AEDATE | 19 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 20 | AEZEIT | 20 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
