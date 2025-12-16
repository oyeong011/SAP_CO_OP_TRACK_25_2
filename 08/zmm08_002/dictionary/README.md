# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT08_EKKO](zedt08_ekko.md) 📄 [HTML](zedt08_ekko.html) | - | 15 | MANDT, EBELN, BUKRS ... (+1) |
| [ZEDT08_EKPO](zedt08_ekpo.md) 📄 [HTML](zedt08_ekpo.html) | - | 18 | MANDT, EBELN, EBELP |
| [ZEDT08_LFA1](zedt08_lfa1.md) 📄 [HTML](zedt08_lfa1.html) | - | 22 | MANDT, LIFNR |
| [ZEDT08_LFB1](zedt08_lfb1.md) 📄 [HTML](zedt08_lfb1.html) | - | 41 | MANDT, LIFNR |
| [ZEDT08_LFM1](zedt08_lfm1.md) 📄 [HTML](zedt08_lfm1.html) | - | 21 | MANDT, LIFNR |
| [ZEDT08_MAT](zedt08_mat.md) 📄 [HTML](zedt08_mat.html) | - | 27 | MANDT, WERKS, LGORT ... (+1) |

---

## 테이블 상세 정보

### ZEDT08_EKKO

**Key 필드:** `MANDT, EBELN, BUKRS, EKGRP`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BEDAT` | DATS | 8 | Purchase Order Date |
| `WAERS` | CUKY | 5 | Currency Key |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt08_ekko.md) | 📄 [HTML로 보기](zedt08_ekko.html)

---

### ZEDT08_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | CURR | 11 | Net price |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt08_ekpo.md) | 📄 [HTML로 보기](zedt08_ekpo.html)

---

### ZEDT08_LFA1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 5 | ### ## |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_lfa1.md) | 📄 [HTML로 보기](zedt08_lfa1.html)

---

### ZEDT08_LFB1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 5 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_lfb1.md) | 📄 [HTML로 보기](zedt08_lfb1.html)

---

### ZEDT08_LFM1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt08_lfm1.md) | 📄 [HTML로 보기](zedt08_lfm1.html)

---

### ZEDT08_MAT

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMATDES` | CHAR | 250 | ## ## |
| `ZMTART` | CHAR | 3 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(3), QUAN(2), UNIT(2), TIMS(2)

📋 [마크다운으로 보기](zedt08_mat.md) | 📄 [HTML로 보기](zedt08_mat.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
