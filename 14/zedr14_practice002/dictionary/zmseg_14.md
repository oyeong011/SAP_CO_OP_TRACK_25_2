# Table: ZMSEG_14

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | ZEILE | 4 | X | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
| 5 | MATNR | 5 |  |  |  | CHAR | 10 |  | - |
| 6 | WERKS | 6 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 7 | LGORT | 7 |  |  |  | CHAR | 4 |  | - |
| 8 | LIFNR | 8 |  | ELIFN | LIFNR | CHAR | 10 |  | Vendor's account number |
| 9 | WAERS | 9 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 10 | MENGE | 10 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 11 | MEINS | 11 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 12 | EBELN | 12 |  | BSTNR | EBELN | CHAR | 10 |  | Purchase order number |
| 13 | BUKRS | 13 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 14 | BELNR | 14 |  |  |  | CHAR | 10 |  | - |
| 15 | GJAHR | 15 |  | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 16 | SHKZG | 16 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 17 | DMBTR | 17 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 18 | BWART | 18 |  | BWART | BWART | CHAR | 3 |  | Movement type (inventory management) |
| 19 | .INCLUDE | 19 |  | ZEDS14_002 |  |  | 0 |  | - |
| 20 | CRNAME | 20 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 21 | CRDATE | 21 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 22 | CRZEIT | 22 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 23 | AENAME | 23 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 24 | AEDATE | 24 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 25 | AEZEIT | 25 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
