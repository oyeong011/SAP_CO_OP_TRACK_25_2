# Table: ZBSEG_05

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BUKRS | 2 | X | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 3 | BELNR | 3 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 4 | GJAHR | 4 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 5 | BUZEI | 5 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 6 | HKONT | 6 |  | HKONT | SAKNR | CHAR | 10 |  | General Ledger Account |
| 7 | SHKZG | 7 |  | SHKZG | SHKZG | CHAR | 1 |  | Debit/Credit Indicator |
| 8 | DMBTR | 8 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 9 | MENGE | 9 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 10 | MEINS | 10 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 11 | MWSKZ | 11 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 12 | EBELN | 12 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 13 | EBELP | 13 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 14 | MATNR | 14 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 15 | WERKS | 15 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 16 | REBZG | 16 |  | REBZG | BELNR | CHAR | 10 |  | Document no. of the invoice to which the transaction belongs |
