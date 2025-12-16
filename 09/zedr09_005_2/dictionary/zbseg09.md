# Table: ZBSEG09
**Description:** ## ## ####

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BUKRS | 2 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 3 | BELNR | 3 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 4 | GJAHR | 4 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 5 | BUZEI | 5 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 6 | BUZID | 6 |  | BUZID | CHAR1 | CHAR | 1 |  | Identification of the Line Item |
| 7 | BSCHL | 7 |  | BSCHL | BSCHL | CHAR | 2 |  | Posting Key |
| 8 | KOART | 8 |  | KOART | KOART | CHAR | 1 |  | Account type |
| 9 | SHKZG | 9 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 10 | DMBTR | 10 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 11 | WRBTR | 11 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 12 | PSWSL | 12 |  | PSWSL | WAERS | CUKY | 5 |  | Update Currency for General Ledger Transaction Figures |
| 13 | TXBHW | 13 |  | TXBHW | WERT7 | CURR | 13 |  | Original Tax Base Amount in Local Currency |
| 14 | TXBFW | 14 |  | TXBFW | WERT7 | CURR | 13 |  | Original Tax Base Amount in Document Currency |
| 15 | WMWST | 15 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 16 | HWBAS | 16 |  | HWBAS | WERT7 | CURR | 13 |  | Tax Base Amount in Local Currency |
| 17 | FWBAS | 17 |  | FWBAS | WERT7 | CURR | 13 |  | Tax Base Amount in Document Currency |
| 18 | KTOSL | 18 |  | KTOSL | CHAR3 | CHAR | 3 |  | Transaction Key |
| 19 | VORGN | 19 |  | VORGN | VORGN | CHAR | 4 |  | Transaction Type for General Ledger |
| 20 | HKONT | 20 |  | HKONT | SAKNR | CHAR | 10 |  | General Ledger Account |
| 21 | LIFNR | 21 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 22 | ZMBLNR | 22 |  | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 23 | ZMZEILE | 23 |  | MBLPO | MBLPO | NUMC | 4 |  | Item in Material Document |
