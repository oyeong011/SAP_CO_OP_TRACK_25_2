# Table: ZRBKP_13

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUKRS | 4 |  | ZBUKRS13 | ZBUKRS13 | CHAR | 4 |  | - |
| 5 | LIFNR | 5 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 6 | BLDAT | 6 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 7 | BUDAT | 7 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 8 | WAERS | 8 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 9 | RMWWR | 9 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 10 | WMWST1 | 10 |  | MWSTS | WERT7 | CURR | 13 |  | Tax Amount in Local Currency |
| 11 | BLART | 11 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 12 | SGTXT | 12 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 13 | LOEKZ | 13 |  | LOEKZ | XFELD | CHAR | 1 |  | Asset class marked for deletion |
