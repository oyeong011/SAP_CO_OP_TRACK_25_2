# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS08_001](zeds08_001.md) 📄 [HTML](zeds08_001.html) | - | 9 | - |
| [ZEDS08_002](zeds08_002.md) 📄 [HTML](zeds08_002.html) | - | 6 | - |
| [ZEDT08_000](zedt08_000.md) 📄 [HTML](zedt08_000.html) | - | 9 | MANDT, ZCODE |
| [ZEDT08_001](zedt08_001.md) 📄 [HTML](zedt08_001.html) | - | 18 | MANDT, ZCODE, ZPERNR |
| [ZEDT08_002](zedt08_002.md) 📄 [HTML](zedt08_002.html) | - | 24 | MANDT, ZCODE, ZPERNR |
| [ZEDT08_003](zedt08_003.md) 📄 [HTML](zedt08_003.html) | - | 5 | MANDT, ZMGUBUN |
| [ZEDT08_004](zedt08_004.md) 📄 [HTML](zedt08_004.html) | - | 26 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT08_100](zedt08_100.md) 📄 [HTML](zedt08_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT08_101](zedt08_101.md) 📄 [HTML](zedt08_101.html) | - | 39 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT08_102](zedt08_102.md) 📄 [HTML](zedt08_102.html) | - | 31 | MANDT, ZPERNR, ZDEPCODE ... (+2) |
| [ZEDT08_103](zedt08_103.md) 📄 [HTML](zedt08_103.html) | - | 14 | MANDT, ZPERNR |
| [ZEDT08_104](zedt08_104.md) 📄 [HTML](zedt08_104.html) | - | 25 | MANDT, ZPERNR, ZDEPCODE ... (+3) |
| [ZEDT08_EKKO](zedt08_ekko.md) 📄 [HTML](zedt08_ekko.html) | - | 15 | MANDT, EBELN, BUKRS ... (+1) |
| [ZEDT08_EKPO](zedt08_ekpo.md) 📄 [HTML](zedt08_ekpo.html) | - | 18 | MANDT, EBELN, EBELP |
| [ZEDT08_LFA1](zedt08_lfa1.md) 📄 [HTML](zedt08_lfa1.html) | - | 22 | MANDT, LIFNR |
| [ZEDT08_LFB1](zedt08_lfb1.md) 📄 [HTML](zedt08_lfb1.html) | - | 41 | MANDT, LIFNR |
| [ZEDT08_LFM1](zedt08_lfm1.md) 📄 [HTML](zedt08_lfm1.html) | - | 21 | MANDT, LIFNR |
| [ZEDT08_MAT](zedt08_mat.md) 📄 [HTML](zedt08_mat.html) | - | 27 | MANDT, WERKS, LGORT ... (+1) |
| [ZEDT08_MKRF](zedt08_mkrf.md) 📄 [HTML](zedt08_mkrf.html) | - | 13 | MANDT, MBLNR, MJAHR |
| [ZEDT08_MSEG](zedt08_mseg.md) 📄 [HTML](zedt08_mseg.html) | - | 19 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT08_RBKP](zedt08_rbkp.md) 📄 [HTML](zedt08_rbkp.html) | - | 9 | MANDT, BELNR, GJAHR |
| [ZTCURR08](ztcurr08.md) 📄 [HTML](ztcurr08.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS08_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MANDT` | CLNT | 3 | Client |
| `ZCODE` | CHAR | 10 | - |
| `ZPERNR` | CHAR | 10 | - |
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(6), CLNT(1)

📋 [마크다운으로 보기](zeds08_001.md) | 📄 [HTML로 보기](zeds08_001.html)

---

### ZEDS08_002

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

📋 [마크다운으로 보기](zeds08_002.md) | 📄 [HTML로 보기](zeds08_002.html)

---

### ZEDT08_000

**Key 필드:** `MANDT, ZCODE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPERNR` | CHAR | 10 | - |
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |

**데이터 타입:** CHAR(6), CLNT(1)

📋 [마크다운으로 보기](zedt08_000.md) | 📄 [HTML로 보기](zedt08_000.html)

---

### ZEDT08_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |
| `ZAENAME` | CHAR | 12 | Name of person who changed object |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(3), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_001.md) | 📄 [HTML로 보기](zedt08_001.html)

---

### ZEDT08_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUMM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt08_002.md) | 📄 [HTML로 보기](zedt08_002.html)

---

### ZEDT08_003

**Key 필드:** `MANDT, ZMGUBUN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMGNAME` | CHAR | 20 | ###### |

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_003.md) | 📄 [HTML로 보기](zedt08_003.html)

---

### ZEDT08_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | - |
| `ZGRADE` | CHAR | 1 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), CURR(2), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_004.md) | 📄 [HTML로 보기](zedt08_004.html)

---

### ZEDT08_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMTART` | CHAR | 3 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `ZVOLUM` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |
| `VRKME` | UNIT | 3 | Sales Unit |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), CURR(3), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_100.md) | 📄 [HTML로 보기](zedt08_100.html)

---

### ZEDT08_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMTART` | CHAR | 3 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `ZVOLUM` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |
| `VRKME` | UNIT | 3 | Sales Unit |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), TIMS(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zedt08_101.md) | 📄 [HTML로 보기](zedt08_101.html)

---

### ZEDT08_102

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, DATBI, DATAB`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZDEPRANK` | CHAR | 1 | - |
| `ZEDATE` | DATS | 8 | - |
| `ZQDATE` | DATS | 8 | - |
| `ZQFLAG` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(6), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_102.md) | 📄 [HTML로 보기](zedt08_102.html)

---

### ZEDT08_103

**Key 필드:** `MANDT, ZPERNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZADDRESS` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_103.md) | 📄 [HTML로 보기](zedt08_103.html)

---

### ZEDT08_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt08_104.md) | 📄 [HTML로 보기](zedt08_104.html)

---

### ZEDT08_EKKO

**Key 필드:** `MANDT, EBELN, BUKRS, EKGRP`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BEDAT` | DATS | 8 | Purchase Order Date |
| `WAERS` | CUKY | 5 | Currency Key |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt08_ekko.md) | 📄 [HTML로 보기](zedt08_ekko.html)

---

### ZEDT08_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | CURR | 11 | Net price |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt08_ekpo.md) | 📄 [HTML로 보기](zedt08_ekpo.html)

---

### ZEDT08_LFA1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 5 | ### ## |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_lfa1.md) | 📄 [HTML로 보기](zedt08_lfa1.html)

---

### ZEDT08_LFB1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 5 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt08_lfb1.md) | 📄 [HTML로 보기](zedt08_lfb1.html)

---

### ZEDT08_LFM1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt08_lfm1.md) | 📄 [HTML로 보기](zedt08_lfm1.html)

---

### ZEDT08_MAT

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMATDES` | CHAR | 250 | ## ## |
| `ZMTART` | CHAR | 3 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(3), QUAN(2), UNIT(2), TIMS(2)

📋 [마크다운으로 보기](zedt08_mat.md) | 📄 [HTML로 보기](zedt08_mat.html)

---

### ZEDT08_MKRF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**INCLUDE 구조:** ZEDS08_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(4), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt08_mkrf.md) | 📄 [HTML로 보기](zedt08_mkrf.html)

---

### ZEDT08_MSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 5 | ### |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zedt08_mseg.md) | 📄 [HTML로 보기](zedt08_mseg.html)

---

### ZEDT08_RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |

*... 외 1개 필드*

**데이터 타입:** CHAR(4), DATS(2), CLNT(1), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zedt08_rbkp.md) | 📄 [HTML로 보기](zedt08_rbkp.html)

---

### ZTCURR08

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `AENAM` | CHAR | 12 | Name of person who changed object |
| `AEDAT` | DATS | 8 | Date of Last Change |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📋 [마크다운으로 보기](ztcurr08.md) | 📄 [HTML로 보기](ztcurr08.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
