# Table: ZRSEG_12

| Row | Field name | Position | Key | Data element | Domain | Datatype | Length | Lowercase | Domain text |
|---|---|---|---|---|---|---|---|---|---|
| 1 | MANDT | 1 | X | MANDT | MANDT | CLNT | 3 |  | Client |
| 2 | BELNR | 2 | X | RE_BELNR | BELNR | CHAR | 10 |  | Document Number of an Invoice Document |
| 3 | GJAHR | 3 | X | GJAHR | GJAHR | NUMC | 4 |  | Fiscal Year |
| 4 | BUZEI | 4 | X | RBLGP | NUMC6 | NUMC | 6 |  | Document Item in Invoice Document |
| 5 | EBELN | 5 |  | EBELN | EBELN | CHAR | 10 |  | Purchasing Document Number |
| 6 | WERKS | 6 |  | ZWERKS12 | ZWERKS12 | CHAR | 4 |  | -# |
| 7 | MATNR | 7 |  | ZMATNR12 | ZMATNR12 | CHAR | 10 |  | - |
| 8 | MENGE | 8 |  | MENGE_D | MENG13 | QUAN | 13 |  | Quantity |
| 9 | MEINS | 9 |  | MEINS | MEINS | UNIT | 3 | X | Base Unit of Measure |
| 10 | MWSKZ | 10 |  | ZMWSKZ12 | ZMWSKZ12 | CHAR | 2 |  | - |
| 11 | STPRS | 11 |  | STPRS | WERT11V | CURR | 11 |  | Standard price |
| 12 | NETAM | 12 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
| 13 | MWSTS | 13 |  | MWSTS | WERT7 | CURR | 13 |  | Tax Amount in Local Currency |
| 14 | GROSS | 14 |  | DMBTR | WERT7 | CURR | 13 |  | Amount in local currency |
