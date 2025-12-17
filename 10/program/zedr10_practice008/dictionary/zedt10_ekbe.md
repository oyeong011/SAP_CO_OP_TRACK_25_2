# Table: ZEDT10_EKBE

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | ZEKKN | 4 | X | DZEKKN | NUM02 | NUMC | 2 |  | Sequential Number of Account Assignment |
| 5 | VGABE | 5 | X | VGABE | VGABE | CHAR | 1 |  | Transaction/event type, purchase order history |
| 6 | GJAHR | 6 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 7 | BELNR | 7 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 8 | BUZEI | 8 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 9 | BEWTP | 9 |  | BEWTP | BEWTP | CHAR | 1 |  | Purchase Order History Category |
| 10 | BWART | 10 |  | BWART | BWART | CHAR | 3 |  | Movement type (inventory management) |
| 11 | MEINS | 11 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 12 | MENGE | 12 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 13 | DMBTR | 13 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 14 | WAERS | 14 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 15 | SHKZG | 15 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 16 | HSWAE | 16 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
