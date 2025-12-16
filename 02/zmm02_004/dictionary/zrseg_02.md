# Table: ZRSEG_02

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | WRBTR | 7 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 8 | WMWST | 8 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 9 | MWSKZ | 9 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 10 | MATNR | 10 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 11 | MENGE | 11 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 12 | BSTME | 12 |  | BSTME | MEINS | UNIT | 3 | X | Purchase Order Unit of Measure |
| 13 | WERKS | 13 |  | ZWERKS02 | ZWERKS02 | CHAR | 4 |  | -# |
| 14 | SGTXT | 14 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 15 | SHKZG | 15 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 16 | ZCANC | 16 |  |  |  | CHAR | 1 |  | - - - |
| 17 | ZCANDOC | 17 |  |  |  | CHAR | 1 |  | - - - |
