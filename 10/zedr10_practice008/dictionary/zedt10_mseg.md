# Table: ZEDT10_MSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | ZEILE | 4 | X |  |  | NUMC | 4 |  | - - - |
| 5 | BWART | 5 |  | BWART | BWART | CHAR | 3 |  | Movement type (inventory management) |
| 6 | MATNR | 6 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 7 | WERKS | 7 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 8 | LGORT | 8 |  | LGORT_D | LGORT | CHAR | 4 |  | Storage Location |
| 9 | LIFNR | 9 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 10 | WAERS | 10 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 11 | MENGE | 11 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 12 | MEINS | 12 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 13 | DMBTR | 13 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 14 | SHKZG | 14 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 15 | EBELN | 15 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 16 | EBELP | 16 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 17 | BUKRS | 17 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 18 | BELNR | 18 |  | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 19 | GJAHR | 19 |  | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
