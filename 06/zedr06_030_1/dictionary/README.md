# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS06_001](zeds06_001.html) | - | 9 | - |
| [ZEDS06_002](zeds06_002.html) | - | 6 | - |
| [ZEDT06_000](zedt06_000.html) | - | 9 | MANDT, ZCODE |
| [ZEDT06_BKPF](zedt06_bkpf.html) | - | 23 | MANDT, BELNR, GJAHR ... (+1) |
| [ZEDT06_BSEG](zedt06_bseg.html) | - | 24 | MANDT, BELNR, GJAHR ... (+1) |
| [ZEDT06_EKKO](zedt06_ekko.html) | - | 8 | MANDT, EBELN, BUKRS ... (+1) |
| [ZEDT06_EKPO](zedt06_ekpo.html) | - | 11 | MANDT, EBELN, EBELP |
| [ZEDT06_LFA1](zedt06_lfa1.html) | - | 22 | MANDT, LIFNR |
| [ZEDT06_LFB1](zedt06_lfb1.html) | - | 41 | MANDT, LIFNR, BUKRS |
| [ZEDT06_LFM1](zedt06_lfm1.html) | - | 21 | MANDT, LIFNR |
| [ZEDT06_MAT](zedt06_mat.html) | - | 40 | MANDT, WERKS, LGORT ... (+1) |
| [ZEDT06_MKPF](zedt06_mkpf.html) | - | 14 | MANDT, MBLNR |
| [ZEDT06_MSEG](zedt06_mseg.html) | - | 32 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZPDT19_006](zpdt19_006.html) | - | 23 | BUKRS, LIFNR, GJAHR ... (+1) |
| [ZPRO07_006](zpro07_006.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZPRO11_006](zpro11_006.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZTCURR06](ztcurr06.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS06_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MANDT` | CLNT | 3 | Client |
| `ZCODE` | CHAR | 10 | - |
| `ZPERNR` | CHAR | 10 | - |
| `ZKNAME` | CHAR | 20 | - |
| `ZENNAME` | CHAR | 20 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(6), CLNT(1)

📄 [전체 테이블 구조 보기](zeds06_001.html)

---

### ZEDS06_002

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

📄 [전체 테이블 구조 보기](zeds06_002.html)

---

### ZEDT06_000

**Key 필드:** `MANDT, ZCODE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPERNR` | CHAR | 10 | - |
| `ZKNAME` | CHAR | 20 | - |
| `ZENNAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |

**데이터 타입:** CHAR(6), CLNT(1)

📄 [전체 테이블 구조 보기](zedt06_000.html)

---

### ZEDT06_BKPF

**Key 필드:** `MANDT, BELNR, GJAHR, BUKRS`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | - |
| `BLDAT` | DATS | 8 | ### |
| `BUDAT` | DATS | 8 | ### |
| `REF_DOC_TYPE` | CHAR | 2 | ###### |
| `REF_DOC_NO` | CHAR | 16 | ###### |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(4), NUMC(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt06_bkpf.html)

---

### ZEDT06_BSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `HKONT` | NUMC | 8 | - |
| `SHKZG` | CHAR | 1 | #/## |
| `DMBTR` | CURR | 13 | - |
| `WAERS` | CUKY | 5 | ### |
| `MATNR` | CHAR | 10 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), NUMC(3), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt06_bseg.html)

---

### ZEDT06_EKKO

**Key 필드:** `MANDT, EBELN, BUKRS, EKGRP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BEDAT` | DATS | 8 | Purchase Order Date |
| `WAERS` | CUKY | 5 | Currency Key |

**데이터 타입:** CHAR(5), CLNT(1), DATS(1), CUKY(1)

📄 [전체 테이블 구조 보기](zedt06_ekko.html)

---

### ZEDT06_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | CURR | 11 | Net price |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📄 [전체 테이블 구조 보기](zedt06_ekpo.html)

---

### ZEDT06_LFA1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS06_002

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

📄 [전체 테이블 구조 보기](zedt06_lfa1.html)

---

### ZEDT06_LFB1

**Key 필드:** `MANDT, LIFNR, BUKRS`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 5 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt06_lfb1.html)

---

### ZEDT06_LFM1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS06_002

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

📄 [전체 테이블 구조 보기](zedt06_lfm1.html)

---

### ZEDT06_MAT

**Key 필드:** `MANDT, WERKS, LGORT, ZMATNR`

**INCLUDE 구조:** ZEDS06_002

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

📄 [전체 테이블 구조 보기](zedt06_mat.html)

---

### ZEDT06_MKPF

**Key 필드:** `MANDT, MBLNR`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MJAHR` | NUMC | 4 | - |
| `BLART` | CHAR | 2 | - |
| `BLDAT` | DATS | 8 | ### |
| `BUDAT` | DATS | 8 | ### |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(4), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zedt06_mkpf.html)

---

### ZEDT06_MSEG

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

📄 [전체 테이블 구조 보기](zedt06_mseg.html)

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

📄 [전체 테이블 구조 보기](zpdt19_006.html)

---

### ZPRO07_006

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zpro07_006.html)

---

### ZPRO11_006

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zpro11_006.html)

---

### ZTCURR06

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

📄 [전체 테이블 구조 보기](ztcurr06.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
