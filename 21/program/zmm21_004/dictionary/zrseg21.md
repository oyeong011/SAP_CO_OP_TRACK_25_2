# Table: ZRSEG21

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 8 | MENGE | 8 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 9 | BSTME | 9 |  | BSTME | MEINS | UNIT | 3 | X | Purchase Order Unit of Measure |
| 10 | WERKS | 10 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 11 | SGTXT | 11 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 12 | BUKRS | 12 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 13 | SHKZG | 13 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 14 | BPRME | 14 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 15 | MEINS | 15 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 16 | WRBTR | 16 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 17 | MWSKZ | 17 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 18 | WMWST | 18 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 19 | DMBTR | 19 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
