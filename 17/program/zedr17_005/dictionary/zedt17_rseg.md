# Table: ZEDT17_RSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | ZMATNR | 7 |  | ZMATNR17 | ZMATNR17 | CHAR | 10 |  | - |
| 8 | MAKTX | 8 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 9 | ZWERKS | 9 |  | ZWERKS17 | ZWERKS17 | CHAR | 4 |  | -# |
| 10 | MENGE | 10 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 11 | MEINS | 11 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 12 | WRBTR | 12 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 13 | WMWST | 13 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 14 | MWSKZ | 14 |  | ZMWSKZ17 | ZMWSKZ17 | CHAR | 2 |  | -# |
| 15 | SHKZG | 15 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 16 | .INCLUDE | 16 |  | ZEDS17_002 |  |  | 0 |  | - |
| 17 | CRNAME | 17 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 18 | CRDATE | 18 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 19 | CRZEIT | 19 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 20 | AENAME | 20 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 21 | AEDATE | 21 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 22 | AEZEIT | 22 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
