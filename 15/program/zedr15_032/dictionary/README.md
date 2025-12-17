# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS15_001](zeds15_001.md) 📄 [HTML](zeds15_001.html) | - | 8 | - |
| [ZEDS15_002](zeds15_002.md) 📄 [HTML](zeds15_002.html) | - | 6 | - |
| [ZEDT15_001](zedt15_001.md) 📄 [HTML](zedt15_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEKKO_15](zekko_15.md) 📄 [HTML](zekko_15.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_15](zekpo_15.md) 📄 [HTML](zekpo_15.html) | - | 24 | MANDT, EBELN, EBELP |
| [ZLFA1_15](zlfa1_15.md) 📄 [HTML](zlfa1_15.html) | - | 15 | MANDT, LIFNR |
| [ZLFB1_15](zlfb1_15.md) 📄 [HTML](zlfb1_15.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZLFM1_15](zlfm1_15.md) 📄 [HTML](zlfm1_15.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZMAT_15](zmat_15.md) 📄 [HTML](zmat_15.html) | - | 31 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZMKPF_15](zmkpf_15.md) 📄 [HTML](zmkpf_15.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG_15](zmseg_15.md) 📄 [HTML](zmseg_15.html) | - | 29 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP_15](zrbkp_15.md) 📄 [HTML](zrbkp_15.html) | - | 45 | MANDT, BELNR, GJAHR |
| [ZRSEG_15](zrseg_15.md) 📄 [HTML](zrseg_15.html) | - | 24 | MANDT, BELNR, GJAHR ... (+1) |
| [ZTCURR015](ztcurr015.md) 📄 [HTML](ztcurr015.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS15_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZCODE` | CHAR | 10 | - |
| `ZPERNR` | CHAR | 10 | - |
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |

*... 외 1개 필드*

**데이터 타입:** CHAR(6)

📋 [마크다운으로 보기](zeds15_001.md) | 📄 [HTML로 보기](zeds15_001.html)

---

### ZEDS15_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |
| `AEDATE` | DATS | 8 | Date of Last Change |

*... 외 1개 필드*

**데이터 타입:** CHAR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds15_002.md) | 📄 [HTML로 보기](zeds15_002.html)

---

### ZEDT15_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS15_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt15_001.md) | 📄 [HTML로 보기](zedt15_001.html)

---

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

### ZLFA1_15

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | Name 1 |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zlfa1_15.md) | 📄 [HTML로 보기](zlfa1_15.html)

---

### ZLFB1_15

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Flag for Master Record (Company Code Level) |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_15.md) | 📄 [HTML로 보기](zlfb1_15.html)

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

### ZMKPF_15

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf_15.md) | 📄 [HTML로 보기](zmkpf_15.html)

---

### ZMSEG_15

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | ### |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zmseg_15.md) | 📄 [HTML로 보기](zmseg_15.html)

---

### ZRBKP_15

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

**데이터 타입:** CHAR(9), DATS(3), NUMC(2), CURR(2), CLNT(1)

📋 [마크다운으로 보기](zrbkp_15.md) | 📄 [HTML로 보기](zrbkp_15.html)

---

### ZRSEG_15

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | ### |
| `WRBTR` | CURR | 13 | Amount in document currency |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), NUMC(3), CURR(3), UNIT(2), CLNT(1)

📋 [마크다운으로 보기](zrseg_15.md) | 📄 [HTML로 보기](zrseg_15.html)

---

### ZTCURR015

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📋 [마크다운으로 보기](ztcurr015.md) | 📄 [HTML로 보기](ztcurr015.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
