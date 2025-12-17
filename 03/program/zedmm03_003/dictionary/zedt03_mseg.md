# Table: ZEDT03_MSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | ZEILE | 4 | X | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
| 5 | MATNR | 5 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 6 | WERKS | 6 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 7 | LGORT | 7 |  | LGORT_D | LGORT | CHAR | 4 |  | Storage Location |
| 8 | LIFNR | 8 |  | ELIFN | LIFNR | CHAR | 10 |  | Vendor's account number |
| 9 | WAERS | 9 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 10 | MENGE | 10 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 11 | MEINS | 11 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 12 | EBELN | 12 |  | BSTNR | EBELN | CHAR | 10 |  | Purchase order number |
| 13 | EBELP | 13 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 14 | LOEKZ | 14 |  | LOEKZ | XFELD | CHAR | 1 |  | Asset class marked for deletion |
| 15 | BUKRS | 15 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 16 | GJAHR | 16 |  | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 17 | BELNR | 17 |  | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 18 | SHKZG | 18 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 19 | DMBTR | 19 |  | DMBUM | WERT7 | CURR | 13 |  | Revaluation amount on back-posting to a previous period |
