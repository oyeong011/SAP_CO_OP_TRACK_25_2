# Table: ZEDT17_MKPF

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | BLART | 4 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 5 | BLDAT | 5 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 6 | BUDAT | 6 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 7 | .INCLUDE | 7 |  | ZEDS17_002 |  |  | 0 |  | - |
| 8 | CRNAME | 8 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 9 | CRDATE | 9 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 10 | CRZEIT | 10 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 11 | AENAME | 11 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 12 | AEDATE | 12 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 13 | AEZEIT | 13 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
