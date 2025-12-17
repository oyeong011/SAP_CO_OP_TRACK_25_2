# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT17_EKKO](zedt17_ekko.md) 📄 [HTML](zedt17_ekko.html) | - | 15 | MANDT, EBELN |
| [ZEDT17_EKPO](zedt17_ekpo.md) 📄 [HTML](zedt17_ekpo.html) | - | 33 | MANDT, EBELN, EBELP |
| [ZEDT17_LFA1](zedt17_lfa1.md) 📄 [HTML](zedt17_lfa1.html) | - | 21 | MANDT, LIFNR |
| [ZEDT17_LFM1](zedt17_lfm1.md) 📄 [HTML](zedt17_lfm1.html) | - | 21 | MANDT, LIFNR, EKORG |
| [ZMARA17](zmara17.md) 📄 [HTML](zmara17.html) | - | 37 | MANDT, ZWERKS, ZLGORT ... (+1) |

---

## 테이블 상세 정보

### ZEDT17_EKKO

**Key 필드:** `MANDT, EBELN`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BEDAT` | DATS | 8 | Purchase Order Date |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt17_ekko.md) | 📄 [HTML로 보기](zedt17_ekko.html)

---

### ZEDT17_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | UNIT | 3 | Order Price Unit (Purchasing) |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), UNIT(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_ekpo.md) | 📄 [HTML로 보기](zedt17_ekpo.html)

---

### ZEDT17_LFA1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_lfa1.md) | 📄 [HTML로 보기](zedt17_lfa1.html)

---

### ZEDT17_LFM1

**Key 필드:** `MANDT, LIFNR, EKORG`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt17_lfm1.md) | 📄 [HTML로 보기](zedt17_lfm1.html)

---

### ZMARA17

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMTART` | CHAR | 4 | - |
| `ZMODEL` | CHAR | 6 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmara17.md) | 📄 [HTML로 보기](zmara17.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
