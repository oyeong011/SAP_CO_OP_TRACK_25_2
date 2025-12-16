# Table: ZEDT16_RSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | ZMATNR16 | ZMATNR16 | CHAR | 10 |  | - |
| 8 | TXZ01 | 8 |  | ZMATNAME16 |  | CHAR | 20 |  | -# |
| 9 | WERKS | 9 |  | ZWERKS16 | ZWERKS16 | CHAR | 4 |  | -# |
| 10 | LGORT | 10 |  | ZLGORT16 | ZLGORT16 | CHAR | 4 |  | - |
| 11 | WRBTR | 11 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 12 | SHKZG | 12 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 13 | MENGE | 13 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 14 | BSTME | 14 |  | BSTME | MEINS | UNIT | 3 | X | Purchase Order Unit of Measure |
| 15 | MWSKZ | 15 |  | ZMWSKZ16 | ZMWSKZ16 | CHAR | 2 |  | -# |
| 16 | BPMNG | 16 |  | BPMNG | MENG13 | QUAN | 13 |  | Quantity in Purchase Order Price Unit |
| 17 | WMWST | 17 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 18 | SGTXT | 18 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 19 | WAERS | 19 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 20 | MEINS | 20 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 21 | LOEKZ | 21 |  | LOEKZ | XFELD | CHAR | 1 |  | Asset class marked for deletion |
