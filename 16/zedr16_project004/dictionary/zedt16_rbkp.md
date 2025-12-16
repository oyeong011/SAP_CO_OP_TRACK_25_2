# Table: ZEDT16_RBKP

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | BELNR_D | BELNR | CHAR | 10 |  | Accounting Document Number |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BLART | 4 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 5 | BLDAT | 5 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 6 | BUDAT | 6 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 7 | BUKRS | 7 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 8 | LIFNR | 8 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 9 | WAERS | 9 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 10 | ZTERM | 10 |  | ZTERM16 | ZTERM16 | CHAR | 4 |  | - |
| 11 | BKTXT | 11 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 12 | XMWST | 12 |  | XMWST | XFELD | CHAR | 1 |  | Calculate tax automatically |
| 13 | MWSKZ | 13 |  | ZMWSKZ16 | ZMWSKZ16 | CHAR | 2 |  | -# |
| 14 | WMWST | 14 |  | FWSTEV | WERTV7 | CURR | 13 |  | Tax Amount in Document Currency with +/- Sign |
| 15 | RMWWR | 15 |  | RMWWR | WERT7 | CURR | 13 |  | Gross invoice amount in document currency |
| 16 | STBLG | 16 |  | STBLG | BELNR | CHAR | 10 |  | Reverse Document Number |
| 17 | STJAH | 17 |  | STJAH | GJAHR | NUMC | 4 |  | Reverse document fiscal year |
| 18 | RBSTAT | 18 |  | RBSTAT | RBSTAT | CHAR | 1 |  | Invoice document status |
| 19 | EBELN | 19 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 20 | WERKS | 20 |  | ZWERKS16 | ZWERKS16 | CHAR | 4 |  | -# |
