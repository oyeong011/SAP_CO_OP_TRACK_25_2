# Table: ZRBKP_14

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUKRS | 4 |  | BUKRS | BUKRS | CHAR | 4 |  | Company Code |
| 5 | LIFNR | 5 |  | LIFNR | LIFNR | CHAR | 10 |  | Account Number of Vendor or Creditor |
| 6 | BLART | 6 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 7 | BLDAT | 7 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 8 | BUDAT | 8 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 9 | RMWWR | 9 |  | RMWWR | WERT7 | CURR | 13 |  | Gross invoice amount in document currency |
| 10 | WAERS | 10 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 11 | ZTERM | 11 |  |  |  | CHAR | 4 |  | - |
| 12 | MWSKZ | 12 |  |  |  | CHAR | 2 |  | - |
| 13 | XMWST | 13 |  | XMWST | XFELD | CHAR | 1 |  | Calculate tax automatically |
| 14 | WMWST | 14 |  | WMWST | WERT7 | CURR | 13 |  | Tax Amount in Document Currency |
| 15 | STBLG | 15 |  | STBLG | BELNR | CHAR | 10 |  | Reverse Document Number |
| 16 | STJAH | 16 |  | STJAH | GJAHR | NUMC | 4 |  | Reverse document fiscal year |
| 17 | RBSTAT | 17 |  | RBSTAT | RBSTAT | CHAR | 1 |  | Invoice document status |
| 18 | BKTXT | 18 |  | BKTXT | TEXT25 | CHAR | 25 | X | Document Header Text |
| 19 | EBELN | 19 |  | BSTNR | EBELN | CHAR | 10 |  | Purchase order number |
| 20 | WERKS | 20 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 21 | .INCLUDE | 21 |  | ZEDS14_002 |  |  | 0 |  | - |
| 22 | CRNAME | 22 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 23 | CRDATE | 23 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 24 | CRZEIT | 24 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 25 | AENAME | 25 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 26 | AEDATE | 26 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 27 | AEZEIT | 27 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
