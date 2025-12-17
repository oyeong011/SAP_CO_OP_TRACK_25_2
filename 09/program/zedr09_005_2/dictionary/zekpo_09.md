# Table: ZEKPO_09

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X |  |  | NUMC | 5 |  | - - - |
| 4 | MATNR | 4 |  | ZMATNR_09 | ZMATNR_09 | CHAR | 10 |  | - |
| 5 | MAKTX | 5 |  | ZMATNAME09 | ZMATNAME09 | CHAR | 20 |  | - |
| 6 | MENGE | 6 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | STPRS | 8 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 9 | PRDAT | 9 |  | PREDT | DATUM | DATS | 8 |  | Date of Price Determination |
| 10 | WERKS | 10 |  | ZWERKS09 | ZWERKS09 | CHAR | 4 |  | -# |
| 11 | LGORT | 11 |  | ZLGORT09 | ZLGORT09 | CHAR | 4 |  | - |
| 12 | MWSKZ | 12 |  | ZMWSKZ09 | ZMWSKZ09 | CHAR | 2 |  |  |
| 13 | BPRME | 13 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 14 | PSTYP | 14 |  | ZPSTYP09 | ZPSTYP09 | CHAR | 1 |  |  |
