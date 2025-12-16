# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZBKPF_05](zbkpf_05.md) 📄 [HTML](zbkpf_05.html) | - | 9 | MANDT, BUKRS, BELNR ... (+1) |
| [ZBSEG_05](zbseg_05.md) 📄 [HTML](zbseg_05.html) | - | 18 | MANDT, BUKRS, BELNR ... (+2) |
| [ZBSIK_05](zbsik_05.md) 📄 [HTML](zbsik_05.html) | - | 19 | MANDT, BUKRS, LIFNR ... (+2) |
| [ZEDS05_001](zeds05_001.md) 📄 [HTML](zeds05_001.html) | - | 15 | - |
| [ZEDS05_002](zeds05_002.md) 📄 [HTML](zeds05_002.html) | - | 6 | - |
| [ZEDS05_TUITION_REP](zeds05_tuition_rep.md) 📄 [HTML](zeds05_tuition_rep.html) | - | 9 | - |
| [ZEDT05_001](zedt05_001.md) 📄 [HTML](zedt05_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT05_002](zedt05_002.md) 📄 [HTML](zedt05_002.html) | - | 22 | MANDT, ZCODE, ZPERNR |
| [ZEDT05_003](zedt05_003.md) 📄 [HTML](zedt05_003.html) | - | 3 | MANDT, ZMGUBUN |
| [ZEDT05_004](zedt05_004.md) 📄 [HTML](zedt05_004.html) | - | 32 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT05_100](zedt05_100.md) 📄 [HTML](zedt05_100.html) | - | 47 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT05_101](zedt05_101.md) 📄 [HTML](zedt05_101.html) | - | 44 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT05_102](zedt05_102.md) 📄 [HTML](zedt05_102.html) | - | 30 | ZPERNR, ZDEPCODE, DATBI ... (+1) |
| [ZEDT05_103](zedt05_103.md) 📄 [HTML](zedt05_103.html) | - | 13 | ZPERNR |
| [ZEDT05_104](zedt05_104.md) 📄 [HTML](zedt05_104.html) | - | 24 | ZPERNR, ZDEPCODE, ZYEAR ... (+2) |
| [ZEDT05_105](zedt05_105.md) 📄 [HTML](zedt05_105.html) | - | 21 | ZPERNR, ZYEAR |
| [ZEDT05_106](zedt05_106.html) | - | 0 | - |
| [ZEDT05_200](zedt05_200.md) 📄 [HTML](zedt05_200.html) | - | 28 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZEDT05_MAJOR_MST](zedt05_major_mst.md) 📄 [HTML](zedt05_major_mst.html) | - | 11 | MANDT, MAJOR_CODE |
| [ZEDT05_SCH](zedt05_sch.md) 📄 [HTML](zedt05_sch.html) | - | 6 | MANDT, STUDENT_ID |
| [ZEDT05_STINFO](zedt05_stinfo.md) 📄 [HTML](zedt05_stinfo.html) | - | 10 | MANDT, STUDENT_ID |
| [ZEKGRP_05](zekgrp_05.md) 📄 [HTML](zekgrp_05.html) | - | 2 | EKGRP |
| [ZEKKO_05](zekko_05.md) 📄 [HTML](zekko_05.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_05](zekpo_05.md) 📄 [HTML](zekpo_05.html) | - | 21 | MANDT, EBELN, EBELP |
| [ZLFA1_05](zlfa1_05.md) 📄 [HTML](zlfa1_05.html) | - | 14 | MANDT, LIFNR |
| [ZLFB1_05](zlfb1_05.md) 📄 [HTML](zlfb1_05.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZLFM1_05](zlfm1_05.md) 📄 [HTML](zlfm1_05.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZMARA05](zmara05.md) 📄 [HTML](zmara05.html) | - | 31 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZMKPF_05](zmkpf_05.md) 📄 [HTML](zmkpf_05.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG_05](zmseg_05.md) 📄 [HTML](zmseg_05.html) | - | 29 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP_05](zrbkp_05.md) 📄 [HTML](zrbkp_05.html) | - | 49 | MANDT, BELNR, GJAHR |
| [ZRSEG_05](zrseg_05.md) 📄 [HTML](zrseg_05.html) | - | 39 | MANDT, BELNR, GJAHR ... (+1) |
| [ZTCURR05](ztcurr05.md) 📄 [HTML](ztcurr05.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZBKPF_05

**Key 필드:** `MANDT, BUKRS, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `AWKEY` | CHAR | 10 | Accounting Document Number |

**데이터 타입:** CHAR(4), DATS(2), CLNT(1), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zbkpf_05.md) | 📄 [HTML로 보기](zbkpf_05.html)

---

### ZBSEG_05

**Key 필드:** `MANDT, BUKRS, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `HKONT` | CHAR | 10 | General Ledger Account |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |
| `DMBTR` | CURR | 13 | Amount in local currency |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CLNT(1), CURR(1), QUAN(1)

📋 [마크다운으로 보기](zbseg_05.md) | 📄 [HTML로 보기](zbseg_05.html)

---

### ZBSIK_05

**Key 필드:** `MANDT, BUKRS, LIFNR, GJAHR, BELNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(3), CURR(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zbsik_05.md) | 📄 [HTML로 보기](zbsik_05.html)

---

### ZEDS05_001

**INCLUDE 구조:** ZEDS05_002

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

📋 [마크다운으로 보기](zeds05_001.md) | 📄 [HTML로 보기](zeds05_001.html)

---

### ZEDS05_002

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

📋 [마크다운으로 보기](zeds05_002.md) | 📄 [HTML로 보기](zeds05_002.html)

---

### ZEDS05_TUITION_REP

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `STUDENT_ID` | CHAR | 10 | - |
| `STUDENT_INFO` | STRG | 0 | - |
| `MAJOR_NAME` | CHAR | 40 | - |
| `TUITION_ORIGIN` | DEC | 13 | - |
| `DISCOUNT_AMT` | DEC | 13 | - |

*... 외 4개 필드*

**데이터 타입:** CHAR(3), DEC(3), INT4(2), STRG(1)

📋 [마크다운으로 보기](zeds05_tuition_rep.md) | 📄 [HTML로 보기](zeds05_tuition_rep.html)

---

### ZEDT05_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS05_002

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

📋 [마크다운으로 보기](zedt05_001.md) | 📄 [HTML로 보기](zedt05_001.html)

---

### ZEDT05_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 10 | - |
| `ZMNAME` | CHAR | 40 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt05_002.md) | 📄 [HTML로 보기](zedt05_002.html)

---

### ZEDT05_003

**Key 필드:** `MANDT, ZMGUBUN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMGNAME` | CHAR | 20 | ##### |

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt05_003.md) | 📄 [HTML로 보기](zedt05_003.html)

---

### ZEDT05_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 10 | - |
| `ZMNAME` | CHAR | 40 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | ### |
| `ZGRADE` | CHAR | 1 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(9), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt05_004.md) | 📄 [HTML로 보기](zedt05_004.html)

---

### ZEDT05_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMTART` | CHAR | 4 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `ZVOLUM` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |
| `VRKME` | UNIT | 3 | Sales Unit |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), CURR(3), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt05_100.md) | 📄 [HTML로 보기](zedt05_100.html)

---

### ZEDT05_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS05_002

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

📋 [마크다운으로 보기](zedt05_101.md) | 📄 [HTML로 보기](zedt05_101.html)

---

### ZEDT05_102

**Key 필드:** `ZPERNR, ZDEPCODE, DATBI, DATAB`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZDEPRANK` | CHAR | 1 | - |
| `ZEDATE` | DATS | 8 | - |
| `ZQDATE` | DATS | 8 | - |
| `ZQFLAG` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(6), TIMS(2)

📋 [마크다운으로 보기](zedt05_102.md) | 📄 [HTML로 보기](zedt05_102.html)

---

### ZEDT05_103

**Key 필드:** `ZPERNR`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZADDRESS` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zedt05_103.md) | 📄 [HTML로 보기](zedt05_103.html)

---

### ZEDT05_104

**Key 필드:** `ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), NUMC(1)

📋 [마크다운으로 보기](zedt05_104.md) | 📄 [HTML로 보기](zedt05_104.html)

---

### ZEDT05_105

**Key 필드:** `ZPERNR, ZYEAR`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMON01` | CURR | 13 | 1### |
| `ZMON02` | CURR | 13 | 2### |
| `ZMON03` | CURR | 13 | 3### |
| `ZMON04` | CURR | 13 | 4### |
| `ZMON05` | CURR | 13 | 5### |

*... 외 5개 필드*

**데이터 타입:** CURR(12), CHAR(3), DATS(2), TIMS(2), NUMC(1)

📋 [마크다운으로 보기](zedt05_105.md) | 📄 [HTML로 보기](zedt05_105.html)

---

### ZEDT05_106

📄 [전체 테이블 구조 보기](zedt05_106.html)

---

### ZEDT05_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS05_002

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

📋 [마크다운으로 보기](zedt05_200.md) | 📄 [HTML로 보기](zedt05_200.html)

---

### ZEDT05_MAJOR_MST

**Key 필드:** `MANDT, MAJOR_CODE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAJOR_NAME` | CHAR | 40 | ### |
| `TUITION` | CURR | 13 | - |
| `WAERS` | CUKY | 5 | Currency Key |

**데이터 타입:** CHAR(2), CLNT(1), CURR(1), CUKY(1)

📋 [마크다운으로 보기](zedt05_major_mst.md) | 📄 [HTML로 보기](zedt05_major_mst.html)

---

### ZEDT05_SCH

**Key 필드:** `MANDT, STUDENT_ID`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `SCHOLAR_TYPE` | CHAR | 1 | ## ## |
| `DISCOUNT_RATE` | DEC | 3 | ## ### (#: 0.30) |

**데이터 타입:** CHAR(2), CLNT(1), DEC(1)

📋 [마크다운으로 보기](zedt05_sch.md) | 📄 [HTML로 보기](zedt05_sch.html)

---

### ZEDT05_STINFO

**Key 필드:** `MANDT, STUDENT_ID`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAJOR_CODE` | CHAR | 10 | ## ## |
| `STUDENT_NAME` | CHAR | 20 | ## ## |
| `GENDER` | CHAR | 1 | - |
| `ADMISSION_DATE` | DATS | 8 | ### |
| `REG_TIME` | TIMS | 6 | ## ## ## |

*... 외 1개 필드*

**데이터 타입:** CHAR(4), CLNT(1), DATS(1), TIMS(1), STRG(1)

📋 [마크다운으로 보기](zedt05_stinfo.md) | 📄 [HTML로 보기](zedt05_stinfo.html)

---

### ZEKGRP_05

**Key 필드:** `EKGRP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 25 | Name of the controlling area |

**데이터 타입:** CHAR(2)

📋 [마크다운으로 보기](zekgrp_05.md) | 📄 [HTML로 보기](zekgrp_05.html)

---

### ZEKKO_05

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

📋 [마크다운으로 보기](zekko_05.md) | 📄 [HTML로 보기](zekko_05.html)

---

### ZEKPO_05

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

📋 [마크다운으로 보기](zekpo_05.md) | 📄 [HTML로 보기](zekpo_05.html)

---

### ZLFA1_05

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

📋 [마크다운으로 보기](zlfa1_05.md) | 📄 [HTML로 보기](zlfa1_05.html)

---

### ZLFB1_05

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_05.md) | 📄 [HTML로 보기](zlfb1_05.html)

---

### ZLFM1_05

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_05.md) | 📄 [HTML로 보기](zlfm1_05.html)

---

### ZMARA05

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS05_002

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

📋 [마크다운으로 보기](zmara05.md) | 📄 [HTML로 보기](zmara05.html)

---

### ZMKPF_05

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf_05.md) | 📄 [HTML로 보기](zmkpf_05.html)

---

### ZMSEG_05

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `ZWERKS` | CHAR | 4 | ### |
| `ZLGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Vendor's account number |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zmseg_05.md) | 📄 [HTML로 보기](zmseg_05.html)

---

### ZRBKP_05

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

📋 [마크다운으로 보기](zrbkp_05.md) | 📄 [HTML로 보기](zrbkp_05.html)

---

### ZRSEG_05

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

📋 [마크다운으로 보기](zrseg_05.md) | 📄 [HTML로 보기](zrseg_05.html)

---

### ZTCURR05

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

📋 [마크다운으로 보기](ztcurr05.md) | 📄 [HTML로 보기](ztcurr05.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
