# Table: ZEDT20_RSEG

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | BUZEI | BUZEI | NUMC | 3 |  | Number of Line Item Within Accounting Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 8 | WERKS | 8 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 9 | MENGE | 9 |  | ZMENGE20 |  | QUAN | 15 |  | - |
| 10 | MEINS | 10 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 11 | BPRME | 11 |  | BPREI | WERT11 | CURR | 11 |  | Net Price in Purchasing Document (in Document Currency) |
| 12 | WRBTR | 12 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 13 | MWSKZ | 13 |  | ZMWSKZ20 | ZMWSKZ20 | CHAR | 2 |  | - |
| 14 | LOEVM | 14 |  | LOEVM | XFELD | CHAR | 1 |  | Deletion Indicator |
| 15 | LGORT | 15 |  | LGORT_D | LGORT | CHAR | 4 |  | Storage Location |
