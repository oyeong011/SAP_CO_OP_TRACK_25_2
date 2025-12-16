# Table: ZEDT20_EKPO

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 |  | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MENGE | 6 |  | ZMENGE20 |  | QUAN | 15 |  | - |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | BPRME | 8 |  | BPREI | WERT11 | CURR | 11 |  | Net Price in Purchasing Document (in Document Currency) |
| 9 | PRDAT | 9 |  | PRDAT | DATUM | DATS | 8 |  | Date of last forecast |
| 10 | WERKS | 10 |  | WERKS_D | WERKS | CHAR | 4 |  | Plant |
| 11 | LGORT | 11 |  | LGORT_D | LGORT | CHAR | 4 |  | Storage Location |
