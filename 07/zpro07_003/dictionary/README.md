# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZPRO07_004](zpro07_004.md) 📄 [HTML](zpro07_004.html) | - | 8 | MANDT, EBELN |
| [ZPRO07_005](zpro07_005.md) 📄 [HTML](zpro07_005.html) | - | 11 | MANDT, EBELN, EBELP |
| [ZPRO07_006](zpro07_006.md) 📄 [HTML](zpro07_006.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZPRO07_007](zpro07_007.md) 📄 [HTML](zpro07_007.html) | - | 19 | MANDT, MBLNR, MJAHR ... (+1) |

---

## 테이블 상세 정보

### ZPRO07_004

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

📋 [마크다운으로 보기](zpro07_004.md) | 📄 [HTML로 보기](zpro07_004.html)

---

### ZPRO07_005

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

📋 [마크다운으로 보기](zpro07_005.md) | 📄 [HTML로 보기](zpro07_005.html)

---

### ZPRO07_006

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zpro07_006.md) | 📄 [HTML로 보기](zpro07_006.html)

---

### ZPRO07_007

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | Storage Location |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zpro07_007.md) | 📄 [HTML로 보기](zpro07_007.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
