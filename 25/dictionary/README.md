# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS025_002](zeds025_002.md) 📄 [HTML](zeds025_002.html) | - | 6 | - |
| [ZEDS25_001](zeds25_001.md) 📄 [HTML](zeds25_001.html) | - | 9 | - |
| [ZEDT25_001](zedt25_001.md) 📄 [HTML](zedt25_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT25_002](zedt25_002.md) 📄 [HTML](zedt25_002.html) | - | 22 | MANDT, ZCODE, ZPERNR |
| [ZEDT25_003](zedt25_003.md) 📄 [HTML](zedt25_003.html) | - | 3 | MANDT, ZMGUBUN |
| [ZEDT25_004](zedt25_004.md) 📄 [HTML](zedt25_004.html) | - | 32 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT25_100](zedt25_100.md) 📄 [HTML](zedt25_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT25_101](zedt25_101.md) 📄 [HTML](zedt25_101.html) | - | 39 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT25_102](zedt25_102.md) 📄 [HTML](zedt25_102.html) | - | 31 | MANDT, ZPERNR, ZDEPCODE ... (+2) |
| [ZEDT25_103](zedt25_103.md) 📄 [HTML](zedt25_103.html) | - | 14 | MANDT, ZPERNR |
| [ZEDT25_104](zedt25_104.md) 📄 [HTML](zedt25_104.html) | - | 20 | MANDT, ZPERNR, ZDEPCODE ... (+3) |
| [ZEDT25_105](zedt25_105.md) 📄 [HTML](zedt25_105.html) | - | 22 | MANDT, ZPERNR, ZYEAR |
| [ZEDT25_106](zedt25_106.md) 📄 [HTML](zedt25_106.html) | - | 20 | MANDT, ZPERNR, ZYEAR ... (+2) |
| [ZEDT25_200](zedt25_200.md) 📄 [HTML](zedt25_200.html) | - | 17 | MANDT, WERKS, LGORT ... (+1) |
| [ZEDT25_LFA1](zedt25_lfa1.md) 📄 [HTML](zedt25_lfa1.html) | - | 14 | MANDT, LIFNR |
| [ZEDT25_LFB1](zedt25_lfb1.md) 📄 [HTML](zedt25_lfb1.html) | - | 33 | MANDT, LIFNR, BUKRS |
| [ZEDT25_LFM1](zedt25_lfm1.md) 📄 [HTML](zedt25_lfm1.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZEDT25_ZEKKO](zedt25_zekko.md) 📄 [HTML](zedt25_zekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT25_ZEKPO](zedt25_zekpo.md) 📄 [HTML](zedt25_zekpo.html) | - | 16 | MANDT, EBELN, EBELP |
| [ZEDT25_ZMKPF](zedt25_zmkpf.md) 📄 [HTML](zedt25_zmkpf.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZEDT25_ZMSEG](zedt25_zmseg.md) 📄 [HTML](zedt25_zmseg.html) | - | 24 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT25_ZRBKP](zedt25_zrbkp.md) 📄 [HTML](zedt25_zrbkp.html) | - | 48 | MANDT, BELNR, GJAHR |
| [ZEDT25_ZRSEG](zedt25_zrseg.md) 📄 [HTML](zedt25_zrseg.html) | - | 34 | MANDT, BELNR, GJAHR ... (+1) |
| [ZEDT25_ZTERM](zedt25_zterm.md) 📄 [HTML](zedt25_zterm.html) | - | 14 | MANDT, ZTERM |
| [ZMARA25](zmara25.md) 📄 [HTML](zmara25.html) | - | 26 | MANDT, WERKS, LGORT ... (+1) |
| [ZTCURR25](ztcurr25.md) 📄 [HTML](ztcurr25.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `CNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |
| `AEDATE` | DATS | 8 | Date of Last Change |

*... 외 1개 필드*

**데이터 타입:** CHAR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds025_002.md) | 📄 [HTML로 보기](zeds025_002.html)

---

### ZEDS25_001

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

📋 [마크다운으로 보기](zeds25_001.md) | 📄 [HTML로 보기](zeds25_001.html)

---

### ZEDT25_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |
| `CNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_001.md) | 📄 [HTML로 보기](zedt25_001.html)

---

### ZEDT25_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt25_002.md) | 📄 [HTML로 보기](zedt25_002.html)

---

### ZEDT25_003

**Key 필드:** `MANDT, ZMGUBUN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMNAME` | CHAR | 20 | ##### |

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_003.md) | 📄 [HTML로 보기](zedt25_003.html)

---

### ZEDT25_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | Currency Key |
| `ZGRADE` | CHAR | 1 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(9), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt25_004.md) | 📄 [HTML로 보기](zedt25_004.html)

---

### ZEDT25_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS025_002

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

📋 [마크다운으로 보기](zedt25_100.md) | 📄 [HTML로 보기](zedt25_100.html)

---

### ZEDT25_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS025_002

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

📋 [마크다운으로 보기](zedt25_101.md) | 📄 [HTML로 보기](zedt25_101.html)

---

### ZEDT25_102

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, DATBI, DATAB`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZDEPRANK` | CHAR | 1 | - |
| `ZEDATE` | DATS | 8 | - |
| `ZQDATE` | DATS | 8 | - |
| `ZQFLAG` | CHAR | 1 | - |
| `CNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(6), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_102.md) | 📄 [HTML로 보기](zedt25_102.html)

---

### ZEDT25_103

**Key 필드:** `MANDT, ZPERNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZADDRESS` | CHAR | 20 | - |
| `CNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_103.md) | 📄 [HTML로 보기](zedt25_103.html)

---

### ZEDT25_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK` | CHAR | 1 | - |
| `CNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt25_104.md) | 📄 [HTML로 보기](zedt25_104.html)

---

### ZEDT25_105

**Key 필드:** `MANDT, ZPERNR, ZYEAR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMON01` | CURR | 13 | 1### |
| `ZMON02` | CURR | 13 | 2### |
| `ZMON03` | CURR | 13 | 3### |
| `ZMON04` | CURR | 13 | 4### |
| `ZMON05` | CURR | 13 | 5### |

*... 외 5개 필드*

**데이터 타입:** CURR(12), CHAR(3), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_105.md) | 📄 [HTML로 보기](zedt25_105.html)

---

### ZEDT25_106

**Key 필드:** `MANDT, ZPERNR, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY` | CURR | 13 | - |
| `ZBANKCODE` | CHAR | 3 | - |
| `ZACCOUNT` | CHAR | 20 | - |
| `CNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt25_106.md) | 📄 [HTML로 보기](zedt25_106.html)

---

### ZEDT25_200

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `MTART` | CHAR | 4 | Material Type |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt25_200.md) | 📄 [HTML로 보기](zedt25_200.html)

---

### ZEDT25_LFA1

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zedt25_lfa1.md) | 📄 [HTML로 보기](zedt25_lfa1.html)

---

### ZEDT25_LFB1

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zedt25_lfb1.md) | 📄 [HTML로 보기](zedt25_lfb1.html)

---

### ZEDT25_LFM1

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt25_lfm1.md) | 📄 [HTML로 보기](zedt25_lfm1.html)

---

### ZEDT25_ZEKKO

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

📋 [마크다운으로 보기](zedt25_zekko.md) | 📄 [HTML로 보기](zedt25_zekko.html)

---

### ZEDT25_ZEKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `PRDAT` | DATS | 8 | Date of last forecast |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📋 [마크다운으로 보기](zedt25_zekpo.md) | 📄 [HTML로 보기](zedt25_zekpo.html)

---

### ZEDT25_ZMKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt25_zmkpf.md) | 📄 [HTML로 보기](zedt25_zmkpf.html)

---

### ZEDT25_ZMSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `ZWERKS` | CHAR | 4 | Plant |
| `ZLGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Vendor's account number |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zedt25_zmseg.md) | 📄 [HTML로 보기](zedt25_zmseg.html)

---

### ZEDT25_ZRBKP

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

**데이터 타입:** CHAR(12), NUMC(2), DATS(2), CURR(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_zrbkp.md) | 📄 [HTML로 보기](zedt25_zrbkp.html)

---

### ZEDT25_ZRSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 10 | - |
| `BUKRS` | CHAR | 4 | Company Code |
| `TXZ01` | CHAR | 20 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), NUMC(5), CURR(2), QUAN(2), UNIT(2)

📋 [마크다운으로 보기](zedt25_zrseg.md) | 📄 [HTML로 보기](zedt25_zrseg.html)

---

### ZEDT25_ZTERM

**Key 필드:** `MANDT, ZTERM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `TEXT` | CHAR | 40 | Character field of length 40 |

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_zterm.md) | 📄 [HTML로 보기](zedt25_zterm.html)

---

### ZMARA25

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMTART` | CHAR | 4 | - |
| `ZMODEL` | CHAR | 10 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmara25.md) | 📄 [HTML로 보기](zmara25.html)

---

### ZTCURR25

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `ERNAM` | CHAR | 12 | Name of Person Who Created the Object |
| `ERDAT` | DATS | 8 | Date on Which Record Was Created |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📋 [마크다운으로 보기](ztcurr25.md) | 📄 [HTML로 보기](ztcurr25.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
