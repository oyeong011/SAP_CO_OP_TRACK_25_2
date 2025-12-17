# Table: ZBSIK_05

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BUKRS | 2 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 3 | LIFNR | 3 | X | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 4 | GJAHR | 4 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 5 | BELNR | 5 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 6 | BLDAT | 6 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 7 | BUDAT | 7 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 8 | WAERS | 8 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 9 | BLART | 9 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 10 | SHKZG | 10 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 11 | GSBER | 11 |  | GSBER | GSBER | CHAR | 4 |  | Business Area |
| 12 | MWSKZ | 12 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 13 | DMBTR | 13 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 14 | MWSTS | 14 |  | MWSTS | WERT7 | CURR | 13 |  | Tax Amount in Local Currency |
| 15 | SGTXT | 15 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 16 | EBELN | 16 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 17 | ZFBDT | 17 |  | ZFBDT20 |  | DATS | 8 |  | -# |
