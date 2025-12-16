# Table: ZMSEG09

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | ZEILE | 4 | X | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
| 5 | LINE_ID | 5 |  | MB_LINE_ID | MB_LINE_ID | NUMC | 6 |  | Unique identification of document line |
| 6 | PARENT_ID | 6 |  | MB_PARENT_ID | MB_LINE_ID | NUMC | 6 |  | Identifier of immediately superior line |
| 7 | BWART | 7 |  | BWART | BWART | CHAR | 3 |  | Movement type (inventory management) |
| 8 | MATNR | 8 |  | ZMATNR_09 | ZMATNR_09 | CHAR | 10 |  | - |
| 9 | WERKS | 9 |  | ZWERKS09 | ZWERKS09 | CHAR | 4 |  | -# |
| 10 | SOBKZ | 10 |  | SOBKZ | SOBKZ | CHAR | 1 |  | Special Stock Indicator |
| 11 | LGORT | 11 |  | ZLGORT09 | ZLGORT09 | CHAR | 4 |  | - |
| 12 | LIFNR | 12 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 13 | SHKZG | 13 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 14 | WAERS | 14 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 15 | DMBTR | 15 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 16 | MENGE | 16 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 17 | MEINS | 17 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 18 | EBELN | 18 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 19 | EBELP | 19 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 20 | LFBJA | 20 |  | LFBJA | GJAHR | NUMC | 4 |  | Fiscal Year of a Reference Document |
| 21 | LFBNR | 21 |  | LFBNR | BELNR | CHAR | 10 |  | Document No. of a Reference Document |
| 22 | LFPOS | 22 |  | LFPOS | MBLPO | NUMC | 4 |  | Item of a Reference Document |
| 23 | ELIKZ | 23 |  | ELIKZ | XFELD | CHAR | 1 |  | "Delivery Completed" Indicator |
| 24 | GJAHR | 24 |  | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 25 | BUKRS | 25 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 26 | KZBEW | 26 |  | KZBEW | KZBEW | CHAR | 1 |  | Movement Indicator |
| 27 | BELNR | 27 |  | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 28 | ZCANCEL_FLAG | 28 |  |  |  | CHAR | 1 |  |  |
