# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS14_001](zeds14_001.md) 📄 [HTML](zeds14_001.html) | - | 14 | - |
| [ZEDS14_002](zeds14_002.md) 📄 [HTML](zeds14_002.html) | - | 6 | - |
| [ZEDT14_001](zedt14_001.md) 📄 [HTML](zedt14_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT14_002](zedt14_002.md) 📄 [HTML](zedt14_002.html) | - | 22 | MANDT, ZPERNR, ZCODE |
| [ZEDT14_003](zedt14_003.md) 📄 [HTML](zedt14_003.html) | - | 3 | MANDT, ZMGUBUN |
| [ZEDT14_004](zedt14_004.md) 📄 [HTML](zedt14_004.html) | - | 19 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT14_100](zedt14_100.md) 📄 [HTML](zedt14_100.html) | - | 25 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT14_101](zedt14_101.md) 📄 [HTML](zedt14_101.html) | - | 23 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT14_102](zedt14_102.md) 📄 [HTML](zedt14_102.html) | - | 16 | MANDT, ZPERNR, ZDEPCODE ... (+2) |
| [ZEDT14_103](zedt14_103.md) 📄 [HTML](zedt14_103.html) | - | 12 | MANDT, ZPERNR |
| [ZEDT14_104](zedt14_104.md) 📄 [HTML](zedt14_104.html) | - | 14 | MANDT, ZPERNR, ZDEPCODE ... (+3) |
| [ZEDT14_105](zedt14_105.md) 📄 [HTML](zedt14_105.html) | - | 22 | MANDT, ZPERNR, ZYEAR |
| [ZEDT14_106](zedt14_106.md) 📄 [HTML](zedt14_106.html) | - | 15 | MANDT, ZPERNR, ZYEAR ... (+2) |
| [ZEKKO_14](zekko_14.md) 📄 [HTML](zekko_14.html) | - | 15 | MANDT, EBELN |
| [ZEKPO_14](zekpo_14.md) 📄 [HTML](zekpo_14.html) | - | 20 | MANDT, EBELN, EBELP |
| [ZLFA1_14](zlfa1_14.md) 📄 [HTML](zlfa1_14.html) | - | 21 | MANDT, LIFNR |
| [ZLFB1_14](zlfb1_14.md) 📄 [HTML](zlfb1_14.html) | - | 13 | MANDT, LIFNR, BUKRS |
| [ZLFM1_14](zlfm1_14.md) 📄 [HTML](zlfm1_14.html) | - | 19 | MANDT, LIFNR, EKORG |
| [ZMARA_14](zmara_14.md) 📄 [HTML](zmara_14.html) | - | 17 | MANDT, WERKS, LGORT ... (+1) |
| [ZMKPF_14](zmkpf_14.md) 📄 [HTML](zmkpf_14.html) | - | 15 | MANDT, MBLNR, MJAHR |
| [ZMSEG_14](zmseg_14.md) 📄 [HTML](zmseg_14.html) | - | 27 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP_14](zrbkp_14.md) 📄 [HTML](zrbkp_14.html) | - | 39 | MANDT, BELNR, GJAHR |
| [ZRSEG_14](zrseg_14.md) 📄 [HTML](zrseg_14.html) | - | 24 | MANDT, BELNR, GJAHR ... (+1) |
| [ZTCURR14](ztcurr14.md) 📄 [HTML](ztcurr14.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS14_001

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

📋 [마크다운으로 보기](zeds14_001.md) | 📄 [HTML로 보기](zeds14_001.html)

---

### ZEDS14_002

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

📋 [마크다운으로 보기](zeds14_002.md) | 📄 [HTML로 보기](zeds14_002.html)

---

### ZEDT14_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS14_002

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

📋 [마크다운으로 보기](zedt14_001.md) | 📄 [HTML로 보기](zedt14_001.html)

---

### ZEDT14_002

**Key 필드:** `MANDT, ZPERNR, ZCODE`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt14_002.md) | 📄 [HTML로 보기](zedt14_002.html)

---

### ZEDT14_003

**Key 필드:** `MANDT, ZMGUBUN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMGNAME` | CHAR | 20 | ##### |

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt14_003.md) | 📄 [HTML로 보기](zedt14_003.html)

---

### ZEDT14_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | - |
| `ZGRADE` | CHAR | 1 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(9), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt14_004.md) | 📄 [HTML로 보기](zedt14_004.html)

---

### ZEDT14_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS14_002

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

📋 [마크다운으로 보기](zedt14_100.md) | 📄 [HTML로 보기](zedt14_100.html)

---

### ZEDT14_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS14_002

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

📋 [마크다운으로 보기](zedt14_101.md) | 📄 [HTML로 보기](zedt14_101.html)

---

### ZEDT14_102

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, DATBI, DATAB`

**INCLUDE 구조:** ZEDS14_002

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

📋 [마크다운으로 보기](zedt14_102.md) | 📄 [HTML로 보기](zedt14_102.html)

---

### ZEDT14_103

**Key 필드:** `MANDT, ZPERNR`

**INCLUDE 구조:** ZEDS14_002

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

📋 [마크다운으로 보기](zedt14_103.md) | 📄 [HTML로 보기](zedt14_103.html)

---

### ZEDT14_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), INT4(1)

📋 [마크다운으로 보기](zedt14_104.md) | 📄 [HTML로 보기](zedt14_104.html)

---

### ZEDT14_105

**Key 필드:** `MANDT, ZPERNR, ZYEAR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMON01` | CURR | 13 | 1### |
| `ZMON02` | CURR | 13 | 2### |
| `ZMON03` | CURR | 13 | 3### |
| `ZMON04` | CURR | 13 | 4### |
| `ZMON05` | CURR | 13 | 5### |

*... 외 5개 필드*

**데이터 타입:** CURR(12), CHAR(4), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt14_105.md) | 📄 [HTML로 보기](zedt14_105.html)

---

### ZEDT14_106

**Key 필드:** `MANDT, ZPERNR, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY` | CURR | 13 | - |
| `ZBANKCODE` | CHAR | 3 | - |
| `ZACCOUNT` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(4), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt14_106.md) | 📄 [HTML로 보기](zedt14_106.html)

---

### ZEKKO_14

**Key 필드:** `MANDT, EBELN`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | - |
| `EKORG` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | ##### |
| `BEDAT` | DATS | 8 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zekko_14.md) | 📄 [HTML로 보기](zekko_14.html)

---

### ZEKPO_14

**Key 필드:** `MANDT, EBELN, EBELP`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | - |
| `MEINS` | UNIT | 3 | ##1 |
| `BPRME` | UNIT | 3 | ##2 |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(3), UNIT(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zekpo_14.md) | 📄 [HTML로 보기](zekpo_14.html)

---

### ZLFA1_14

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | - |
| `LAND1` | CHAR | 3 | ### |
| `KTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | - |
| `STCD2` | CHAR | 11 | ##### |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zlfa1_14.md) | 📄 [HTML로 보기](zlfa1_14.html)

---

### ZLFB1_14

**Key 필드:** `MANDT, LIFNR, BUKRS`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | ##### |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zlfb1_14.md) | 📄 [HTML로 보기](zlfb1_14.html)

---

### ZLFM1_14

**Key 필드:** `MANDT, LIFNR, EKORG`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | - |
| `LOEVM` | CHAR | 1 | ##### |
| `WAERS` | CUKY | 5 | ###### |
| `MWSKZ` | CHAR | 2 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_14.md) | 📄 [HTML로 보기](zlfm1_14.html)

---

### ZMARA_14

**Key 필드:** `MANDT, WERKS, LGORT, MATNR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAKTX` | CHAR | 20 | ### |
| `MTART` | CHAR | 4 | - |
| `STPRS` | CURR | 11 | - |
| `WAERS` | CUKY | 5 | - |
| `MENGE` | QUAN | 13 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmara_14.md) | 📄 [HTML로 보기](zmara_14.html)

---

### ZMKPF_14

**Key 필드:** `MANDT, MBLNR, MJAHR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `EBELN` | CHAR | 10 | Purchase order number |
| `WERKS` | CHAR | 4 | Plant |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf_14.md) | 📄 [HTML로 보기](zmkpf_14.html)

---

### ZMSEG_14

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Vendor's account number |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(12), NUMC(3), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zmseg_14.md) | 📄 [HTML로 보기](zmseg_14.html)

---

### ZRBKP_14

**Key 필드:** `MANDT, BELNR, GJAHR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

*... 외 5개 필드*

**데이터 타입:** CHAR(14), DATS(4), NUMC(2), CURR(2), TIMS(2)

📋 [마크다운으로 보기](zrbkp_14.md) | 📄 [HTML로 보기](zrbkp_14.html)

---

### ZRSEG_14

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | ### |
| `WERKS` | CHAR | 4 | Plant |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), UNIT(2), CURR(2), DATS(2)

📋 [마크다운으로 보기](zrseg_14.md) | 📄 [HTML로 보기](zrseg_14.html)

---

### ZTCURR14

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `UNAME` | CHAR | 8 | ### |
| `DATUM` | DATS | 8 | ### |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📋 [마크다운으로 보기](ztcurr14.md) | 📄 [HTML로 보기](ztcurr14.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
