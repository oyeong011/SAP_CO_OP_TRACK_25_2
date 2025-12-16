# Table: ZEKKO01

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | EBELN | 2 | X | ZEBELN01 | EBELN | CHAR | 10 |  | -- |
| 3 | BUKRS | 3 |  | ZBUKRS01 | BUKRS | CHAR | 4 |  | - |
| 4 | EKGRP | 4 |  | EKGRP | EKGRP | CHAR | 3 |  | Purchasing Group |
| 5 | EKORG | 5 |  | EKORG | EKORG | CHAR | 4 |  | Purchasing Organization |
| 6 | LIFNR | 6 |  | ZLIFNR01 | LIFNR | CHAR | 10 |  | -# |
| 7 | BEDAT | 7 |  | BEDAT | DATUM | DATS | 8 |  | Purchase Order Date |
| 8 | WAERS | 8 |  | WAERS | WAERS | CUKY | 5 |  | Currency Key |
| 9 | INCO1 | 9 |  | INCO1 | INCO1 | CHAR | 3 |  | Incoterms (Part 1) |
| 10 | INCO2 | 10 |  | INCO2 | INCO2 | CHAR | 28 | X | Incoterms (Part 2) |
| 11 | .INCLUDE | 11 |  | ZEDS01_002 |  |  | 0 |  | - |
| 12 | CRNAME | 12 |  | CRNAM | USNAM | CHAR | 12 |  | Created By |
| 13 | CRDATE | 13 |  | CRDAT | DATUM | DATS | 8 |  | Creation date |
| 14 | CRZEIT | 14 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
| 15 | AENAME | 15 |  | AENAME | UNAME | CHAR | 12 |  | Last Changed By |
| 16 | AEDATE | 16 |  | DATS | DATS | DATS | 8 |  | Field of type DATS |
| 17 | AEZEIT | 17 |  | TIMS | TIME | TIMS | 6 |  | Field of type TIMS |
