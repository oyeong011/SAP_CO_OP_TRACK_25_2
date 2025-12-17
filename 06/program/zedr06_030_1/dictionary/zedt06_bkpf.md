# Table: ZEDT06_BKPF

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | ZBELNR06 | BELNR | CHAR | 10 |  | - - |
| 3 | GJAHR | 3 | X | ZGJAHR06 | GJAHR | NUMC | 4 |  | - |
| 4 | BUKRS | 4 | X | ZBUKRS06 | BUKRS | CHAR | 4 |  | - |
| 5 | BLART | 5 |  | ZBLART06 | ZBLART06 | CHAR | 2 |  | - |
| 6 | BLDAT | 6 |  | ZBLDAT06 | ZBLDAT06 | DATS | 8 |  | -# |
| 7 | BUDAT | 7 |  | ZBUDAT06 | ZBUDAT06 | DATS | 8 |  | -# |
| 8 | REF_DOC_TYPE | 8 |  | ZREF_DOC_TYPE06 | ZREF_DOC_TYPE06 | CHAR | 2 |  | -- |
| 9 | REF_DOC_NO | 9 |  | ZREF_DOC_NO06 | ZREF_DOC_NO06 | CHAR | 16 |  | -- |
| 10 | REF_DOC_YEAR | 10 |  | ZREF_DOC_YEAR06 | ZREF_DOC_YEAR06 | NUMC | 4 |  | -- |
| 11 | .INCLUDE | 11 |  | ZEDS06_002 |  |  | 0 |  | - |
| 12 | CRNAME | 12 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 13 | CRDATE | 13 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 14 | CRZEIT | 14 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 15 | AENAME | 15 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 16 | AEDATE | 16 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 17 | AEZEIT | 17 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
