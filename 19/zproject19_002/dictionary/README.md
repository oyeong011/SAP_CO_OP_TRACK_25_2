# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT19_200](zedt19_200.md) 📄 [HTML](zedt19_200.html) | - | 24 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZPDT19_003](zpdt19_003.md) 📄 [HTML](zpdt19_003.html) | - | 13 | LIFNR, EKORG |
| [ZPDT19_004](zpdt19_004.md) 📄 [HTML](zpdt19_004.html) | - | 8 | MANDT, EBELN |
| [ZPDT19_005](zpdt19_005.md) 📄 [HTML](zpdt19_005.html) | - | 18 | MANDT, EBELN, EBELP |

---

## 테이블 상세 정보

### ZEDT19_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS19_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `MTART` | CHAR | 4 | Material Type |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt19_200.md) | 📄 [HTML로 보기](zedt19_200.html)

---

### ZPDT19_003

**Key 필드:** `LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `ZMWSKZ` | CHAR | 2 | ### |

**데이터 타입:** CHAR(5), CUKY(1)

📋 [마크다운으로 보기](zpdt19_003.md) | 📄 [HTML로 보기](zpdt19_003.html)

---

### ZPDT19_004

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

📋 [마크다운으로 보기](zpdt19_004.md) | 📄 [HTML로 보기](zpdt19_004.html)

---

### ZPDT19_005

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |
| `MEINS` | UNIT | 3 | Purchase Order Unit of Measure |
| `PRDAT` | DATS | 8 | Date of last forecast |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zpdt19_005.md) | 📄 [HTML로 보기](zpdt19_005.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
