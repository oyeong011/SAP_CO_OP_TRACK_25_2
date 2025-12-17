# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT20_EKKO](zedt20_ekko.md) 📄 [HTML](zedt20_ekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT20_EKPO](zedt20_ekpo.md) 📄 [HTML](zedt20_ekpo.html) | - | 11 | MANDT, EBELN, EBELP |
| [ZEDT20_LFA1](zedt20_lfa1.md) 📄 [HTML](zedt20_lfa1.html) | - | 14 | MANDT, LIFNR |
| [ZEDT20_MARA](zedt20_mara.md) 📄 [HTML](zedt20_mara.html) | - | 7 | MANDT, MATNR |
| [ZEDT20_MKPF](zedt20_mkpf.md) 📄 [HTML](zedt20_mkpf.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZEDT20_MSEG](zedt20_mseg.md) 📄 [HTML](zedt20_mseg.html) | - | 22 | MANDT, MBLNR, MJAHR ... (+1) |

---

## 테이블 상세 정보

### ZEDT20_EKKO

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

📋 [마크다운으로 보기](zedt20_ekko.md) | 📄 [HTML로 보기](zedt20_ekko.html)

---

### ZEDT20_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 15 | - |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | CURR | 11 | Net Price in Purchasing Document (in Document Currency) |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zedt20_ekpo.md) | 📄 [HTML로 보기](zedt20_ekpo.html)

---

### ZEDT20_LFA1

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zedt20_lfa1.md) | 📄 [HTML로 보기](zedt20_lfa1.html)

---

### ZEDT20_MARA

**Key 필드:** `MANDT, MATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAKTX` | CHAR | 40 | Material Description |
| `MTART` | CHAR | 4 | Material Type |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | CURR | 11 | Net Price in Purchasing Document (in Document Currency) |
| `WAERS` | CUKY | 5 | Currency Key |

**데이터 타입:** CHAR(3), CLNT(1), UNIT(1), CURR(1), CUKY(1)

📋 [마크다운으로 보기](zedt20_mara.md) | 📄 [HTML로 보기](zedt20_mara.html)

---

### ZEDT20_MKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt20_mkpf.md) | 📄 [HTML로 보기](zedt20_mkpf.html)

---

### ZEDT20_MSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | Storage Location |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zedt20_mseg.md) | 📄 [HTML로 보기](zedt20_mseg.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
