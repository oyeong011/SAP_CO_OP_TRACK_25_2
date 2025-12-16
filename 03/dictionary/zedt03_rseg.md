# Table: ZEDT03_RSEG

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
| 9 | MEINS | 9 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 10 | WRBTR | 10 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 11 | MWSKZ | 11 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 12 | WERKS | 12 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 13 | SHKZG | 13 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
