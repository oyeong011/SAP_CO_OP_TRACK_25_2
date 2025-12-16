# Table: Z23RSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 5 | EBELN | 5 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | ZMATNR23 | ZMATNR23 | CHAR | 10 |  | - |
| 8 | TXZ01 | 8 |  | ZMATNAME23 | ZMATNAME23 | CHAR | 20 |  | Name of Material |
| 9 | WERKS | 9 |  | EWERK | WERKS | CHAR | 4 |  | Plant |
| 10 | WRBTR | 10 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 11 | MENGE | 11 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 12 | BSTME | 12 |  | BSTME | MEINS | UNIT | 3 | X | Purchase Order Unit of Measure |
| 13 | MWSKZ | 13 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 14 | WMWST | 14 |  | FWSTEV | WERTV7 | CURR | 13 |  | Tax Amount in Document Currency with +/- Sign |
| 15 | SGTXT | 15 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
