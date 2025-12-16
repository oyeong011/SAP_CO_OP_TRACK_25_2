# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO01](zekko01.md) 📄 [HTML](zekko01.html) | - | 17 | MANDT, EBELN |
| [ZEKPO01](zekpo01.md) 📄 [HTML](zekpo01.html) | - | 20 | MANDT, EBELN, EBELP ... (+1) |
| [ZLFA1_01](zlfa1_01.md) 📄 [HTML](zlfa1_01.html) | - | 10 | MANDT, LIFNR |
| [ZLFB1_01](zlfb1_01.md) 📄 [HTML](zlfb1_01.html) | - | 10 | MANDT, LIFNR |
| [ZLFM1_01](zlfm1_01.md) 📄 [HTML](zlfm1_01.html) | - | 14 | MANDT, LIFNR |
| [ZMAT01](zmat01.md) 📄 [HTML](zmat01.html) | - | 42 | MANDT, WERKS, LGORT ... (+1) |

---

## 테이블 상세 정보

### ZEKKO01

**Key 필드:** `MANDT, EBELN`

**INCLUDE 구조:** ZEDS01_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | ##### |
| `BEDAT` | DATS | 8 | Purchase Order Date |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zekko01.md) | 📄 [HTML로 보기](zekko01.html)

---

### ZEKPO01

**Key 필드:** `MANDT, EBELN, EBELP, MATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | UNIT | 3 | Order Price Unit (Purchasing) |
| `PRDAT` | DATS | 8 | Date of last forecast |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), UNIT(2), CURR(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zekpo01.md) | 📄 [HTML로 보기](zekpo01.html)

---

### ZLFA1_01

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `ORT01` | CHAR | 25 | City |
| `PSTLZ` | CHAR | 10 | Postal Code |
| `KTOKK` | CHAR | 4 | ##### |

*... 외 3개 필드*

**데이터 타입:** CHAR(9), CLNT(1)

📋 [마크다운으로 보기](zlfa1_01.md) | 📄 [HTML로 보기](zlfa1_01.html)

---

### ZLFB1_01

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | ####(Reconciliation Account) |
| `ZTERM` | CHAR | 4 | - |
| `BANKL` | CHAR | 3 | - |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zlfb1_01.md) | 📄 [HTML로 보기](zlfb1_01.html)

---

### ZLFM1_01

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | - |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_01.md) | 📄 [HTML로 보기](zlfm1_01.html)

---

### ZMAT01

**Key 필드:** `MANDT, WERKS, LGORT, MATNR`

**INCLUDE 구조:** ZEDS01_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAKTX` | CHAR | 40 | Material Description |
| `MTART` | CHAR | 4 | - |
| `MATKL` | CHAR | 9 | Material Group |
| `VPRSV` | CHAR | 1 | Price control indicator |
| `STPRS` | CURR | 11 | Standard price |

*... 외 5개 필드*

**데이터 타입:** CHAR(14), CURR(2), UNIT(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zmat01.md) | 📄 [HTML로 보기](zmat01.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
