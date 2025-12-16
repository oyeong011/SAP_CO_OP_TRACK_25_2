# Table: ZSTPO09
**Description:** BOM ##

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | STLNR | 2 | X | STNUM | STNUM | CHAR | 8 |  | Bill of material |
| 3 | STLKN | 3 | X | STLKN | KNTNR | NUMC | 8 |  | BOM item node number |
| 4 | IDNRK | 4 |  | ZMATNR_09 | ZMATNR_09 | CHAR | 10 |  | - |
| 5 | MENGE | 5 |  | KMPMG | MENGV13 | QUAN | 13 |  | Component quantity |
| 6 | MEINS | 6 |  | KMPME | MEINS | UNIT | 3 | X | Component unit of measure |
