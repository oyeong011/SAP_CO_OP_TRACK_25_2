# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS10_001](zeds10_001.html) | - | 9 | - |
| [ZEDS10_002](zeds10_002.html) | - | 6 | - |
| [ZEDT10_100](zedt10_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT10_101](zedt10_101.html) | - | 39 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT10_AKONT](zedt10_akont.html) | - | 4 | MANDT, AKONT, SPRAS |
| [ZEDT10_BSIK](zedt10_bsik.html) | - | 25 | MANDT, BUKRS, LIFNR ... (+3) |
| [ZEDT10_EKBE](zedt10_ekbe.html) | - | 40 | MANDT, EBELN, EBELP ... (+5) |
| [ZEDT10_EKKO](zedt10_ekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT10_EKPO](zedt10_ekpo.html) | - | 15 | MANDT, EBELN, EBELP |
| [ZEDT10_LFA1](zedt10_lfa1.html) | - | 8 | MANDT, LIFNR |
| [ZEDT10_LFB1](zedt10_lfb1.html) | - | 8 | MANDT, LIFNR, BUKRS |
| [ZEDT10_LFM1](zedt10_lfm1.html) | - | 9 | MANDT, LIFNR, EKORG |
| [ZEDT10_MAJOR_MST](zedt10_major_mst.html) | - | 11 | MANDT, MAJOR_CODE |
| [ZEDT10_MKPF](zedt10_mkpf.html) | - | 8 | MANDT, MBLNR, MJAHR |
| [ZEDT10_MODEL](zedt10_model.html) | - | 3 | MANDT, ZMODEL |
| [ZEDT10_MSEG](zedt10_mseg.html) | - | 21 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT10_MTART](zedt10_mtart.html) | - | 3 | MANDT, MTART |
| [ZEDT10_MWSKZ](zedt10_mwskz.html) | - | 6 | MANDT, MWSKZ, SPRAS |
| [ZEDT10_RBKP](zedt10_rbkp.html) | - | 20 | MANDT, BELNR, GJAHR |
| [ZEDT10_RSEG](zedt10_rseg.html) | - | 25 | MANDT, BELNR, GJAHR ... (+1) |
| [ZEDT10_SCHOLAR](zedt10_scholar.html) | - | 6 | MANDT, STUDENT_ID |
| [ZEDT10_STUDINFO](zedt10_studinfo.html) | - | 8 | MANDT, STUDENT_ID |
| [ZEDT10_TVKO](zedt10_tvko.html) | - | 4 | MANDT, EKORG |
| [ZEDT10_ZTERM](zedt10_zterm.html) | - | 4 | MANDT, ZTERM, SPRAS |
| [ZMARA10](zmara10.html) | - | 0 | - |
| [ZPRO07_010](zpro07_010.html) | - | 1 | MANDT |
| [ZPRO11_010](zpro11_010.html) | - | 23 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZTCURR10](ztcurr10.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS10_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MANDT` | CLNT | 3 | Client |
| `ZCODE` | CHAR | 10 | - |
| `ZPERNR` | CHAR | 10 | - |
| `ZKNAME` | CHAR | 10 | ## ## |
| `ZENAME` | CHAR | 10 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(6), CLNT(1)

📄 [전체 테이블 구조 보기](zeds10_001.html)

---

### ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Last Changed By |
| `AEDATE` | DATS | 8 | Date of Last Change |

*... 외 1개 필드*

**데이터 타입:** CHAR(2), DATS(2), TIMS(2)

📄 [전체 테이블 구조 보기](zeds10_002.html)

---

### ZEDT10_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS10_002

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

📄 [전체 테이블 구조 보기](zedt10_100.html)

---

### ZEDT10_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS10_002

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

📄 [전체 테이블 구조 보기](zedt10_101.html)

---

### ZEDT10_AKONT

**Key 필드:** `MANDT, AKONT, SPRAS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 40 | Text, 40 Characters Long |

**데이터 타입:** CHAR(2), CLNT(1), LANG(1)

📄 [전체 테이블 구조 보기](zedt10_akont.html)

---

### ZEDT10_BSIK

**Key 필드:** `MANDT, BUKRS, LIFNR, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(5), NUMC(2), CURR(2), TIMS(2)

📄 [전체 테이블 구조 보기](zedt10_bsik.html)

---

### ZEDT10_EKBE

**Key 필드:** `MANDT, EBELN, EBELP, ZEKKN, VGABE, GJAHR, BELNR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEWTP` | CHAR | 1 | Purchase Order History Category |
| `BWART` | CHAR | 3 | Movement type (inventory management) |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `MENGE` | QUAN | 13 | Quantity |
| `DMBTR` | CURR | 13 | Amount in local currency |

*... 외 3개 필드*

**데이터 타입:** CHAR(6), NUMC(4), CUKY(2), CLNT(1), UNIT(1)

📄 [전체 테이블 구조 보기](zedt10_ekbe.html)

---

### ZEDT10_EKKO

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

📄 [전체 테이블 구조 보기](zedt10_ekko.html)

---

### ZEDT10_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `NETPR` | CURR | 11 | Net price |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📄 [전체 테이블 구조 보기](zedt10_ekpo.html)

---

### ZEDT10_LFA1

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | Name 1 |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | Vendor account group |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_lfa1.html)

---

### ZEDT10_LFB1

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | Reconciliation Account in General Ledger |
| `ZTERM` | CHAR | 4 | Terms of Payment Key |

**데이터 타입:** CHAR(5), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_lfb1.html)

---

### ZEDT10_LFM1

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zedt10_lfm1.html)

---

### ZEDT10_MAJOR_MST

**Key 필드:** `MANDT, MAJOR_CODE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAJOR_NAME` | CHAR | 40 | ### |
| `TUITION` | CURR | 13 | ## ### |
| `WAERS` | CUKY | 5 | Currency Key |

**데이터 타입:** CHAR(2), CLNT(1), CURR(1), CUKY(1)

📄 [전체 테이블 구조 보기](zedt10_major_mst.html)

---

### ZEDT10_MKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `USNAM` | CHAR | 12 | User Name |
| `XBLNR` | CHAR | 16 | Reference Document Number |

**데이터 타입:** CHAR(4), DATS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zedt10_mkpf.html)

---

### ZEDT10_MODEL

**Key 필드:** `MANDT, ZMODEL`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `TEXT1` | CHAR | 50 | Text |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_model.html)

---

### ZEDT10_MSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BWART` | CHAR | 3 | Movement type (inventory management) |
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | Storage Location |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(4), CLNT(1), CUKY(1), QUAN(1)

📄 [전체 테이블 구조 보기](zedt10_mseg.html)

---

### ZEDT10_MTART

**Key 필드:** `MANDT, MTART`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `TEXT1` | CHAR | 50 | Text |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_mtart.html)

---

### ZEDT10_MWSKZ

**Key 필드:** `MANDT, MWSKZ, SPRAS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 40 | Text, 40 Characters Long |
| `KBETR` | CURR | 11 | Rate (condition amount or percentage) |
| `WAERS` | CUKY | 5 | Currency Key |

**데이터 타입:** CHAR(2), CLNT(1), LANG(1), CURR(1), CUKY(1)

📄 [전체 테이블 구조 보기](zedt10_mwskz.html)

---

### ZEDT10_RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(4), CURR(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_rbkp.html)

---

### ZEDT10_RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), NUMC(3), CURR(3), DATS(2), TIMS(2)

📄 [전체 테이블 구조 보기](zedt10_rseg.html)

---

### ZEDT10_SCHOLAR

**Key 필드:** `MANDT, STUDENT_ID`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `SCHOLAR_TYPE` | CHAR | 1 | ## ## |
| `DISCOUNT_RATE` | DEC | 3 | ## ### |

**데이터 타입:** CHAR(2), CLNT(1), DEC(1)

📄 [전체 테이블 구조 보기](zedt10_scholar.html)

---

### ZEDT10_STUDINFO

**Key 필드:** `MANDT, STUDENT_ID`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAJOR_CODE` | CHAR | 10 | MAJOR CODE |
| `STUDENT_NAME` | CHAR | 20 | ## ## |
| `GENDER` | CHAR | 1 | - |
| `ADMISSION_DATE` | DATS | 8 | ### |
| `REG_TIME` | TIMS | 6 | ###### |

*... 외 1개 필드*

**데이터 타입:** CHAR(4), CLNT(1), DATS(1), TIMS(1), STRG(1)

📄 [전체 테이블 구조 보기](zedt10_studinfo.html)

---

### ZEDT10_TVKO

**Key 필드:** `MANDT, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKOTX` | CHAR | 20 | Description of purchasing organization |
| `BUKRS` | CHAR | 4 | Company Code |

**데이터 타입:** CHAR(3), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_tvko.html)

---

### ZEDT10_ZTERM

**Key 필드:** `MANDT, ZTERM, SPRAS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 40 | Text, 40 Characters Long |

**데이터 타입:** CHAR(2), CLNT(1), LANG(1)

📄 [전체 테이블 구조 보기](zedt10_zterm.html)

---

### ZMARA10

📄 [전체 테이블 구조 보기](zmara10.html)

---

### ZPRO07_010

**Key 필드:** `MANDT`

**데이터 타입:** CLNT(1)

📄 [전체 테이블 구조 보기](zpro07_010.html)

---

### ZPRO11_010

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS11_002

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

📄 [전체 테이블 구조 보기](zpro11_010.html)

---

### ZTCURR10

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

📄 [전체 테이블 구조 보기](ztcurr10.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
