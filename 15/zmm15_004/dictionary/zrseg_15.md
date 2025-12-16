# Table: ZRSEG_15

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 8 | WERKS | 8 |  | ZWERKS15 | ZWERKS15 | CHAR | 4 |  | -# |
| 9 | WRBTR | 9 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 10 | SHKZG | 10 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 11 | MENGE | 11 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 12 | MEINS | 12 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 13 | BPRME | 13 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 14 | NETPR | 14 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 15 | SGTXT | 15 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 16 | DMBTR | 16 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
