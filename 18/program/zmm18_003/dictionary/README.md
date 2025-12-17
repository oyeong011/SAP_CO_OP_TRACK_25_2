# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_18](zekko_18.md) 📄 [HTML](zekko_18.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_18](zekpo_18.md) 📄 [HTML](zekpo_18.html) | - | 25 | MANDT, EBELN, EBELP |
| [ZMARA_18](zmara_18.md) 📄 [HTML](zmara_18.html) | - | 30 | MANDT, WERKS, LGORT ... (+1) |
| [ZMKPF_18](zmkpf_18.md) 📄 [HTML](zmkpf_18.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG_18](zmseg_18.md) 📄 [HTML](zmseg_18.html) | - | 26 | MANDT, MBLNR, MJAHR ... (+1) |

---

## 테이블 상세 정보

### ZEKKO_18

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

📋 [마크다운으로 보기](zekko_18.md) | 📄 [HTML로 보기](zekko_18.html)

---

### ZEKPO_18

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `NETPR` | CURR | 11 | Net price |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📋 [마크다운으로 보기](zekpo_18.md) | 📄 [HTML로 보기](zekpo_18.html)

---

### ZMARA_18

**Key 필드:** `MANDT, WERKS, LGORT, MATNR`

**INCLUDE 구조:** ZEDS018_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MTART` | CHAR | 5 | - |
| `MAKTX` | CHAR | 20 | ### |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmara_18.md) | 📄 [HTML로 보기](zmara_18.html)

---

### ZMKPF_18

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf_18.md) | 📄 [HTML로 보기](zmkpf_18.html)

---

### ZMSEG_18

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 4 | ### |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Vendor's account number |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), NUMC(4), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zmseg_18.md) | 📄 [HTML로 보기](zmseg_18.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
