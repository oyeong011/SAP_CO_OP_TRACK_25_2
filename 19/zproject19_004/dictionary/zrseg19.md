# Table: ZRSEG19

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | BUKRS | 5 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 6 | LIFNR | 6 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 7 | EBELN | 7 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 8 | DMBTR | 8 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 9 | MWSTS | 9 |  | MWSTS | WERT7 | CURR | 13 |  | Tax Amount in Local Currency |
| 10 | ZMWSKZ | 10 |  | ZMWSKZ19 | ZMWSKZ19 | CHAR | 2 |  | -# |
| 11 | SHKZG | 11 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 12 | WAERS | 12 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 13 | GSBER | 13 |  | GSBER | GSBER | CHAR | 4 |  | Business Area |
| 14 | ZFDBT | 14 |  | DZFBDT | DATUM | DATS | 8 |  | Baseline Date for Due Date Calculation |
| 15 | SGTXT | 15 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
