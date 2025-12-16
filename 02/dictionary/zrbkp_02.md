# Table: ZRBKP_02

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BLDAT | 4 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 5 | BUDAT | 5 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 6 | LIFNR | 6 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 7 | WAERS | 7 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 8 | RMWWR | 8 |  | RMWWR | WERT7 | CURR | 13 |  | Gross invoice amount in document currency |
| 9 | BUKRS | 9 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 10 | BKTXT | 10 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 11 | STBLG | 11 |  | RE_STBLG | BELNR | CHAR | 10 |  | Reversal document number |
| 12 | XRECH | 12 |  | XRECH | XRADI | CHAR | 1 |  | Indicator: post invoice |
| 13 | STJAH | 13 |  | RE_STJAH | GJAHR | NUMC | 4 |  | Fiscal year of reversal document |
| 14 | BUPLA | 14 |  | BUPLA | J_1BBRANCH | CHAR | 4 |  | Business Place |
| 15 | SECCO | 15 |  | SECCO | SECCO | CHAR | 4 |  | Section Code |
| 16 | WMWST1 | 16 |  | FWSTEV | WERTV7 | CURR | 13 |  | Tax Amount in Document Currency with +/- Sign |
| 17 | MWSKZ1 | 17 |  | MWSKZ_MRM1 | MRM_MWSKZ | CHAR | 2 |  | Tax code |
| 18 | XBLNR | 18 |  | XBLNR1 | XBLNR1 | CHAR | 16 |  | Reference Document Number |
