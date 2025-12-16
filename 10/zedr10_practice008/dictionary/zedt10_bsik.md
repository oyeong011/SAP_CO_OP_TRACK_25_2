# Table: ZEDT10_BSIK

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BUKRS | 2 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 3 | LIFNR | 3 | X | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 4 | BELNR | 4 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 5 | GJAHR | 5 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 6 | BUZEI | 6 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 7 | BLDAT | 7 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 8 | BUDAT | 8 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 9 | WAERS | 9 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 10 | BLART | 10 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 11 | SHKZG | 11 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 12 | DMBTR | 12 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 13 | MWSTS | 13 |  | MWSTS | WERT7 | CURR | 13 |  | Tax Amount in Local Currency |
| 14 | MWSKZ | 14 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 15 | ZFBDT | 15 |  | DATS | DATS | DATS | 8 |  | Field of type DATS |
| 16 | SGTXT | 16 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 17 | .INCLUDE | 17 |  | ZEDS10_002 |  |  | 0 |  | - |
| 18 | CRNAME | 18 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 19 | CRDATE | 19 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 20 | CRZEIT | 20 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 21 | AENAME | 21 |  | AENAME | UNAME | CHAR | 12 |  | Last Changed By |
| 22 | AEDATE | 22 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 23 | AEZEIT | 23 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
