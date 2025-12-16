# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT17_EKKO](zedt17_ekko.md) 📄 [HTML](zedt17_ekko.html) | - | 15 | MANDT, EBELN |
| [ZEDT17_EKPO](zedt17_ekpo.md) 📄 [HTML](zedt17_ekpo.html) | - | 33 | MANDT, EBELN, EBELP |
| [ZEDT17_MKPF](zedt17_mkpf.md) 📄 [HTML](zedt17_mkpf.html) | - | 13 | MANDT, MBLNR, MJAHR |
| [ZEDT17_MSEG](zedt17_mseg.md) 📄 [HTML](zedt17_mseg.html) | - | 40 | MANDT, MBLNR, MJAHR ... (+1) |

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

### ZEDT17_MKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(4), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt17_mkpf.md) | 📄 [HTML로 보기](zedt17_mkpf.html)

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

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
