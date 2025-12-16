# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [Z23EKKO](z23ekko.html) | - | 8 | MANDT, EBELN |
| [Z23EKPO](z23ekpo.html) | - | 19 | MANDT, EBELN, EBELP |
| [Z23LFA1](z23lfa1.html) | - | 15 | MANDT, LIFNR |
| [Z23LFB1](z23lfb1.html) | - | 34 | MANDT, LIFNR |
| [Z23LFM1](z23lfm1.html) | - | 14 | MANDT, LIFNR |
| [Z23MARA](z23mara.html) | - | 21 | MANDT, WERKS, LGORT ... (+1) |
| [Z23MKPF](z23mkpf.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [Z23MSEG](z23mseg.html) | - | 26 | MANDT, MBLNR, MJAHR ... (+1) |
| [Z23RBKP](z23rbkp.html) | - | 31 | MANDT, BELNR, GJAHR |
| [Z23RSEG](z23rseg.html) | - | 15 | MANDT, BELNR, GJAHR ... (+3) |
| [ZTCURR23](ztcurr23.html) | - | 15 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### Z23EKKO

**Key 필드:** `MANDT, EBELN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BEDAT` | DATS | 8 | Purchase Order Date |

*... 외 1개 필드*

**데이터 타입:** CHAR(5), CLNT(1), DATS(1), CUKY(1)

📄 [전체 테이블 구조 보기](z23ekko.html)

---

### Z23EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `STPRS` | CURR | 11 | Standard price |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📄 [전체 테이블 구조 보기](z23ekpo.html)

---

### Z23LFA1

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | Vendor account group |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📄 [전체 테이블 구조 보기](z23lfa1.html)

---

### Z23LFB1

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | Reconciliation Account in General Ledger |
| `ZTERM` | CHAR | 4 | Terms of Payment key |

**데이터 타입:** CHAR(5), CLNT(1)

📄 [전체 테이블 구조 보기](z23lfb1.html)

---

### Z23LFM1

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | Taxes on sales/purchases code |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](z23lfm1.html)

---

### Z23MARA

**Key 필드:** `MANDT, WERKS, LGORT, MATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | Name of Material |
| `MTART` | CHAR | 4 | Type of Material |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |

*... 외 1개 필드*

**데이터 타입:** CHAR(5), CLNT(1), CURR(1), CUKY(1), QUAN(1)

📄 [전체 테이블 구조 보기](z23mara.html)

---

### Z23MKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](z23mkpf.html)

---

### Z23MSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | Storage Location |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(4), CLNT(1), CUKY(1), QUAN(1)

📄 [전체 테이블 구조 보기](z23mseg.html)

---

### Z23RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `XBLNR` | CHAR | 16 | Reference Document Number |
| `BUKRS` | CHAR | 4 | Company Code |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), NUMC(2), DATS(2), CURR(2), CLNT(1)

📄 [전체 테이블 구조 보기](z23rbkp.html)

---

### Z23RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `TXZ01` | CHAR | 20 | Name of Material |
| `WERKS` | CHAR | 4 | Plant |
| `WRBTR` | CURR | 13 | Amount in document currency |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 4개 필드*

**데이터 타입:** CHAR(7), NUMC(3), CURR(2), CLNT(1), QUAN(1)

📄 [전체 테이블 구조 보기](z23rseg.html)

---

### ZTCURR23

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**INCLUDE 구조:** ZEDS23_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(4), DEC(3), CUKY(2), DATS(2), TIMS(2)

📄 [전체 테이블 구조 보기](ztcurr23.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
