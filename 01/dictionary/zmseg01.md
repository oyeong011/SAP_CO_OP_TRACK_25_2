# Table: ZMSEG01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | ZEILE | 4 | X | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
| 5 | MATNR | 5 |  | ZMATNR01 | MATNR | CHAR | 18 |  | - |
| 6 | WERKS | 6 |  | ZWERKS01 | WERKS | CHAR | 4 |  | -# |
| 7 | LGORT | 7 |  | ZLGORT01 | LGORT | CHAR | 4 |  | - |
| 8 | LIFNR | 8 |  | ZLIFNR01 | LIFNR | CHAR | 10 |  | -# |
| 9 | EBELN | 9 |  | ZEBELN01 | EBELN | CHAR | 10 |  | -- |
| 10 | EBELP | 10 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 11 | MENGE | 11 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 12 | MEINS | 12 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 13 | WAERS | 13 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 14 | GJAHR | 14 |  | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 15 | DMBTR | 15 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 16 | BUKRS | 16 |  | ZBUKRS01 | BUKRS | CHAR | 4 |  | - |
| 17 | BELNR | 17 |  | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 18 | SHKZG | 18 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 19 | BWART | 19 |  | BWART | BWART | CHAR | 3 |  | Movement type (inventory management) |
| 20 | SGTXT | 20 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 21 | STBLG | 21 |  | STBLG | BELNR | CHAR | 10 |  | Reverse Document Number |
| 22 | STJAH | 22 |  | STJAH | GJAHR | NUMC | 4 |  | Reverse document fiscal year |
| 23 | STORN | 23 |  | STORN | XFELD | CHAR | 1 |  | Indicator: Document is reversed |
