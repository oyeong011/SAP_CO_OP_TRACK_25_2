# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_12](zekko_12.md) 📄 [HTML](zekko_12.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_12](zekpo_12.md) 📄 [HTML](zekpo_12.html) | - | 17 | MANDT, EBELN, EBELP ... (+1) |
| [ZLFA1_12](zlfa1_12.md) 📄 [HTML](zlfa1_12.html) | - | 15 | MANDT, LIFNR |
| [ZLFB1_12](zlfb1_12.md) 📄 [HTML](zlfb1_12.html) | - | 34 | MANDT, LIFNR |
| [ZLFM1_12](zlfm1_12.md) 📄 [HTML](zlfm1_12.html) | - | 14 | MANDT, LIFNR |
| [ZMARA_12](zmara_12.md) 📄 [HTML](zmara_12.html) | - | 30 | MANDT, WERKS, LGORT ... (+1) |

---

## 테이블 상세 정보

### ZEKKO_12

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

📋 [마크다운으로 보기](zekko_12.md) | 📄 [HTML로 보기](zekko_12.html)

---

### ZEKPO_12

**Key 필드:** `MANDT, EBELN, EBELP, MATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNAME` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | Quantity |
| `STPRS` | CURR | 11 | Standard price |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `PRDAT` | DATS | 8 | Date of last forecast |

*... 외 3개 필드*

**데이터 타입:** CHAR(6), CLNT(1), NUMC(1), QUAN(1), CURR(1)

📋 [마크다운으로 보기](zekpo_12.md) | 📄 [HTML로 보기](zekpo_12.html)

---

### ZLFA1_12

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | - |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zlfa1_12.md) | 📄 [HTML로 보기](zlfa1_12.html)

---

### ZLFB1_12

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | ####(Reconciliation Account) |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_12.md) | 📄 [HTML로 보기](zlfb1_12.html)

---

### ZLFM1_12

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_12.md) | 📄 [HTML로 보기](zlfm1_12.html)

---

### ZMARA_12

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**INCLUDE 구조:** ZEDS12_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNAME` | CHAR | 20 | ### |
| `MTART` | CHAR | 4 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmara_12.md) | 📄 [HTML로 보기](zmara_12.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
