# Table: ZEKPO_13

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 | X | MATNR | MATNR | CHAR | 18 |  | Material Number |
| 5 | MATNAME | 5 |  | ZMATNAME13 | ZMATNAME13 | CHAR | 20 |  | -# |
| 6 | MAKTX | 6 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 7 | MENGE | 7 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 8 | WEMNG | 8 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 9 | MEINS | 9 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 10 | BPRME | 10 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 11 | STPRS | 11 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 12 | PRDAT | 12 |  | PRDAT | DATUM | DATS | 8 |  | Date of last forecast |
| 13 | WERKS | 13 |  | ZWERKS13 | ZWERKS13 | CHAR | 4 |  | -# |
| 14 | LGORT | 14 |  | ZLGORT13 | ZLGORT13 | CHAR | 4 |  | - |
| 15 | MWSKZ | 15 |  | ZMWSKZ13 | ZMWSKZ13 | CHAR | 2 |  | - |
