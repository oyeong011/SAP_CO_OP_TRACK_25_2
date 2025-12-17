# Table: ZRSEG_05

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | ZMATNR05 | ZMATNR05 | CHAR | 10 |  | - |
| 8 | BUKRS | 8 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 9 | TXZ01 | 9 |  | ZMATNAME05 | ZMATNAME05 | CHAR | 20 |  | -# |
| 10 | WERKS | 10 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 11 | LGORT | 11 |  | ZLGORT05 | ZLGORT05 | CHAR | 4 |  | - |
| 12 | WRBTR | 12 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 13 | SHKZG | 13 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 14 | MENGE | 14 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 15 | BSTME | 15 |  | BSTME | MEINS | UNIT | 3 | X | Purchase Order Unit of Measure |
| 16 | MWSKZ | 16 |  | ZMWSKZ05 | ZMWSKZ05 | CHAR | 2 |  | -# |
| 17 | BPMNG | 17 |  | BPMNG | MENG13 | QUAN | 13 |  | Quantity in Purchase Order Price Unit |
| 18 | WMWST | 18 |  | FWSTEV | WERTV7 | CURR | 13 |  | Tax Amount in Document Currency with +/- Sign |
| 19 | SGTXT | 19 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 20 | WAERS | 20 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 21 | MEINS | 21 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 22 | MBLNR | 22 |  | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 23 | MJAHR | 23 |  | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 24 | MBLPO | 24 |  | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
