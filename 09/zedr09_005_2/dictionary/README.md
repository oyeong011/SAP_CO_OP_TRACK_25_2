# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZBKPF09](zbkpf09.html) | #### ## | 12 | MANDT, BUKRS, BELNR ... (+1) |
| [ZBSEG09](zbseg09.html) | ## ## #### | 30 | MANDT, BUKRS, BELNR ... (+2) |
| [ZEDS09_001](zeds09_001.html) | - | 8 | - |
| [ZEDS09_002](zeds09_002.html) | - | 6 | - |
| [ZEDT09_001](zedt09_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEKKO_09](zekko_09.html) | - | 11 | MANDT, EBELN |
| [ZEKPO_09](zekpo_09.html) | - | 36 | MANDT, EBELN, EBELP |
| [ZLFA1_09](zlfa1_09.html) | #### ###(## ###) | 15 | MANDT, LIFNR |
| [ZLFB1_09](zlfb1_09.html) | #### ###(####) | 37 | MANDT, LIFNR, BUKRS |
| [ZLFM1_09](zlfm1_09.html) | #### ### ### #### ### | 23 | MANDT, LIFNR, EKORG |
| [ZLGORT09_T](zlgort09_t.html) | - | 13 | MANDT, LGORT |
| [ZMARA09](zmara09.html) | - | 31 | MANDT, WERKS, LGORT ... (+1) |
| [ZMAST09](zmast09.html) | BOM# ## ## | 8 | MANDT, MATNR, WERKS ... (+1) |
| [ZMKPF09](zmkpf09.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG09](zmseg09.html) | - | 53 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZMWSKZ09_SHT](zmwskz09_sht.html) | - | 3 | MANDT, ZGUBUN |
| [ZPRO07_009](zpro07_009.html) | - | 18 | MANDT, BELNR, GJAHR ... (+1) |
| [ZPRO11_009](zpro11_009.html) | - | 18 | MANDT, BELNR, GJAHR ... (+1) |
| [ZRBKP09](zrbkp09.html) | ## ## | 45 | MANDT, BELNR, GJAHR |
| [ZRSEG09](zrseg09.html) | ## ### | 30 | MANDT, BELNR, GJAHR ... (+1) |
| [ZSKA109](zska109.html) | - | 10 | MANDT, SAKNR |
| [ZSTKO09](zstko09.html) | BOM ## | 5 | MANDT, STLNR, STLAL |
| [ZSTPO09](zstpo09.html) | BOM ## | 6 | MANDT, STLNR, STLKN |
| [ZTBSL09](ztbsl09.html) | ### | 13 | MANDT, BSCHL |
| [ZTCURR09](ztcurr09.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |
| [ZTT_STUDENT](ztt_student.html) | ZEDT09_001 ### ## | 1 | - |
| [ZWERKS09_T](zwerks09_t.html) | - | 7 | MANDT, WERKS |

---

## 테이블 상세 정보

### ZBKPF09

**설명:** #### ##

**Key 필드:** `MANDT, BUKRS, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | - |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `XBLNR` | CHAR | 16 | Reference Document Number |

**데이터 타입:** CHAR(4), DATS(2), CLNT(1), NUMC(1), CUKY(1)

📄 [전체 테이블 구조 보기](zbkpf09.html)

---

### ZBSEG09

**설명:** ## ## ####

**Key 필드:** `MANDT, BUKRS, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUZID` | CHAR | 1 | Identification of the Line Item |
| `BSCHL` | CHAR | 2 | Posting Key |
| `KOART` | CHAR | 1 | Account type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |
| `DMBTR` | CURR | 13 | Amount in local currency |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), CURR(7), NUMC(3), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zbseg09.html)

---

### ZEDS09_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPERNR` | CHAR | 10 | - |
| `ZCODE` | CHAR | 10 | ## ## |
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |

*... 외 1개 필드*

**데이터 타입:** CHAR(6)

📄 [전체 테이블 구조 보기](zeds09_001.html)

---

### ZEDS09_002

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

📄 [전체 테이블 구조 보기](zeds09_002.html)

---

### ZEDT09_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS09_002

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

📄 [전체 테이블 구조 보기](zedt09_001.html)

---

### ZEKKO_09

**Key 필드:** `MANDT, EBELN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | ##### |
| `BEDAT` | DATS | 8 | Purchasing Document Date |

*... 외 1개 필드*

**데이터 타입:** CHAR(5), CLNT(1), DATS(1), CUKY(1)

📄 [전체 테이블 구조 보기](zekko_09.html)

---

### ZEKPO_09

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | - |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `STPRS` | CURR | 11 | Standard price |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📄 [전체 테이블 구조 보기](zekpo_09.html)

---

### ZLFA1_09

**설명:** #### ###(## ###)

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | Name 1 |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | - |
| `STCD1` | CHAR | 16 | - |
| `STCD2` | CHAR | 11 | - |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📄 [전체 테이블 구조 보기](zlfa1_09.html)

---

### ZLFB1_09

**설명:** #### ###(####)

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Flag for Master Record (Company Code Level) |
| `AKONT` | CHAR | 10 | ###### #### |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📄 [전체 테이블 구조 보기](zlfb1_09.html)

---

### ZLFM1_09

**설명:** #### ### ### #### ###

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | - |
| `LOEVM` | CHAR | 1 | Delete flag for vendor at purchasing level |
| `WAERS` | CUKY | 5 | Purchase order currency |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zlfm1_09.html)

---

### ZLGORT09_T

**Key 필드:** `MANDT, LGORT`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZTEXT` | CHAR | 30 | Name |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zlgort09_t.html)

---

### ZMARA09

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | - |
| `MTART` | CHAR | 4 | - |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 1개 필드*

**데이터 타입:** CHAR(5), CLNT(1), CURR(1), CUKY(1), QUAN(1)

📄 [전체 테이블 구조 보기](zmara09.html)

---

### ZMAST09

**설명:** BOM# ## ##

**Key 필드:** `MANDT, MATNR, WERKS, STLNR`

**데이터 타입:** CHAR(3), CLNT(1)

📄 [전체 테이블 구조 보기](zmast09.html)

---

### ZMKPF09

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zmkpf09.html)

---

### ZMSEG09

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LINE_ID` | NUMC | 6 | Unique identification of document line |
| `PARENT_ID` | NUMC | 6 | Identifier of immediately superior line |
| `BWART` | CHAR | 3 | Movement type (inventory management) |
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 4 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(15), NUMC(8), CLNT(1), CUKY(1), CURR(1)

📄 [전체 테이블 구조 보기](zmseg09.html)

---

### ZMWSKZ09_SHT

**Key 필드:** `MANDT, ZGUBUN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZTEXT` | CHAR | 30 | - |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zmwskz09_sht.html)

---

### ZPRO07_009

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `BUKRS` | CHAR | 4 | Company Code |
| `WERKS` | CHAR | 4 | Plant |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), NUMC(3), UNIT(3), CLNT(1), CURR(1)

📄 [전체 테이블 구조 보기](zpro07_009.html)

---

### ZPRO11_009

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `BUKRS` | CHAR | 4 | Company Code |
| `WERKS` | CHAR | 4 | Plant |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), NUMC(3), UNIT(3), CLNT(1), CURR(1)

📄 [전체 테이블 구조 보기](zpro11_009.html)

---

### ZRBKP09

**설명:** ## ##

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

📄 [전체 테이블 구조 보기](zrbkp09.html)

---

### ZRSEG09

**설명:** ## ###

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 4 | ### |
| `WRBTR` | CURR | 13 | Amount in document currency |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), CURR(4), NUMC(3), UNIT(2), CLNT(1)

📄 [전체 테이블 구조 보기](zrseg09.html)

---

### ZSKA109

**Key 필드:** `MANDT, SAKNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `KTOSL` | CHAR | 3 | Transaction Key |
| `KOART` | CHAR | 1 | Account type |
| `TEXT` | CHAR | 30 | - |

**데이터 타입:** CHAR(4), CLNT(1)

📄 [전체 테이블 구조 보기](zska109.html)

---

### ZSTKO09

**설명:** BOM ##

**Key 필드:** `MANDT, STLNR, STLAL`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `DATUV` | DATS | 8 | Valid-From Date |
| `ANDAT` | DATS | 8 | Date record created on |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zstko09.html)

---

### ZSTPO09

**설명:** BOM ##

**Key 필드:** `MANDT, STLNR, STLKN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `IDNRK` | CHAR | 10 | - |
| `MENGE` | QUAN | 13 | Component quantity |
| `MEINS` | UNIT | 3 | Component unit of measure |

**데이터 타입:** CHAR(2), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📄 [전체 테이블 구조 보기](zstpo09.html)

---

### ZTBSL09

**설명:** ###

**Key 필드:** `MANDT, BSCHL`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `STBSL` | CHAR | 2 | Posting Key for Reversal/Reverse Entry |
| `KOART` | CHAR | 1 | Account type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |
| `ZTEXT` | CHAR | 30 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📄 [전체 테이블 구조 보기](ztbsl09.html)

---

### ZTCURR09

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `ERNAME` | CHAR | 12 | - |
| `ERDATE` | DATS | 8 | - |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📄 [전체 테이블 구조 보기](ztcurr09.html)

---

### ZTT_STUDENT

**설명:** ZEDT09_001 ### ##

📄 [전체 테이블 구조 보기](ztt_student.html)

---

### ZWERKS09_T

**Key 필드:** `MANDT, WERKS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZTEXT` | CHAR | 30 | Name |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zwerks09_t.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
