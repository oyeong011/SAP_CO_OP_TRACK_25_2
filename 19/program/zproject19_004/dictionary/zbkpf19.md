# Table: ZBKPF19

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | BUKRS | 1 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 2 | LIFNR | 2 | X | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BELNR | 4 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 5 | BLDAT | 5 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 6 | BUDAT | 6 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 7 | WAERS | 7 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 8 | BLART | 8 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 9 | ZMWSKZ | 9 |  | ZMWSKZ19 | ZMWSKZ19 | CHAR | 2 |  | -# |
| 10 | SGTXT | 10 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 11 | EBELN | 11 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 12 | ZFBDT | 12 |  | DZFBDT | DATUM | DATS | 8 |  | Baseline Date for Due Date Calculation |
