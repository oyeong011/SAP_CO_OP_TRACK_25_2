# Table: ZEDT10_RBKP

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BLART | 4 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 5 | BLDAT | 5 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 6 | BUDAT | 6 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 7 | LIFNR | 7 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 8 | WAERS | 8 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 9 | DMBTR | 9 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 10 | WMWST | 10 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 11 | BUKRS | 11 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 12 | ZTERM | 12 |  | DZTERM | ZTERM | CHAR | 4 |  | Terms of Payment Key |
| 13 | SGTXT | 13 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 14 | .INCLUDE | 14 |  | ZEDS10_002 |  |  | 0 |  | - |
| 15 | CRNAME | 15 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 16 | CRDATE | 16 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 17 | CRZEIT | 17 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 18 | AENAME | 18 |  | AENAME | UNAME | CHAR | 12 |  | Last Changed By |
| 19 | AEDATE | 19 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 20 | AEZEIT | 20 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
