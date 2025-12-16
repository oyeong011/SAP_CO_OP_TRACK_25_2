# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_15](zekko_15.md) 📄 [HTML](zekko_15.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_15](zekpo_15.md) 📄 [HTML](zekpo_15.html) | - | 24 | MANDT, EBELN, EBELP |
| [ZLFM1_15](zlfm1_15.md) 📄 [HTML](zlfm1_15.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZMAT_15](zmat_15.md) 📄 [HTML](zmat_15.html) | - | 31 | MANDT, ZWERKS, ZLGORT ... (+1) |

---

## 테이블 상세 정보

### ZEKKO_15

**Key 필드:** `MANDT, EBELN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BEDAT` | DATS | 8 | Purchasing Document Date |

*... 외 1개 필드*

**데이터 타입:** CHAR(5), CLNT(1), DATS(1), CUKY(1)

📋 [마크다운으로 보기](zekko_15.md) | 📄 [HTML로 보기](zekko_15.html)

---

### ZEKPO_15

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |
| `WEMNG` | QUAN | 13 | Quantity of Goods Received |
| `MEINS` | UNIT | 3 | Purchase Order Unit of Measure |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), QUAN(2), CLNT(1), NUMC(1), UNIT(1)

📋 [마크다운으로 보기](zekpo_15.md) | 📄 [HTML로 보기](zekpo_15.html)

---

### ZLFM1_15

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Delete flag for vendor at purchasing level |
| `WAERS` | CUKY | 5 | Purchase order currency |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_15.md) | 📄 [HTML로 보기](zlfm1_15.html)

---

### ZMAT_15

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS15_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMTART` | CHAR | 4 | ####(####) |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmat_15.md) | 📄 [HTML로 보기](zmat_15.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
