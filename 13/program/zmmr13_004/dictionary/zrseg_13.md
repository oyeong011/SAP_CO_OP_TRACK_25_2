# Table: ZRSEG_13

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 8 | WERKS | 8 |  | ZWERKS13 | ZWERKS13 | CHAR | 4 |  | -# |
| 9 | MENGE | 9 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 10 | WRBTR | 10 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 11 | DMBTR | 11 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 12 | MWSTS | 12 |  | MWSTS | WERT7 | CURR | 13 |  | Tax Amount in Local Currency |
| 13 | MWSKZ | 13 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 14 | WAERS | 14 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 15 | SGTXT | 15 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 16 | LOEKZ | 16 |  | LOEKZ | XFELD | CHAR | 1 |  | Asset class marked for deletion |
