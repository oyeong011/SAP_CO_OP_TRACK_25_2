# Table: ZRSEG09
**Description:** ## ###

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | ZMATNR_09 | ZMATNR_09 | CHAR | 10 |  | - |
| 8 | WERKS | 8 |  | ZWERKS09 | ZWERKS09 | CHAR | 4 |  | -# |
| 9 | WRBTR | 9 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 10 | SHKZG | 10 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 11 | MENGE | 11 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 12 | MEINS | 12 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 13 | BPRME | 13 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 14 | NETPR | 14 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 15 | MWSKZ | 15 |  | ZMWSKZ09 | ZMWSKZ09 | CHAR | 2 |  |  |
| 16 | SGTXT | 16 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 17 | WAERS | 17 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 18 | WMWST | 18 |  | FWSTEV | WERTV7 | CURR | 13 |  | Tax Amount in Document Currency with +/- Sign |
| 19 | DBMTR | 19 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
