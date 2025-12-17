# Table: ZEDT10_RSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 8 | WERKS | 8 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 9 | MENGE | 9 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 10 | MEINS | 10 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 11 | WAERS | 11 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 12 | WRBTR | 12 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 13 | MWSKZ | 13 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 14 | SHKZG | 14 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 15 | MWSTS | 15 |  | MWSTS | WERT7 | CURR | 13 |  | Tax Amount in Local Currency |
| 16 | DMBTR | 16 |  | DMBRT | WERT7 | CURR | 13 |  | Gross Amount in Local Currency |
| 17 | .INCLUDE | 17 |  | ZEDS10_002 |  |  | 0 |  | - |
| 18 | CRNAME | 18 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 19 | CRDATE | 19 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 20 | CRZEIT | 20 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 21 | AENAME | 21 |  | AENAME | UNAME | CHAR | 12 |  | Last Changed By |
| 22 | AEDATE | 22 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 23 | AEZEIT | 23 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
