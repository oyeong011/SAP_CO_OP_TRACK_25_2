# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_02](zekko_02.md) 📄 [HTML](zekko_02.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_02](zekpo_02.md) 📄 [HTML](zekpo_02.html) | - | 21 | MANDT, EBELN, EBELP |
| [ZLFB1_02](zlfb1_02.md) 📄 [HTML](zlfb1_02.html) | - | 30 | MANDT, LIFNR, BUKRS |
| [ZLFM1_02](zlfm1_02.md) 📄 [HTML](zlfm1_02.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZRBKP_02](zrbkp_02.md) 📄 [HTML](zrbkp_02.html) | - | 21 | MANDT, BELNR, GJAHR |
| [ZRSEG_02](zrseg_02.md) 📄 [HTML](zrseg_02.html) | - | 23 | MANDT, BELNR, GJAHR ... (+1) |

---

## 테이블 상세 정보

### ZEKKO_02

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

📋 [마크다운으로 보기](zekko_02.md) | 📄 [HTML로 보기](zekko_02.html)

---

### ZEKPO_02

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | UNIT | 3 | Order Price Unit (Purchasing) |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📋 [마크다운으로 보기](zekpo_02.md) | 📄 [HTML로 보기](zekpo_02.html)

---

### ZLFB1_02

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Flag for Master Record (Company Code Level) |
| `AKONT` | CHAR | 10 | Reconciliation Account in General Ledger |
| `ZTERM` | CHAR | 4 | Terms of Payment Key |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_02.md) | 📄 [HTML로 보기](zlfb1_02.html)

---

### ZLFM1_02

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Delete flag for vendor at purchasing level |
| `WAERS` | CUKY | 5 | Purchase order currency |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_02.md) | 📄 [HTML로 보기](zlfm1_02.html)

---

### ZRBKP_02

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |
| `RMWWR` | CURR | 13 | Gross invoice amount in document currency |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(2), DATS(2), CURR(2), CLNT(1)

📋 [마크다운으로 보기](zrbkp_02.md) | 📄 [HTML로 보기](zrbkp_02.html)

---

### ZRSEG_02

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `WRBTR` | CURR | 13 | Amount in document currency |
| `WMWST` | CURR | 13 | Tax Amount in Document Currency |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CURR(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zrseg_02.md) | 📄 [HTML로 보기](zrseg_02.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
