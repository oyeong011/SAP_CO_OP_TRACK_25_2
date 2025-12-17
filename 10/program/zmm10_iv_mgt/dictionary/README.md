# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT10_BSIK](zedt10_bsik.md) 📄 [HTML](zedt10_bsik.html) | - | 25 | MANDT, BUKRS, LIFNR ... (+3) |
| [ZEDT10_EKBE](zedt10_ekbe.md) 📄 [HTML](zedt10_ekbe.html) | - | 40 | MANDT, EBELN, EBELP ... (+5) |
| [ZEDT10_EKKO](zedt10_ekko.md) 📄 [HTML](zedt10_ekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT10_EKPO](zedt10_ekpo.md) 📄 [HTML](zedt10_ekpo.html) | - | 15 | MANDT, EBELN, EBELP |
| [ZEDT10_LFM1](zedt10_lfm1.md) 📄 [HTML](zedt10_lfm1.html) | - | 9 | MANDT, LIFNR, EKORG |
| [ZEDT10_MWSKZ](zedt10_mwskz.md) 📄 [HTML](zedt10_mwskz.html) | - | 6 | MANDT, MWSKZ, SPRAS |
| [ZEDT10_RBKP](zedt10_rbkp.md) 📄 [HTML](zedt10_rbkp.html) | - | 20 | MANDT, BELNR, GJAHR |
| [ZEDT10_RSEG](zedt10_rseg.md) 📄 [HTML](zedt10_rseg.html) | - | 25 | MANDT, BELNR, GJAHR ... (+1) |

---

## 테이블 상세 정보

### ZEDT10_BSIK

**Key 필드:** `MANDT, BUKRS, LIFNR, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(5), NUMC(2), CURR(2), TIMS(2)

📋 [마크다운으로 보기](zedt10_bsik.md) | 📄 [HTML로 보기](zedt10_bsik.html)

---

### ZEDT10_EKBE

**Key 필드:** `MANDT, EBELN, EBELP, ZEKKN, VGABE, GJAHR, BELNR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEWTP` | CHAR | 1 | Purchase Order History Category |
| `BWART` | CHAR | 3 | Movement type (inventory management) |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `MENGE` | QUAN | 13 | Quantity |
| `DMBTR` | CURR | 13 | Amount in local currency |

*... 외 3개 필드*

**데이터 타입:** CHAR(6), NUMC(4), CUKY(2), CLNT(1), UNIT(1)

📋 [마크다운으로 보기](zedt10_ekbe.md) | 📄 [HTML로 보기](zedt10_ekbe.html)

---

### ZEDT10_EKKO

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

📋 [마크다운으로 보기](zedt10_ekko.md) | 📄 [HTML로 보기](zedt10_ekko.html)

---

### ZEDT10_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `NETPR` | CURR | 11 | Net price |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📋 [마크다운으로 보기](zedt10_ekpo.md) | 📄 [HTML로 보기](zedt10_ekpo.html)

---

### ZEDT10_LFM1

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt10_lfm1.md) | 📄 [HTML로 보기](zedt10_lfm1.html)

---

### ZEDT10_MWSKZ

**Key 필드:** `MANDT, MWSKZ, SPRAS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 40 | Text, 40 Characters Long |
| `KBETR` | CURR | 11 | Rate (condition amount or percentage) |
| `WAERS` | CUKY | 5 | Currency Key |

**데이터 타입:** CHAR(2), CLNT(1), LANG(1), CURR(1), CUKY(1)

📋 [마크다운으로 보기](zedt10_mwskz.md) | 📄 [HTML로 보기](zedt10_mwskz.html)

---

### ZEDT10_RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(4), CURR(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt10_rbkp.md) | 📄 [HTML로 보기](zedt10_rbkp.html)

---

### ZEDT10_RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), NUMC(3), CURR(3), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zedt10_rseg.md) | 📄 [HTML로 보기](zedt10_rseg.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
