# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS12_001](zeds12_001.md) 📄 [HTML](zeds12_001.html) | - | 14 | - |
| [ZEDS12_002](zeds12_002.md) 📄 [HTML](zeds12_002.html) | - | 6 | - |
| [ZEDT12_001](zedt12_001.md) 📄 [HTML](zedt12_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEKKO_12](zekko_12.md) 📄 [HTML](zekko_12.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_12](zekpo_12.md) 📄 [HTML](zekpo_12.html) | - | 17 | MANDT, EBELN, EBELP ... (+1) |
| [ZLFA1_12](zlfa1_12.md) 📄 [HTML](zlfa1_12.html) | - | 15 | MANDT, LIFNR |
| [ZLFB1_12](zlfb1_12.md) 📄 [HTML](zlfb1_12.html) | - | 34 | MANDT, LIFNR |
| [ZLFM1_12](zlfm1_12.md) 📄 [HTML](zlfm1_12.html) | - | 14 | MANDT, LIFNR |
| [ZMARA_12](zmara_12.md) 📄 [HTML](zmara_12.html) | - | 30 | MANDT, WERKS, LGORT ... (+1) |
| [ZMKPF_12](zmkpf_12.md) 📄 [HTML](zmkpf_12.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG_12](zmseg_12.md) 📄 [HTML](zmseg_12.html) | - | 30 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP_12](zrbkp_12.md) 📄 [HTML](zrbkp_12.html) | - | 9 | MANDT, BELNR, GJAHR |
| [ZRSEG_12](zrseg_12.md) 📄 [HTML](zrseg_12.html) | - | 23 | MANDT, BELNR, GJAHR ... (+1) |
| [ZTCURR12](ztcurr12.md) 📄 [HTML](ztcurr12.html) | - | 15 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS12_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPERNR` | CHAR | 10 | - |
| `ZCODE` | CHAR | 10 | - |
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds12_001.md) | 📄 [HTML로 보기](zeds12_001.html)

---

### ZEDS12_002

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

📋 [마크다운으로 보기](zeds12_002.md) | 📄 [HTML로 보기](zeds12_002.html)

---

### ZEDT12_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS12_002

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

📋 [마크다운으로 보기](zedt12_001.md) | 📄 [HTML로 보기](zedt12_001.html)

---

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

### ZLFA1_12

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | - |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zlfa1_12.md) | 📄 [HTML로 보기](zlfa1_12.html)

---

### ZLFB1_12

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | ####(Reconciliation Account) |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_12.md) | 📄 [HTML로 보기](zlfb1_12.html)

---

### ZLFM1_12

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_12.md) | 📄 [HTML로 보기](zlfm1_12.html)

---

### ZMARA_12

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**INCLUDE 구조:** ZEDS12_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNAME` | CHAR | 20 | ### |
| `MTART` | CHAR | 4 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmara_12.md) | 📄 [HTML로 보기](zmara_12.html)

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

### ZRBKP_12

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

*... 외 1개 필드*

**데이터 타입:** CHAR(4), DATS(2), CLNT(1), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zrbkp_12.md) | 📄 [HTML로 보기](zrbkp_12.html)

---

### ZRSEG_12

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `WERKS` | CHAR | 4 | ### |
| `MATNR` | CHAR | 10 | - |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |

*... 외 5개 필드*

**데이터 타입:** CHAR(5), CURR(4), NUMC(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zrseg_12.md) | 📄 [HTML로 보기](zrseg_12.html)

---

### ZTCURR12

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**INCLUDE 구조:** ZEDS12_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(4), DEC(3), CUKY(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](ztcurr12.md) | 📄 [HTML로 보기](ztcurr12.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
