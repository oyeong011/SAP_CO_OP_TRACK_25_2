# Table: ZMKPF_14

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | MBLNR | 2 | X | MBLNR | BELNR | CHAR | 10 |  | Number of Material Document |
| 3 | MJAHR | 3 | X | MJAHR | GJAHR | NUMC | 4 |  | Material Document Year |
| 4 | BLART | 4 |  | BLART | BLART | CHAR | 2 |  | Document type |
| 5 | BLDAT | 5 |  | BLDAT | DATUM | DATS | 8 |  | Document Date in Document |
| 6 | BUDAT | 6 |  | BUDAT | DATUM | DATS | 8 |  | Posting Date in the Document |
| 7 | EBELN | 7 |  | BSTNR | EBELN | CHAR | 10 |  | Purchase order number |
| 8 | WERKS | 8 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 9 | .INCLUDE | 9 |  | ZEDS14_002 |  |  | 0 |  | - |
| 10 | CRNAME | 10 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 11 | CRDATE | 11 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 12 | CRZEIT | 12 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 13 | AENAME | 13 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 14 | AEDATE | 14 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 15 | AEZEIT | 15 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
