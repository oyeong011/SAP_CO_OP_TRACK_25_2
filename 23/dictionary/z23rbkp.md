# Table: Z23RBKP

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BLART | 4 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 5 | BLDAT | 5 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 6 | BUDAT | 6 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 7 | XBLNR | 7 |  | XBLNR | XBLNR | CHAR | 16 |  | Reference Document Number |
| 8 | BUKRS | 8 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 9 | LIFNR | 9 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 10 | WAERS | 10 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 11 | ZTERM | 11 |  | DZTERM | ZTERM | CHAR | 4 |  | Terms of Payment Key |
| 12 | BKTXT | 12 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 13 | XMWST | 13 |  | XMWST | XFELD | CHAR | 1 |  | Calculate tax automatically |
| 14 | BWSKZ | 14 |  | MWSKZ | MWSKZ | CHAR | 2 |  | Tax on Sales/Purchases Code |
| 15 | WMWST | 15 |  | FWSTEV | WERTV7 | CURR | 13 |  | Tax Amount in Document Currency with +/- Sign |
| 16 | RMWWR | 16 |  | RMWWR | WERT7 | CURR | 13 |  | Gross invoice amount in document currency |
| 17 | STBLG | 17 |  | STBLG | BELNR | CHAR | 10 |  | Reverse Document Number |
| 18 | STJAH | 18 |  | STJAH | GJAHR | NUMC | 4 |  | Reverse document fiscal year |
| 19 | RBSTAT | 19 |  | RBSTAT | RBSTAT | CHAR | 1 |  | Invoice document status |
