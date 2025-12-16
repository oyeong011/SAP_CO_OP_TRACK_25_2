# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZBKPF19](zbkpf19.md) 📄 [HTML](zbkpf19.html) | - | 17 | BUKRS, LIFNR, GJAHR ... (+1) |
| [ZBSEG19](zbseg19.md) 📄 [HTML](zbseg19.html) | - | 22 | BUKRS, LIFNR, GJAHR ... (+1) |
| [ZEDS19_001](zeds19_001.md) 📄 [HTML](zeds19_001.html) | - | 14 | - |
| [ZEDS19_002](zeds19_002.md) 📄 [HTML](zeds19_002.html) | - | 6 | - |
| [ZEDT19_0000](zedt19_0000.md) 📄 [HTML](zedt19_0000.html) | - | 9 | MANDT, ZCODE19 |
| [ZEDT19_0001](zedt19_0001.md) 📄 [HTML](zedt19_0001.html) | - | 18 | ZCODE, ZPERNR |
| [ZEDT19_001](zedt19_001.md) 📄 [HTML](zedt19_001.html) | - | 17 | MANDT, ZCODE19, ZPERNR19 |
| [ZEDT19_002](zedt19_002.md) 📄 [HTML](zedt19_002.html) | - | 22 | MANDT, ZCODE, ZPERNR |
| [ZEDT19_003](zedt19_003.md) 📄 [HTML](zedt19_003.html) | Search hlep zedt19_002-ZGUBUN data | 3 | MANDT, ZMGUBUN |
| [ZEDT19_004](zedt19_004.md) 📄 [HTML](zedt19_004.html) | - | 34 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT19_100](zedt19_100.md) 📄 [HTML](zedt19_100.html) | - | 36 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT19_101](zedt19_101.md) 📄 [HTML](zedt19_101.html) | - | 32 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT19_102](zedt19_102.md) 📄 [HTML](zedt19_102.html) | - | 30 | MANDT, ZPERNR, ZDEPCODE ... (+2) |
| [ZEDT19_103](zedt19_103.md) 📄 [HTML](zedt19_103.html) | - | 13 | MANDT, ZPERNR |
| [ZEDT19_104](zedt19_104.md) 📄 [HTML](zedt19_104.html) | - | 24 | MANDT, ZPERNR, ZDEPCODE |
| [ZEDT19_105](zedt19_105.md) 📄 [HTML](zedt19_105.html) | - | 21 | MANDT, ZPERNR, ZYEAR |
| [ZEDT19_106](zedt19_106.md) 📄 [HTML](zedt19_106.html) | - | 18 | MANDT, ZPERNR, ZYEAR ... (+2) |
| [ZEDT19_200](zedt19_200.md) 📄 [HTML](zedt19_200.html) | - | 24 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZMKPF19](zmkpf19.md) 📄 [HTML](zmkpf19.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG19](zmseg19.md) 📄 [HTML](zmseg19.html) | - | 27 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZPDT19_001](zpdt19_001.md) 📄 [HTML](zpdt19_001.html) | - | 14 | LIFNR |
| [ZPDT19_002](zpdt19_002.md) 📄 [HTML](zpdt19_002.html) | - | 31 | LIFNR, BUKRS |
| [ZPDT19_003](zpdt19_003.md) 📄 [HTML](zpdt19_003.html) | - | 13 | LIFNR, EKORG |
| [ZPDT19_004](zpdt19_004.md) 📄 [HTML](zpdt19_004.html) | - | 8 | MANDT, EBELN |
| [ZPDT19_005](zpdt19_005.md) 📄 [HTML](zpdt19_005.html) | - | 18 | MANDT, EBELN, EBELP |
| [ZPDT19_006](zpdt19_006.md) 📄 [HTML](zpdt19_006.html) | - | 23 | BUKRS, LIFNR, GJAHR ... (+1) |
| [ZRBKP19](zrbkp19.md) 📄 [HTML](zrbkp19.html) | - | 9 | MANDT, BELNR, GJAHR |
| [ZRSEG19](zrseg19.md) 📄 [HTML](zrseg19.html) | - | 22 | MANDT, BELNR, GJAHR ... (+1) |
| [ZTCURR19](ztcurr19.md) 📄 [HTML](ztcurr19.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZBKPF19

**Key 필드:** `BUKRS, LIFNR, GJAHR, BELNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `ZMWSKZ` | CHAR | 2 | ### |

*... 외 3개 필드*

**데이터 타입:** CHAR(7), DATS(3), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zbkpf19.md) | 📄 [HTML로 보기](zbkpf19.html)

---

### ZBSEG19

**Key 필드:** `BUKRS, LIFNR, GJAHR, BELNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(3), NUMC(1), CUKY(1), CURR(1)

📋 [마크다운으로 보기](zbseg19.md) | 📄 [HTML로 보기](zbseg19.html)

---

### ZEDS19_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPENR` | CHAR | 10 | ZPERNR19 |
| `ZCODE` | CHAR | 10 | ZCODE19 |
| `ZKNAME` | CHAR | 20 | ZKNAME19 |
| `ZENAME` | CHAR | 20 | ZENAME19 |
| `ZGENDER` | CHAR | 1 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds19_001.md) | 📄 [HTML로 보기](zeds19_001.html)

---

### ZEDS19_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Created On |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Last Changed By |
| `AEDATE` | DATS | 8 | Date of Last Change |

*... 외 1개 필드*

**데이터 타입:** CHAR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds19_002.md) | 📄 [HTML로 보기](zeds19_002.html)

---

### ZEDT19_0000

**Key 필드:** `MANDT, ZCODE19`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPERNR19` | CHAR | 10 | ZPERNR19 |
| `ZKNAME19` | CHAR | 20 | ZKNAME19 |
| `ZENAME19` | CHAR | 20 | ZENAME19 |
| `ZGUBUN19` | CHAR | 1 | ZGENDER19 |
| `ZTEL19` | CHAR | 16 | ZTEL19 |

**데이터 타입:** CHAR(6), CLNT(1)

📋 [마크다운으로 보기](zedt19_0000.md) | 📄 [HTML로 보기](zedt19_0000.html)

---

### ZEDT19_0001

**Key 필드:** `ZCODE, ZPERNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | ZKNAME19 |
| `ZENAME` | CHAR | 20 | ZENAME19 |
| `ZGENDER` | CHAR | 1 | ZGENDER19 |
| `ZTEL` | CHAR | 16 | ZTEL19 |
| `ZSUM` | CURR | 13 | - |

*... 외 3개 필드*

**데이터 타입:** CHAR(9), CURR(1)

📋 [마크다운으로 보기](zedt19_0001.md) | 📄 [HTML로 보기](zedt19_0001.html)

---

### ZEDT19_001

**Key 필드:** `MANDT, ZCODE19, ZPERNR19`

**INCLUDE 구조:** ZEDS19_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME19` | CHAR | 20 | ZKNAME19 |
| `ZENAME19` | CHAR | 20 | ZENAME19 |
| `ZGUBUN19` | CHAR | 1 | ZGENDER19 |
| `ZTEL19` | CHAR | 16 | ZTEL19 |
| `ZMNAME19` | CHAR | 20 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt19_001.md) | 📄 [HTML로 보기](zedt19_001.html)

---

### ZEDT19_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS19_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWARES` | CUKY | 5 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt19_002.md) | 📄 [HTML로 보기](zedt19_002.html)

---

### ZEDT19_003

**설명:** Search hlep zedt19_002-ZGUBUN data

**Key 필드:** `MANDT, ZMGUBUN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMGNAME` | CHAR | 20 | - |

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt19_003.md) | 📄 [HTML로 보기](zedt19_003.html)

---

### ZEDT19_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWARES` | CUKY | 5 | - |
| `ZGRADE` | CHAR | 1 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(9), CLNT(1), CURR(1), CUKY(1), INT8(1)

📋 [마크다운으로 보기](zedt19_004.md) | 📄 [HTML로 보기](zedt19_004.html)

---

### ZEDT19_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

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

📋 [마크다운으로 보기](zedt19_100.md) | 📄 [HTML로 보기](zedt19_100.html)

---

### ZEDT19_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

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

📋 [마크다운으로 보기](zedt19_101.md) | 📄 [HTML로 보기](zedt19_101.html)

---

### ZEDT19_102

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, DATBI, DATAB`

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

📋 [마크다운으로 보기](zedt19_102.md) | 📄 [HTML로 보기](zedt19_102.html)

---

### ZEDT19_103

**Key 필드:** `MANDT, ZPERNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZADDRESS` | CHAR | 20 | - |
| `CRNAME19` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt19_103.md) | 📄 [HTML로 보기](zedt19_103.html)

---

### ZEDT19_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZYEAR` | NUMC | 4 | - |
| `DATABI` | DATS | 8 | Valid To Date |
| `DATAB` | DATS | 8 | Valid-From Date |
| `ZRANK` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt19_104.md) | 📄 [HTML로 보기](zedt19_104.html)

---

### ZEDT19_105

**Key 필드:** `MANDT, ZPERNR, ZYEAR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMON01` | DEC | 17 | 1### |
| `ZMON02` | DEC | 17 | 2### |
| `ZMON03` | DEC | 17 | 3### |
| `ZMON04` | DEC | 17 | 4### |
| `ZMON05` | DEC | 17 | 5### |

*... 외 5개 필드*

**데이터 타입:** DEC(12), CHAR(3), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt19_105.md) | 📄 [HTML로 보기](zedt19_105.html)

---

### ZEDT19_106

**Key 필드:** `MANDT, ZPERNR, ZYEAR, DATBI, DATAB`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY` | DEC | 17 | - |
| `ZBANKCODE` | CHAR | 3 | - |
| `ZACCOUNT` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), DATS(4), CLNT(1), NUMC(1), DEC(1)

📋 [마크다운으로 보기](zedt19_106.md) | 📄 [HTML로 보기](zedt19_106.html)

---

### ZEDT19_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS19_002

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

📋 [마크다운으로 보기](zedt19_200.md) | 📄 [HTML로 보기](zedt19_200.html)

---

### ZMKPF19

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf19.md) | 📄 [HTML로 보기](zmkpf19.html)

---

### ZMSEG19

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `ZWERKS` | CHAR | 4 | - |
| `ZLGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zmseg19.md) | 📄 [HTML로 보기](zmseg19.html)

---

### ZPDT19_001

**Key 필드:** `LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `ZKTOKK` | CHAR | 4 | - |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7)

📋 [마크다운으로 보기](zpdt19_001.md) | 📄 [HTML로 보기](zpdt19_001.html)

---

### ZPDT19_002

**Key 필드:** `LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `ZAKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5)

📋 [마크다운으로 보기](zpdt19_002.md) | 📄 [HTML로 보기](zpdt19_002.html)

---

### ZPDT19_003

**Key 필드:** `LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `ZMWSKZ` | CHAR | 2 | ### |

**데이터 타입:** CHAR(5), CUKY(1)

📋 [마크다운으로 보기](zpdt19_003.md) | 📄 [HTML로 보기](zpdt19_003.html)

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

### ZPDT19_005

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |
| `MEINS` | UNIT | 3 | Purchase Order Unit of Measure |
| `PRDAT` | DATS | 8 | Date of last forecast |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zpdt19_005.md) | 📄 [HTML로 보기](zpdt19_005.html)

---

### ZPDT19_006

**Key 필드:** `BUKRS, LIFNR, GJAHR, BELNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(3), CURR(2), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zpdt19_006.md) | 📄 [HTML로 보기](zpdt19_006.html)

---

### ZRBKP19

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BUKRS` | CHAR | 4 | Company Code |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |

*... 외 1개 필드*

**데이터 타입:** CHAR(4), DATS(2), CLNT(1), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zrbkp19.md) | 📄 [HTML로 보기](zrbkp19.html)

---

### ZRSEG19

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `DMBTR` | CURR | 13 | Amount in local currency |
| `MWSTS` | CURR | 13 | Tax Amount in Local Currency |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), NUMC(2), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zrseg19.md) | 📄 [HTML로 보기](zrseg19.html)

---

### ZTCURR19

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

📋 [마크다운으로 보기](ztcurr19.md) | 📄 [HTML로 보기](ztcurr19.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
