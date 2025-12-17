# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_22](zekko_22.md) 📄 [HTML](zekko_22.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_22](zekpo_22.md) 📄 [HTML](zekpo_22.html) | - | 25 | MANDT, EBELN, EBELP |
| [ZRBKP_22](zrbkp_22.md) 📄 [HTML](zrbkp_22.html) | - | 50 | MANDT, BELNR, GJAHR |
| [ZRSEG_22](zrseg_22.md) 📄 [HTML](zrseg_22.html) | - | 29 | MANDT, BELNR, GJAHR ... (+1) |

---

## 테이블 상세 정보

### ZEKKO_22

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

📋 [마크다운으로 보기](zekko_22.md) | 📄 [HTML로 보기](zekko_22.html)

---

### ZEKPO_22

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `STPRS` | CURR | 11 | Standard price |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📋 [마크다운으로 보기](zekpo_22.md) | 📄 [HTML로 보기](zekpo_22.html)

---

### ZRBKP_22

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

**데이터 타입:** CHAR(12), DATS(3), NUMC(2), CURR(2), CLNT(1)

📋 [마크다운으로 보기](zrbkp_22.md) | 📄 [HTML로 보기](zrbkp_22.html)

---

### ZRSEG_22

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 10 | - |
| `TXZ01` | CHAR | 20 | ### |
| `WERKS` | CHAR | 4 | Plant |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CURR(3), UNIT(2), CLNT(1)

📋 [마크다운으로 보기](zrseg_22.md) | 📄 [HTML로 보기](zrseg_22.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
