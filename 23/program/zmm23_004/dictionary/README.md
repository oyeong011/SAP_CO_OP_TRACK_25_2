# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [Z23EKKO](z23ekko.md) 📄 [HTML](z23ekko.html) | - | 8 | MANDT, EBELN |
| [Z23EKPO](z23ekpo.md) 📄 [HTML](z23ekpo.html) | - | 19 | MANDT, EBELN, EBELP |
| [Z23RBKP](z23rbkp.md) 📄 [HTML](z23rbkp.html) | - | 31 | MANDT, BELNR, GJAHR |
| [Z23RSEG](z23rseg.md) 📄 [HTML](z23rseg.html) | - | 15 | MANDT, BELNR, GJAHR ... (+3) |

---

## 테이블 상세 정보

### Z23EKKO

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

📋 [마크다운으로 보기](z23ekko.md) | 📄 [HTML로 보기](z23ekko.html)

---

### Z23EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `STPRS` | CURR | 11 | Standard price |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](z23ekpo.md) | 📄 [HTML로 보기](z23ekpo.html)

---

### Z23RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `XBLNR` | CHAR | 16 | Reference Document Number |
| `BUKRS` | CHAR | 4 | Company Code |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), NUMC(2), DATS(2), CURR(2), CLNT(1)

📋 [마크다운으로 보기](z23rbkp.md) | 📄 [HTML로 보기](z23rbkp.html)

---

### Z23RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `TXZ01` | CHAR | 20 | Name of Material |
| `WERKS` | CHAR | 4 | Plant |
| `WRBTR` | CURR | 13 | Amount in document currency |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 4개 필드*

**데이터 타입:** CHAR(7), NUMC(3), CURR(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](z23rseg.md) | 📄 [HTML로 보기](z23rseg.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
