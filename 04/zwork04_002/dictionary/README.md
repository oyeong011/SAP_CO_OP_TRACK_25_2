# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT04_000](zedt04_000.md) 📄 [HTML](zedt04_000.html) | - | 9 | MANDT, ZCODE, ZPERNR |
| [ZEKKO04](zekko04.md) 📄 [HTML](zekko04.html) | - | 8 | MANDT, EBELN |
| [ZEKPO04](zekpo04.md) 📄 [HTML](zekpo04.html) | - | 25 | MANDT, EBELN, EBELP |
| [ZLFA1_04](zlfa1_04.md) 📄 [HTML](zlfa1_04.html) | - | 14 | MANDT, LIFNR |
| [ZLFB1_04](zlfb1_04.md) 📄 [HTML](zlfb1_04.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZLFM1_04](zlfm1_04.md) 📄 [HTML](zlfm1_04.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZMKPF04](zmkpf04.md) 📄 [HTML](zmkpf04.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG04](zmseg04.md) 📄 [HTML](zmseg04.html) | - | 27 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZPDT19_004](zpdt19_004.md) 📄 [HTML](zpdt19_004.html) | - | 8 | MANDT, EBELN |
| [ZPRO07_004](zpro07_004.md) 📄 [HTML](zpro07_004.html) | - | 8 | MANDT, EBELN |
| [ZPRO11_004](zpro11_004.md) 📄 [HTML](zpro11_004.html) | - | 8 | MANDT, EBELN |
| [ZRBKP04](zrbkp04.md) 📄 [HTML](zrbkp04.html) | - | 8 | MANDT, BELNR, GJAHR |
| [ZRSEG04](zrseg04.md) 📄 [HTML](zrseg04.html) | - | 22 | MANDT, BELNR, GJAHR ... (+1) |
| [ZTCURR04](ztcurr04.md) 📄 [HTML](ztcurr04.html) | - | 15 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDT04_000

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |

**데이터 타입:** CHAR(6), CLNT(1)

📋 [마크다운으로 보기](zedt04_000.md) | 📄 [HTML로 보기](zedt04_000.html)

---

### ZEKKO04

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

📋 [마크다운으로 보기](zekko04.md) | 📄 [HTML로 보기](zekko04.html)

---

### ZEKPO04

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `STPRS` | CURR | 11 | Standard price |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zekpo04.md) | 📄 [HTML로 보기](zekpo04.html)

---

### ZLFA1_04

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | Name 1 |
| `LAND1` | CHAR | 3 | Country Key |
| `ZKTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zlfa1_04.md) | 📄 [HTML로 보기](zlfa1_04.html)

---

### ZLFB1_04

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Flag for Master Record (Company Code Level) |
| `ZAKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_04.md) | 📄 [HTML로 보기](zlfb1_04.html)

---

### ZLFM1_04

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Delete flag for vendor at purchasing level |
| `WAERS` | CUKY | 5 | Currency Key |
| `ZMWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_04.md) | 📄 [HTML로 보기](zlfm1_04.html)

---

### ZMKPF04

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf04.md) | 📄 [HTML로 보기](zmkpf04.html)

---

### ZMSEG04

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `ZWERKS` | CHAR | 4 | ### |
| `ZLGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zmseg04.md) | 📄 [HTML로 보기](zmseg04.html)

---

### ZPDT19_004

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

📋 [마크다운으로 보기](zpdt19_004.md) | 📄 [HTML로 보기](zpdt19_004.html)

---

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

### ZPRO11_004

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

📋 [마크다운으로 보기](zpro11_004.md) | 📄 [HTML로 보기](zpro11_004.html)

---

### ZRBKP04

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(3), DATS(2), CLNT(1), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zrbkp04.md) | 📄 [HTML로 보기](zrbkp04.html)

---

### ZRSEG04

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `ZWERKS` | CHAR | 4 | ### |
| `ZMATNR` | CHAR | 10 | - |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |

*... 외 5개 필드*

**데이터 타입:** CHAR(5), CURR(4), NUMC(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zrseg04.md) | 📄 [HTML로 보기](zrseg04.html)

---

### ZTCURR04

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**INCLUDE 구조:** ZEDS04_002

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

📋 [마크다운으로 보기](ztcurr04.md) | 📄 [HTML로 보기](ztcurr04.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
