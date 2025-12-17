# Table: ZRBKP_15

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BLART | 4 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 5 | BLDAT | 5 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 6 | BUDAT | 6 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 7 | BUKRS | 7 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 8 | LIFNR | 8 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 9 | WAERS | 9 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 10 | RMWWR | 10 |  | RMWWR | WERT7 | CURR | 13 |  | Gross invoice amount in document currency |
| 11 | WMWST1 | 11 |  | FWSTEV | WERTV7 | CURR | 13 |  | Tax Amount in Document Currency with +/- Sign |
| 12 | MWSKZ | 12 |  | ZMWSKZ15 | ZMWSKZ15 | CHAR | 2 |  | - |
| 13 | ZTERM | 13 |  | ZTERM15 | ZTERM15 | CHAR | 4 |  | - |
| 14 | BKTXT | 14 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 15 | STBLG | 15 |  | RE_STBLG | BELNR | CHAR | 10 |  | Reversal document number |
| 16 | STJAH | 16 |  | RE_STJAH | GJAHR | NUMC | 4 |  | Fiscal year of reversal document |
| 17 | RBSTAT | 17 |  | RBSTAT | RBSTAT | CHAR | 1 |  | Invoice document status |
| 18 | ZFBDT | 18 |  | DZFBDT | DATUM | DATS | 8 |  | Baseline Date for Due Date Calculation |
