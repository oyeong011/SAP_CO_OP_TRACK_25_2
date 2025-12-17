# Table: Z23MSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | ZEILE | 4 | X | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
| 5 | MATNR | 5 |  | ZMATNR23 | ZMATNR23 | CHAR | 10 |  | - |
| 6 | MAKTX | 6 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 7 | WERKS | 7 |  | EWERK | WERKS | CHAR | 4 |  | Plant |
| 8 | LGORT | 8 |  | ZLGORT23 | ZLGORT23 | CHAR | 4 |  | Storage Location |
| 9 | LIFNR | 9 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 10 | WAERS | 10 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 11 | MENGE | 11 |  | BSTMG | MENG13 | QUAN | 13 |  | Purchase Order Quantity |
| 12 | MEINS | 12 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 13 | EBELN | 13 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 14 | EBELP | 14 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 15 | BUKRS | 15 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 16 | GJAHR | 16 |  | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 17 | BELNR | 17 |  | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 18 | SHKZG | 18 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 19 | DMBTR | 19 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
