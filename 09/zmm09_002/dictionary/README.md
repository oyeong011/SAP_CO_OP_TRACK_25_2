# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_09](zekko_09.md) 📄 [HTML](zekko_09.html) | - | 11 | MANDT, EBELN |
| [ZEKPO_09](zekpo_09.md) 📄 [HTML](zekpo_09.html) | - | 36 | MANDT, EBELN, EBELP |
| [ZLFA1_09](zlfa1_09.md) 📄 [HTML](zlfa1_09.html) | #### ###(## ###) | 15 | MANDT, LIFNR |
| [ZLFB1_09](zlfb1_09.md) 📄 [HTML](zlfb1_09.html) | #### ###(####) | 37 | MANDT, LIFNR, BUKRS |
| [ZLFM1_09](zlfm1_09.md) 📄 [HTML](zlfm1_09.html) | #### ### ### #### ### | 23 | MANDT, LIFNR, EKORG |
| [ZMARA09](zmara09.md) 📄 [HTML](zmara09.html) | - | 31 | MANDT, WERKS, LGORT ... (+1) |

---

## 테이블 상세 정보

### ZEKKO_09

**Key 필드:** `MANDT, EBELN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | ##### |
| `BEDAT` | DATS | 8 | Purchasing Document Date |

*... 외 1개 필드*

**데이터 타입:** CHAR(5), CLNT(1), DATS(1), CUKY(1)

📋 [마크다운으로 보기](zekko_09.md) | 📄 [HTML로 보기](zekko_09.html)

---

### ZEKPO_09

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | - |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `STPRS` | CURR | 11 | Standard price |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📋 [마크다운으로 보기](zekpo_09.md) | 📄 [HTML로 보기](zekpo_09.html)

---

### ZLFA1_09

**설명:** #### ###(## ###)

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | Name 1 |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | - |
| `STCD1` | CHAR | 16 | - |
| `STCD2` | CHAR | 11 | - |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zlfa1_09.md) | 📄 [HTML로 보기](zlfa1_09.html)

---

### ZLFB1_09

**설명:** #### ###(####)

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Flag for Master Record (Company Code Level) |
| `AKONT` | CHAR | 10 | ###### #### |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_09.md) | 📄 [HTML로 보기](zlfb1_09.html)

---

### ZLFM1_09

**설명:** #### ### ### #### ###

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | - |
| `LOEVM` | CHAR | 1 | Delete flag for vendor at purchasing level |
| `WAERS` | CUKY | 5 | Purchase order currency |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_09.md) | 📄 [HTML로 보기](zlfm1_09.html)

---

### ZMARA09

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | - |
| `MTART` | CHAR | 4 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 1개 필드*

**데이터 타입:** CHAR(5), CLNT(1), CURR(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zmara09.md) | 📄 [HTML로 보기](zmara09.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
