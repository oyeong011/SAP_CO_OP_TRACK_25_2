# Table: ZBSEG01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BUKRS | 2 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 3 | BELNR | 3 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 4 | GJAHR | 4 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 5 | BUZEI | 5 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 6 | BSCHL | 6 |  | BSCHL | BSCHL | CHAR | 2 |  | Posting Key |
| 7 | KOART | 7 |  | KOART | KOART | CHAR | 1 |  | Account type |
| 8 | HKONT | 8 |  | HKONT | SAKNR | CHAR | 10 |  | General Ledger Account |
| 9 | SHKZG | 9 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 10 | SAKNR | 10 |  | SAKNR | SAKNR | CHAR | 10 |  | G/L Account Number |
| 11 | LIFNR | 11 |  | ZLIFNR01 | LIFNR | CHAR | 10 |  | -# |
| 12 | WRBTR | 12 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 13 | DMBTR | 13 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 14 | MWSKZ | 14 |  | ZMWSKZ01 | ZTAXCODE01 | CHAR | 2 |  | - |
| 15 | XBLNR | 15 |  | XBLNR | XBLNR | CHAR | 16 |  | Reference Document Number |
| 16 | MATNR | 16 |  | ZMATNR01 | MATNR | CHAR | 18 |  | - |
| 17 | SGTXT | 17 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
