# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT17_EKKO](zedt17_ekko.md) 📄 [HTML](zedt17_ekko.html) | - | 15 | MANDT, EBELN |
| [ZEDT17_EKPO](zedt17_ekpo.md) 📄 [HTML](zedt17_ekpo.html) | - | 33 | MANDT, EBELN, EBELP |
| [ZEDT17_LFM1](zedt17_lfm1.md) 📄 [HTML](zedt17_lfm1.html) | - | 21 | MANDT, LIFNR, EKORG |
| [ZEDT17_MSEG](zedt17_mseg.md) 📄 [HTML](zedt17_mseg.html) | - | 40 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT17_RBKP](zedt17_rbkp.md) 📄 [HTML](zedt17_rbkp.html) | - | 32 | MANDT, BELNR, GJAHR |
| [ZEDT17_RSEG](zedt17_rseg.md) 📄 [HTML](zedt17_rseg.html) | - | 40 | MANDT, BELNR, GJAHR ... (+1) |

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

### ZEDT17_MSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 4 | ### |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), NUMC(3), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_mseg.md) | 📄 [HTML로 보기](zedt17_mseg.html)

---

### ZEDT17_RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(5), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt17_rbkp.md) | 📄 [HTML로 보기](zedt17_rbkp.html)

---

### ZEDT17_RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `ZMATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `ZWERKS` | CHAR | 4 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CURR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zedt17_rseg.md) | 📄 [HTML로 보기](zedt17_rseg.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
