# Table: ZMSEG19

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | ZEILE | 4 | X | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
| 5 | ZMATNR | 5 |  | ZMATNR19 | ZMATNR19 | CHAR | 10 |  | - |
| 6 | ZWERKS | 6 |  | ZWERKS19 | ZWERKS19 | CHAR | 4 |  | - |
| 7 | ZLGORT | 7 |  | ZLGORT19 | ZLGORT19 | CHAR | 4 |  | - |
| 8 | LIFNR | 8 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 9 | WAERS | 9 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 10 | MENGE | 10 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 11 | MEINS | 11 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 12 | EBELN | 12 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 13 | BUKRS | 13 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 14 | GJAHR | 14 |  | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 15 | BELNR | 15 |  | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 16 | SHKZG | 16 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 17 | STPRS | 17 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 18 | DMBTR | 18 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
