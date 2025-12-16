# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_12](zekko_12.md) 📄 [HTML](zekko_12.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_12](zekpo_12.md) 📄 [HTML](zekpo_12.html) | - | 17 | MANDT, EBELN, EBELP ... (+1) |
| [ZMKPF_12](zmkpf_12.md) 📄 [HTML](zmkpf_12.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG_12](zmseg_12.md) 📄 [HTML](zmseg_12.html) | - | 30 | MANDT, MBLNR, MJAHR ... (+1) |

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

### ZMKPF_12

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf_12.md) | 📄 [HTML로 보기](zmkpf_12.html)

---

### ZMSEG_12

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | ### |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Vendor's account number |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(6), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zmseg_12.md) | 📄 [HTML로 보기](zmseg_12.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
