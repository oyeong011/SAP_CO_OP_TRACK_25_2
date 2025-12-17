# Table: ZMSEG_13

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | ZEILE | 4 | X | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
| 5 | BWART | 5 |  | BWART | BWART | CHAR | 3 |  | Movement type (inventory management) |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 8 | WERKS | 8 |  | ZWERKS13 | ZWERKS13 | CHAR | 4 |  | -# |
| 9 | LGORT | 9 |  | ZLGORT13 | ZLGORT13 | CHAR | 4 |  | - |
| 10 | LIFNR | 10 |  | ELIFN | LIFNR | CHAR | 10 |  | Vendor's account number |
| 11 | WAERS | 11 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 12 | MENGE | 12 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 13 | MEINS | 13 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 14 | EBELN | 14 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 15 | BUKRS | 15 |  | ZBUKRS13 | ZBUKRS13 | CHAR | 4 |  | - |
| 16 | GJAHR | 16 |  | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 17 | BELNR | 17 |  | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 18 | SHKZG | 18 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 19 | DMBTR | 19 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 20 | SJAHR | 20 |  | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 21 | SMBLN | 21 |  | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 22 | SMBLP | 22 |  | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
