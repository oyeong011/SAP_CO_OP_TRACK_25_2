# Table: ZRSEG01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | ZEBELN01 | EBELN | CHAR | 10 |  | -- |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | ZMATNR01 | MATNR | CHAR | 18 |  | - |
| 8 | BUKRS | 8 |  | ZBUKRS01 | BUKRS | CHAR | 4 |  | - |
| 9 | WERKS | 9 |  | ZWERKS01 | WERKS | CHAR | 4 |  | -# |
| 10 | LGORT | 10 |  | ZLGORT01 | LGORT | CHAR | 4 |  | - |
| 11 | WRBTR | 11 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 12 | SHKZG | 12 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 13 | MWSKZ | 13 |  | ZMWSKZ01 | ZTAXCODE01 | CHAR | 2 |  | - |
| 14 | MENGE | 14 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 15 | BSTME | 15 |  | BSTME | MEINS | UNIT | 3 | X | Purchase Order Unit of Measure |
| 16 | BPMNG | 16 |  | BPMNG | MENG13 | QUAN | 13 |  | Quantity in Purchase Order Price Unit |
| 17 | BPRME | 17 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 18 | MEINS | 18 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 19 | BKLAS | 19 |  | BKLAS | BKLAS | CHAR | 4 |  | Valuation Class |
| 20 | SGTXT | 20 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 21 | STBLG | 21 |  | STBLG | BELNR | CHAR | 10 |  | Reverse Document Number |
| 22 | STJAH | 22 |  | STJAH | GJAHR | NUMC | 4 |  | Reverse document fiscal year |
| 23 | XREVR | 23 |  | FLAG | FLAG | CHAR | 1 |  | General Flag |
