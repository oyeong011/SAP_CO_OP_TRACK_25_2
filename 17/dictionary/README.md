# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS17_001](zeds17_001.md) 📄 [HTML](zeds17_001.html) | - | 15 | - |
| [ZEDS17_002](zeds17_002.md) 📄 [HTML](zeds17_002.html) | - | 6 | - |
| [ZEDT17_001](zedt17_001.md) 📄 [HTML](zedt17_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT17_002](zedt17_002.md) 📄 [HTML](zedt17_002.html) | - | 22 | MANDT, ZCODE, ZPERNR |
| [ZEDT17_003](zedt17_003.md) 📄 [HTML](zedt17_003.html) | - | 3 | MANDT, ZMGUBUN |
| [ZEDT17_004](zedt17_004.md) 📄 [HTML](zedt17_004.html) | - | 32 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT17_100](zedt17_100.md) 📄 [HTML](zedt17_100.html) | - | 51 | MANDT, ZORDNO, ZIDCODE |
| [ZEDT17_101](zedt17_101.md) 📄 [HTML](zedt17_101.html) | - | 48 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT17_102](zedt17_102.md) 📄 [HTML](zedt17_102.html) | - | 31 | MANDT, ZPERNR, ZDEPCODE ... (+2) |
| [ZEDT17_103](zedt17_103.md) 📄 [HTML](zedt17_103.html) | - | 14 | MANDT, ZPERNR |
| [ZEDT17_104](zedt17_104.md) 📄 [HTML](zedt17_104.html) | - | 25 | MANDT, ZPERNR, ZDEPCODE ... (+3) |
| [ZEDT17_105](zedt17_105.md) 📄 [HTML](zedt17_105.html) | - | 22 | MANDT, ZPERNR, ZYEAR |
| [ZEDT17_106](zedt17_106.md) 📄 [HTML](zedt17_106.html) | - | 20 | MANDT, ZPERNR, ZYEAR ... (+2) |
| [ZEDT17_200](zedt17_200.md) 📄 [HTML](zedt17_200.html) | - | 36 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZEDT17_BKPF](zedt17_bkpf.md) 📄 [HTML](zedt17_bkpf.html) | - | 21 | MANDT, BUKRS, GJAHR ... (+1) |
| [ZEDT17_BSEG](zedt17_bseg.md) 📄 [HTML](zedt17_bseg.html) | - | 23 | MANDT, BUKRS, GJAHR ... (+2) |
| [ZEDT17_EKKO](zedt17_ekko.md) 📄 [HTML](zedt17_ekko.html) | - | 15 | MANDT, EBELN |
| [ZEDT17_EKPO](zedt17_ekpo.md) 📄 [HTML](zedt17_ekpo.html) | - | 33 | MANDT, EBELN, EBELP |
| [ZEDT17_LFA1](zedt17_lfa1.md) 📄 [HTML](zedt17_lfa1.html) | - | 21 | MANDT, LIFNR |
| [ZEDT17_LFB1](zedt17_lfb1.md) 📄 [HTML](zedt17_lfb1.html) | - | 41 | MANDT, LIFNR, BUKRS |
| [ZEDT17_LFM1](zedt17_lfm1.md) 📄 [HTML](zedt17_lfm1.html) | - | 21 | MANDT, LIFNR, EKORG |
| [ZEDT17_MKPF](zedt17_mkpf.md) 📄 [HTML](zedt17_mkpf.html) | - | 13 | MANDT, MBLNR, MJAHR |
| [ZEDT17_MSEG](zedt17_mseg.md) 📄 [HTML](zedt17_mseg.html) | - | 40 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT17_RBKP](zedt17_rbkp.md) 📄 [HTML](zedt17_rbkp.html) | - | 32 | MANDT, BELNR, GJAHR |
| [ZEDT17_RSEG](zedt17_rseg.md) 📄 [HTML](zedt17_rseg.html) | - | 40 | MANDT, BELNR, GJAHR ... (+1) |
| [ZMARA17](zmara17.md) 📄 [HTML](zmara17.html) | - | 37 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZTCURR17](ztcurr17.md) 📄 [HTML](ztcurr17.html) | - | 15 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS17_001

**INCLUDE 구조:** ZEDS17_002

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

📋 [마크다운으로 보기](zeds17_001.md) | 📄 [HTML로 보기](zeds17_001.html)

---

### ZEDS17_002

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

📋 [마크다운으로 보기](zeds17_002.md) | 📄 [HTML로 보기](zeds17_002.html)

---

### ZEDT17_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS17_002

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

📋 [마크다운으로 보기](zedt17_001.md) | 📄 [HTML로 보기](zedt17_001.html)

---

### ZEDT17_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt17_002.md) | 📄 [HTML로 보기](zedt17_002.html)

---

### ZEDT17_003

**Key 필드:** `MANDT, ZMGUBUN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMGNAME` | CHAR | 20 | ##### |

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_003.md) | 📄 [HTML로 보기](zedt17_003.html)

---

### ZEDT17_004

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

📋 [마크다운으로 보기](zedt17_004.md) | 📄 [HTML로 보기](zedt17_004.html)

---

### ZEDT17_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `ZMTART` | CHAR | 4 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `ZVOLUM` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), CURR(3), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_100.md) | 📄 [HTML로 보기](zedt17_100.html)

---

### ZEDT17_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMTART` | CHAR | 4 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `ZVOLUM` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |
| `VRKME` | UNIT | 3 | Sales Unit |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), TIMS(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zedt17_101.md) | 📄 [HTML로 보기](zedt17_101.html)

---

### ZEDT17_102

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, DATBI, DATAB`

**INCLUDE 구조:** ZEDS17_002

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

📋 [마크다운으로 보기](zedt17_102.md) | 📄 [HTML로 보기](zedt17_102.html)

---

### ZEDT17_103

**Key 필드:** `MANDT, ZPERNR`

**INCLUDE 구조:** ZEDS17_002

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

📋 [마크다운으로 보기](zedt17_103.md) | 📄 [HTML로 보기](zedt17_103.html)

---

### ZEDT17_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS17_002

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

📋 [마크다운으로 보기](zedt17_104.md) | 📄 [HTML로 보기](zedt17_104.html)

---

### ZEDT17_105

**Key 필드:** `MANDT, ZPERNR, ZYEAR`

**INCLUDE 구조:** ZEDS17_002

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

📋 [마크다운으로 보기](zedt17_105.md) | 📄 [HTML로 보기](zedt17_105.html)

---

### ZEDT17_106

**Key 필드:** `MANDT, ZPERNR, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY` | CURR | 13 | - |
| `ZBANKCODE` | CHAR | 3 | - |
| `ZACCOUNT` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt17_106.md) | 📄 [HTML로 보기](zedt17_106.html)

---

### ZEDT17_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMTART` | CHAR | 4 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt17_200.md) | 📄 [HTML로 보기](zedt17_200.html)

---

### ZEDT17_BKPF

**Key 필드:** `MANDT, BUKRS, GJAHR, BELNR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BKTXT` | CHAR | 25 | Document Header Text |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(4), NUMC(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_bkpf.md) | 📄 [HTML로 보기](zedt17_bkpf.html)

---

### ZEDT17_BSEG

**Key 필드:** `MANDT, BUKRS, GJAHR, BELNR, BUZEI`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |
| `HKONT` | CHAR | 10 | General Ledger Account |
| `DMBTR` | CURR | 13 | Amount in local currency |
| `MWSTS` | CURR | 13 | Tax Amount in Local Currency |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(2), CURR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zedt17_bseg.md) | 📄 [HTML로 보기](zedt17_bseg.html)

---

### ZEDT17_EKKO

**Key 필드:** `MANDT, EBELN`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BEDAT` | DATS | 8 | Purchase Order Date |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt17_ekko.md) | 📄 [HTML로 보기](zedt17_ekko.html)

---

### ZEDT17_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | UNIT | 3 | Order Price Unit (Purchasing) |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), UNIT(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_ekpo.md) | 📄 [HTML로 보기](zedt17_ekpo.html)

---

### ZEDT17_LFA1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_lfa1.md) | 📄 [HTML로 보기](zedt17_lfa1.html)

---

### ZEDT17_LFB1

**Key 필드:** `MANDT, LIFNR, BUKRS`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_lfb1.md) | 📄 [HTML로 보기](zedt17_lfb1.html)

---

### ZEDT17_LFM1

**Key 필드:** `MANDT, LIFNR, EKORG`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt17_lfm1.md) | 📄 [HTML로 보기](zedt17_lfm1.html)

---

### ZEDT17_MKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**INCLUDE 구조:** ZEDS17_002

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

📋 [마크다운으로 보기](zedt17_mkpf.md) | 📄 [HTML로 보기](zedt17_mkpf.html)

---

### ZEDT17_MSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 4 | ### |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), NUMC(3), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt17_mseg.md) | 📄 [HTML로 보기](zedt17_mseg.html)

---

### ZEDT17_RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(5), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt17_rbkp.md) | 📄 [HTML로 보기](zedt17_rbkp.html)

---

### ZEDT17_RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `ZMATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `ZWERKS` | CHAR | 4 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CURR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zedt17_rseg.md) | 📄 [HTML로 보기](zedt17_rseg.html)

---

### ZMARA17

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS17_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMTART` | CHAR | 4 | - |
| `ZMODEL` | CHAR | 6 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmara17.md) | 📄 [HTML로 보기](zmara17.html)

---

### ZTCURR17

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**INCLUDE 구조:** ZEDS17_002

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

📋 [마크다운으로 보기](ztcurr17.md) | 📄 [HTML로 보기](ztcurr17.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
