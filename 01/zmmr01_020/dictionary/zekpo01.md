# Table: ZEKPO01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | ZEBELN01 | EBELN | CHAR | 10 |  | -- |
| 3 | EBELP | 3 | X | EBELP | EBELP | NUMC | 5 |  | Item Number of Purchasing Document |
| 4 | MATNR | 4 | X | ZMATNR01 | MATNR | CHAR | 18 |  | - |
| 5 | MAKTX | 5 |  | MAKTX | TEXT40 | CHAR | 40 | X | Material Description |
| 6 | MENGE | 6 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 7 | MEINS | 7 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 8 | BPRME | 8 |  | BPRME | MEINS | UNIT | 3 | X | Order Price Unit (Purchasing) |
| 9 | PRDAT | 9 |  | PRDAT | DATUM | DATS | 8 |  | Date of last forecast |
| 10 | WERKS | 10 |  | ZWERKS01 | WERKS | CHAR | 4 |  | -# |
| 11 | LGORT | 11 |  | ZLGORT01 | LGORT | CHAR | 4 |  | - |
| 12 | MWSKZ | 12 |  | ZMWSKZ01 | ZTAXCODE01 | CHAR | 2 |  | - |
| 13 | NETPR | 13 |  | NETPR | WERTV6 | CURR | 11 |  | Net price |
| 14 | NETWR | 14 |  | NETWR | WERTV8 | CURR | 15 |  | Net Value in Document Currency |
| 15 | MATKL | 15 |  | MATKL | MATKL | CHAR | 9 |  | Material Group |
