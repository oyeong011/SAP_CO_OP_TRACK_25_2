# Table: ZEDT03_RBKP

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUKRS | 4 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 5 | LIFNR | 5 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 6 | BLDAT | 6 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 7 | BUDAT | 7 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 8 | WAERS | 8 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 9 | RMWWR | 9 |  | RMWWR | WERT7 | CURR | 13 |  | Gross invoice amount in document currency |
| 10 | WMWST | 10 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 11 | EBELN | 11 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 12 | STBLG | 12 |  | RE_STBLG | BELNR | CHAR | 10 |  | Reversal document number |
| 13 | STJAH | 13 |  | RE_STJAH | GJAHR | NUMC | 4 |  | Fiscal year of reversal document |
