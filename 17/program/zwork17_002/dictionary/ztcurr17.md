# Table: ZTCURR17

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | KURST | 2 | X | KURST_CURR | KURST | CHAR | 4 |  | Exchange rate type |
| 3 | FCURR | 3 | X | FCURR_CURR | WAERS | CUKY | 5 |  | From currency |
| 4 | TCURR | 4 | X | TCURR_CURR | WAERS | CUKY | 5 |  | To-currency |
| 5 | GDATU | 5 | X | GDATU_INV | DATUM_INV | CHAR | 8 |  | Date As of Which the Exchange Rate Is Effective |
| 6 | UKURS | 6 |  | UKURS_CURR | UKURS | DEC | 9 |  | Exchange Rate |
| 7 | FFACT | 7 |  | FFACT_CURR | DEC9 | DEC | 9 |  | Ratio for the "from" currency units |
| 8 | TFACT | 8 |  | TFACT_CURR | DEC9 | DEC | 9 |  | Ratio for the "to" currency units |
| 9 | .INCLUDE | 9 |  | ZEDS17_002 |  |  | 0 |  | - |
| 10 | CRNAME | 10 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 11 | CRDATE | 11 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 12 | CRZEIT | 12 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 13 | AENAME | 13 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 14 | AEDATE | 14 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 15 | AEZEIT | 15 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
