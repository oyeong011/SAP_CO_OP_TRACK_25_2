# Table: ZEDT17_LFA1

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | LIFNR | 2 | X | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 3 | NAME1 | 3 |  | NAME1 | TEXT30 | CHAR | 30 | X | Name |
| 4 | LAND1 | 4 |  | LAND1 | LAND1 | CHAR | 3 |  | Country Key |
| 5 | KTOKK | 5 |  | Z17_KTOKK | Z17_KTOKK | CHAR | 4 |  | -# |
| 6 | STCD1 | 6 |  | STCD1 | STCD1 | CHAR | 16 |  | Tax Number 1 |
| 7 | STCD2 | 7 |  | STCD2 | STCD2 | CHAR | 11 |  | Tax Number 2 |
| 8 | STRAS | 8 |  | STRAS | TEXT30 | CHAR | 30 | X | Street and House Number |
| 9 | .INCLUDE | 9 |  | ZEDS17_002 |  |  | 0 |  | - |
| 10 | CRNAME | 10 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 11 | CRDATE | 11 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 12 | CRZEIT | 12 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 13 | AENAME | 13 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 14 | AEDATE | 14 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 15 | AEZEIT | 15 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
