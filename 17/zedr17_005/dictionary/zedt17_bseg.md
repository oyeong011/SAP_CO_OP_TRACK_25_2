# Table: ZEDT17_BSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BUKRS | 2 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BELNR | 4 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 5 | BUZEI | 5 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 6 | SHKZG | 6 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 7 | HKONT | 7 |  | HKONT | SAKNR | CHAR | 10 |  | General Ledger Account |
| 8 | DMBTR | 8 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 9 | MWSTS | 9 |  | MWSTS | WERT7 | CURR | 13 |  | Tax Amount in Local Currency |
| 10 | MWSKZ | 10 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 11 | SGTXT | 11 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 12 | LIFNR | 12 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 13 | EBELN | 13 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 14 | WAERS | 14 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 15 | .INCLUDE | 15 |  | ZEDS17_002 |  |  | 0 |  | - |
| 16 | CRNAME | 16 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 17 | CRDATE | 17 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 18 | CRZEIT | 18 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 19 | AENAME | 19 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 20 | AEDATE | 20 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 21 | AEZEIT | 21 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
