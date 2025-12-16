# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT21_200](zedt21_200.md) 📄 [HTML](zedt21_200.html) | - | 23 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZEKKO21](zekko21.md) 📄 [HTML](zekko21.html) | - | 8 | MANDT, EBELN |
| [ZEKPO21](zekpo21.md) 📄 [HTML](zekpo21.html) | - | 11 | MANDT, EBELN, EBELP |
| [ZLFB1_21](zlfb1_21.md) 📄 [HTML](zlfb1_21.html) | - | 34 | MANDT, LIFNR |
| [ZLFM1_21](zlfm1_21.md) 📄 [HTML](zlfm1_21.html) | - | 14 | MANDT, LIFNR |

---

## 테이블 상세 정보

### ZEDT21_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMTART` | CHAR | 3 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt21_200.md) | 📄 [HTML로 보기](zedt21_200.html)

---

### ZEKKO21

**Key 필드:** `MANDT, EBELN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | Vendor's account number |
| `BEDAT` | DATS | 8 | Purchasing Document Date |

*... 외 1개 필드*

**데이터 타입:** CHAR(5), CLNT(1), DATS(1), CUKY(1)

📋 [마크다운으로 보기](zekko21.md) | 📄 [HTML로 보기](zekko21.html)

---

### ZEKPO21

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |
| `MEINS` | UNIT | 3 | Purchase Order Unit of Measure |
| `BPRME` | CURR | 11 | Standard price |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zekpo21.md) | 📄 [HTML로 보기](zekpo21.html)

---

### ZLFB1_21

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_21.md) | 📄 [HTML로 보기](zlfb1_21.html)

---

### ZLFM1_21

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_21.md) | 📄 [HTML로 보기](zlfm1_21.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
