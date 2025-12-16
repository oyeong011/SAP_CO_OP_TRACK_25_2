# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS21_001](zeds21_001.md) 📄 [HTML](zeds21_001.html) | - | 9 | - |
| [ZEDS21_002](zeds21_002.md) 📄 [HTML](zeds21_002.html) | - | 6 | - |
| [ZEDT21_001](zedt21_001.md) 📄 [HTML](zedt21_001.html) | - | 16 | MANDT, ZCODE21, ZPERNR21 |
| [ZEDT21_002](zedt21_002.md) 📄 [HTML](zedt21_002.html) | - | 24 | MANDT, ZCODE21, ZPERNR21 |
| [ZEDT21_003](zedt21_003.md) 📄 [HTML](zedt21_003.html) | - | 5 | MANDT, ZMGUBUN21 |
| [ZEDT21_004](zedt21_004.md) 📄 [HTML](zedt21_004.html) | - | 32 | MANDT, ZCODE21, ZPERNR21 ... (+3) |
| [ZEDT21_100](zedt21_100.md) 📄 [HTML](zedt21_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT21_101](zedt21_101.md) 📄 [HTML](zedt21_101.html) | - | 38 | MANDT, ZORDNO21, ZIDCODE21 ... (+2) |
| [ZEDT21_102](zedt21_102.md) 📄 [HTML](zedt21_102.html) | - | 30 | MANDT, ZPERNR21, ZDEPCODE21 ... (+2) |
| [ZEDT21_103](zedt21_103.md) 📄 [HTML](zedt21_103.html) | - | 12 | MANDT, ZPERNR21 |
| [ZEDT21_104](zedt21_104.md) 📄 [HTML](zedt21_104.html) | - | 25 | MANDT, ZPERNR21, ZDEPCODE21 ... (+3) |
| [ZEDT21_105](zedt21_105.md) 📄 [HTML](zedt21_105.html) | - | 22 | MANDT, ZPERNR21, ZYEAR21 |
| [ZEDT21_106](zedt21_106.md) 📄 [HTML](zedt21_106.html) | - | 20 | MANDT, ZPERNR21, ZYEAR21 ... (+2) |
| [ZEDT21_200](zedt21_200.md) 📄 [HTML](zedt21_200.html) | - | 23 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZEKKO21](zekko21.md) 📄 [HTML](zekko21.html) | - | 8 | MANDT, EBELN |
| [ZEKPO21](zekpo21.md) 📄 [HTML](zekpo21.html) | - | 11 | MANDT, EBELN, EBELP |
| [ZLFA1_21](zlfa1_21.md) 📄 [HTML](zlfa1_21.html) | - | 14 | MANDT, LIFNR |
| [ZLFB1_21](zlfb1_21.md) 📄 [HTML](zlfb1_21.html) | - | 34 | MANDT, LIFNR |
| [ZLFM1_21](zlfm1_21.md) 📄 [HTML](zlfm1_21.html) | - | 14 | MANDT, LIFNR |
| [ZLIFNR_21](zlifnr_21.md) 📄 [HTML](zlifnr_21.html) | - | 8 | MANDT, LIFNR |
| [ZMKPF21](zmkpf21.md) 📄 [HTML](zmkpf21.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG21](zmseg21.md) 📄 [HTML](zmseg21.html) | - | 19 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP21](zrbkp21.md) 📄 [HTML](zrbkp21.html) | - | 6 | MANDT, BELNR, GJAHR |
| [ZRSEG21](zrseg21.md) 📄 [HTML](zrseg21.html) | - | 21 | MANDT, BELNR, GJAHR ... (+1) |
| [ZTCURR21](ztcurr21.md) 📄 [HTML](ztcurr21.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS21_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MANDT` | CLNT | 3 | Client |
| `ZCODE21` | CHAR | 10 | - |
| `ZPERNR21` | CHAR | 10 | - |
| `ZKNAME21` | CHAR | 10 | - |
| `ZENAME21` | CHAR | 10 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(6), CLNT(1)

📋 [마크다운으로 보기](zeds21_001.md) | 📄 [HTML로 보기](zeds21_001.html)

---

### ZEDS21_002

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

📋 [마크다운으로 보기](zeds21_002.md) | 📄 [HTML로 보기](zeds21_002.html)

---

### ZEDT21_001

**Key 필드:** `MANDT, ZCODE21, ZPERNR21`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME21` | CHAR | 10 | - |
| `ZENAME21` | CHAR | 10 | - |
| `ZGUBUN21` | CHAR | 1 | - |
| `ZTEL21` | CHAR | 16 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt21_001.md) | 📄 [HTML로 보기](zedt21_001.html)

---

### ZEDT21_002

**Key 필드:** `MANDT, ZCODE21, ZPERNR21`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR21` | CHAR | 10 | - |
| `ZMNAME21` | CHAR | 20 | ### |
| `ZMGUBUN21` | CHAR | 1 | - |
| `ZSUM21` | CURR | 13 | - |
| `ZWAERS21` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt21_002.md) | 📄 [HTML로 보기](zedt21_002.html)

---

### ZEDT21_003

**Key 필드:** `MANDT, ZMGUBUN21`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMGNAME21` | CHAR | 20 | ##### |

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt21_003.md) | 📄 [HTML로 보기](zedt21_003.html)

---

### ZEDT21_004

**Key 필드:** `MANDT, ZCODE21, ZPERNR21, ZSCHOOL21, ZSEM21, ZEXAM21`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR21` | CHAR | 10 | - |
| `ZMNAME21` | CHAR | 20 | ### |
| `ZSUM21` | CURR | 13 | - |
| `ZWAERS21` | CUKY | 5 | - |
| `ZGRADE21` | CHAR | 1 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(9), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt21_004.md) | 📄 [HTML로 보기](zedt21_004.html)

---

### ZEDT21_100

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

📋 [마크다운으로 보기](zedt21_100.md) | 📄 [HTML로 보기](zedt21_100.html)

---

### ZEDT21_101

**Key 필드:** `MANDT, ZORDNO21, ZIDCODE21, ZMATNR21, ZMTART21`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME21` | CHAR | 20 | ### |
| `ZVOLUM21` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |
| `VRKME` | UNIT | 3 | Sales Unit |
| `ZSLAMT21` | CURR | 13 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), TIMS(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zedt21_101.md) | 📄 [HTML로 보기](zedt21_101.html)

---

### ZEDT21_102

**Key 필드:** `MANDT, ZPERNR21, ZDEPCODE21, DATBI, DATAB`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZDEPRANK21` | CHAR | 1 | - |
| `ZEDATE21` | DATS | 8 | - |
| `ZQDATE21` | DATS | 8 | - |
| `ZQFLAG21` | CHAR | 1 | - |
| `CRNAM` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(6), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt21_102.md) | 📄 [HTML로 보기](zedt21_102.html)

---

### ZEDT21_103

**Key 필드:** `MANDT, ZPERNR21`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME21` | CHAR | 10 | - |
| `ZGENDER21` | CHAR | 1 | - |
| `ZADDRESS21` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Created On |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt21_103.md) | 📄 [HTML로 보기](zedt21_103.html)

---

### ZEDT21_104

**Key 필드:** `MANDT, ZPERNR21, ZDEPCODE21, ZYEAR21, DATBI, DATAB`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK21` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Created On |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Last Changed By |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt21_104.md) | 📄 [HTML로 보기](zedt21_104.html)

---

### ZEDT21_105

**Key 필드:** `MANDT, ZPERNR21, ZYEAR21`

**INCLUDE 구조:** ZEDS21_002

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

📋 [마크다운으로 보기](zedt21_105.md) | 📄 [HTML로 보기](zedt21_105.html)

---

### ZEDT21_106

**Key 필드:** `MANDT, ZPERNR21, ZYEAR21, DATBI, DATAB`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY21` | CURR | 13 | - |
| `ZBANKCODE21` | CHAR | 3 | - |
| `ZACCOUNT21` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Created On |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt21_106.md) | 📄 [HTML로 보기](zedt21_106.html)

---

### ZEDT21_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `ZMTART` | CHAR | 3 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt21_200.md) | 📄 [HTML로 보기](zedt21_200.html)

---

### ZEKKO21

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

📋 [마크다운으로 보기](zekko21.md) | 📄 [HTML로 보기](zekko21.html)

---

### ZEKPO21

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |
| `MEINS` | UNIT | 3 | Purchase Order Unit of Measure |
| `BPRME` | CURR | 11 | Standard price |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zekpo21.md) | 📄 [HTML로 보기](zekpo21.html)

---

### ZLFA1_21

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

📋 [마크다운으로 보기](zlfa1_21.md) | 📄 [HTML로 보기](zlfa1_21.html)

---

### ZLFB1_21

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_21.md) | 📄 [HTML로 보기](zlfb1_21.html)

---

### ZLFM1_21

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_21.md) | 📄 [HTML로 보기](zlfm1_21.html)

---

### ZLIFNR_21

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | Reconciliation Account in General Ledger |
| `ZTERM` | CHAR | 4 | Terms of Payment Key |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlifnr_21.md) | 📄 [HTML로 보기](zlifnr_21.html)

---

### ZMKPF21

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf21.md) | 📄 [HTML로 보기](zmkpf21.html)

---

### ZMSEG21

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | Storage Location |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zmseg21.md) | 📄 [HTML로 보기](zmseg21.html)

---

### ZRBKP21

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zrbkp21.md) | 📄 [HTML로 보기](zrbkp21.html)

---

### ZRSEG21

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `MENGE` | QUAN | 13 | Quantity |
| `BSTME` | UNIT | 3 | Purchase Order Unit of Measure |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), NUMC(3), UNIT(3), CURR(3), CLNT(1)

📋 [마크다운으로 보기](zrseg21.md) | 📄 [HTML로 보기](zrseg21.html)

---

### ZTCURR21

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `MODIFER` | CHAR | 8 | ### |
| `EDATE` | DATS | 8 | Creation date |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📋 [마크다운으로 보기](ztcurr21.md) | 📄 [HTML로 보기](ztcurr21.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
