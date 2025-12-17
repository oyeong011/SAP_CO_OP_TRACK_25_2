# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT16_EKKO](zedt16_ekko.md) 📄 [HTML](zedt16_ekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT16_EKPO](zedt16_ekpo.md) 📄 [HTML](zedt16_ekpo.html) | - | 26 | MANDT, EBELN, EBELP |
| [ZEDT16_LFA1](zedt16_lfa1.md) 📄 [HTML](zedt16_lfa1.html) | - | 15 | MANDT, LIFNR |
| [ZEDT16_LFB1](zedt16_lfb1.md) 📄 [HTML](zedt16_lfb1.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZEDT16_LFM1](zedt16_lfm1.md) 📄 [HTML](zedt16_lfm1.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZEDT16_MKPF](zedt16_mkpf.md) 📄 [HTML](zedt16_mkpf.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZEDT16_MSEG](zedt16_mseg.md) 📄 [HTML](zedt16_mseg.html) | - | 41 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT16_RBKP](zedt16_rbkp.md) 📄 [HTML](zedt16_rbkp.html) | - | 50 | MANDT, BELNR, GJAHR |
| [ZEDT16_RSEG](zedt16_rseg.md) 📄 [HTML](zedt16_rseg.html) | - | 45 | MANDT, BELNR, GJAHR ... (+1) |

---

## 테이블 상세 정보

### ZEDT16_EKKO

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

📋 [마크다운으로 보기](zedt16_ekko.md) | 📄 [HTML로 보기](zedt16_ekko.html)

---

### ZEDT16_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | CURR | 11 | Net Price in Purchasing Document (in Document Currency) |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zedt16_ekpo.md) | 📄 [HTML로 보기](zedt16_ekpo.html)

---

### ZEDT16_LFA1

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | Name 1 |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | Vendor account group |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zedt16_lfa1.md) | 📄 [HTML로 보기](zedt16_lfa1.html)

---

### ZEDT16_LFB1

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zedt16_lfb1.md) | 📄 [HTML로 보기](zedt16_lfb1.html)

---

### ZEDT16_LFM1

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt16_lfm1.md) | 📄 [HTML로 보기](zedt16_lfm1.html)

---

### ZEDT16_MKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt16_mkpf.md) | 📄 [HTML로 보기](zedt16_mkpf.html)

---

### ZEDT16_MSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**INCLUDE 구조:** ZEDS16_002

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

📋 [마크다운으로 보기](zedt16_mseg.md) | 📄 [HTML로 보기](zedt16_mseg.html)

---

### ZEDT16_RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |

*... 외 5개 필드*

**데이터 타입:** CHAR(12), NUMC(2), DATS(2), CURR(2), CLNT(1)

📋 [마크다운으로 보기](zedt16_rbkp.md) | 📄 [HTML로 보기](zedt16_rbkp.html)

---

### ZEDT16_RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 10 | - |
| `TXZ01` | CHAR | 20 | ### |
| `WERKS` | CHAR | 4 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(3), CURR(2), QUAN(2), UNIT(2)

📋 [마크다운으로 보기](zedt16_rseg.md) | 📄 [HTML로 보기](zedt16_rseg.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
