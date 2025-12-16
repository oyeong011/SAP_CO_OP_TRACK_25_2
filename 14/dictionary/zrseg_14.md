# Table: ZRSEG_14

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | EBELP | 6 |  | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 7 | MATNR | 7 |  |  |  | CHAR | 10 |  | - |
| 8 | MAKTX | 8 |  |  |  | CHAR | 20 |  | -# |
| 9 | WERKS | 9 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 10 | MENGE | 10 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 11 | BSTME | 11 |  | BSTME | MEINS | UNIT | 3 | X | Purchase Order Unit of Measure |
| 12 | WRBTR | 12 |  | WRBTR | WERT7 | CURR | 13 |  | Amount in document currency |
| 13 | MWSKZ | 13 |  |  |  | CHAR | 2 |  | - |
| 14 | WMWST | 14 |  | FWSTEV | WERTV7 | CURR | 13 |  | Tax Amount in Document Currency with +/- Sign |
| 15 | SGTXT | 15 |  | SGTXT | TEXT50 | CHAR | 50 | X | Item Text |
| 16 | WAERS | 16 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 17 | MEINS | 17 |  | UNIT | EINHEIT | UNIT | 3 |  | Unit |
| 18 | .INCLUDE | 18 |  | ZEDS14_002 |  |  | 0 |  | - |
| 19 | CRNAME | 19 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 20 | CRDATE | 20 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 21 | CRZEIT | 21 |  | CEPLUZEIT | TIMES | TIMS | 6 |  | Time created |
| 22 | AENAME | 22 |  | AENAM | USNAM | CHAR | 12 |  | Name of person who changed object |
| 23 | AEDATE | 23 |  | AEDAT | DATUM | DATS | 8 |  | Date of Last Change |
| 24 | AEZEIT | 24 |  | AEZEIT | UHRZT | TIMS | 6 |  | Time of Change |
