# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS02_001](zeds02_001.html) | - | 14 | - |
| [ZEDS02_002](zeds02_002.html) | - | 6 | - |
| [ZEDT022_001](zedt022_001.html) | - | 14 | MANDT, ZCODE, ZPERNR |
| [ZEDT022_002](zedt022_002.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT022_100](zedt022_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT022_101](zedt022_101.html) | - | 41 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT02_AKONT](zedt02_akont.html) | - | 13 | MANDT, AKONT |
| [ZEDT02_KTOKK](zedt02_ktokk.html) | - | 9 | MANDT, KTOKK |
| [ZEDT02_LGORT](zedt02_lgort.html) | - | 8 | MANDT, LGORT |
| [ZEDT02_MTART](zedt02_mtart.html) | - | 9 | MANDT, MTART |
| [ZEDT02_MWSKZ](zedt02_mwskz.html) | - | 8 | MANDT, MWSKZ |
| [ZEDT02_WERKS](zedt02_werks.html) | - | 7 | MANDT, WERKS |
| [ZEDT02_ZTERM](zedt02_zterm.html) | - | 15 | MANDT, ZTERM |
| [ZEKKO_02](zekko_02.html) | - | 8 | MANDT, EBELN |
| [ZEKPO_02](zekpo_02.html) | - | 21 | MANDT, EBELN, EBELP |
| [ZLFA1_02](zlfa1_02.html) | - | 14 | MANDT, LIFNR |
| [ZLFB1_02](zlfb1_02.html) | - | 30 | MANDT, LIFNR, BUKRS |
| [ZLFM1_02](zlfm1_02.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZMARA_02](zmara_02.html) | - | 32 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZMKPF_02](zmkpf_02.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG_02](zmseg_02.html) | - | 33 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZPDT19_002](zpdt19_002.html) | - | 31 | LIFNR, BUKRS |
| [ZPRO07_002](zpro07_002.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZPRO11_002](zpro11_002.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZRBKP_02](zrbkp_02.html) | - | 21 | MANDT, BELNR, GJAHR |
| [ZRSEG_02](zrseg_02.html) | - | 23 | MANDT, BELNR, GJAHR ... (+1) |
| [ZTCURR02](ztcurr02.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS02_001

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

📄 [전체 테이블 구조 보기](zeds02_001.html)

---

### ZEDS02_002

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

📄 [전체 테이블 구조 보기](zeds02_002.html)

---

### ZEDT022_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS22_002

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

📄 [전체 테이블 구조 보기](zedt022_001.html)

---

### ZEDT022_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS22_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | - |
| `ZFLAG` | CHAR | 1 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📄 [전체 테이블 구조 보기](zedt022_002.html)

---

### ZEDT022_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS22_002

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

📄 [전체 테이블 구조 보기](zedt022_100.html)

---

### ZEDT022_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS22_002

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

📄 [전체 테이블 구조 보기](zedt022_101.html)

---

### ZEDT02_AKONT

**Key 필드:** `MANDT, AKONT`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 25 | Name of the controlling area |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt02_akont.html)

---

### ZEDT02_KTOKK

**Key 필드:** `MANDT, KTOKK`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 25 | Name of the controlling area |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt02_ktokk.html)

---

### ZEDT02_LGORT

**Key 필드:** `MANDT, LGORT`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 25 | Name of the controlling area |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt02_lgort.html)

---

### ZEDT02_MTART

**Key 필드:** `MANDT, MTART`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 25 | Name of the controlling area |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt02_mtart.html)

---

### ZEDT02_MWSKZ

**Key 필드:** `MANDT, MWSKZ`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 25 | Name of the controlling area |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt02_mwskz.html)

---

### ZEDT02_WERKS

**Key 필드:** `MANDT, WERKS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 25 | Name of the controlling area |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt02_werks.html)

---

### ZEDT02_ZTERM

**Key 필드:** `MANDT, ZTERM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BEZEI` | CHAR | 25 | Name of the controlling area |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt02_zterm.html)

---

### ZEKKO_02

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

📄 [전체 테이블 구조 보기](zekko_02.html)

---

### ZEKPO_02

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | UNIT | 3 | Order Price Unit (Purchasing) |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📄 [전체 테이블 구조 보기](zekpo_02.html)

---

### ZLFA1_02

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

📄 [전체 테이블 구조 보기](zlfa1_02.html)

---

### ZLFB1_02

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Flag for Master Record (Company Code Level) |
| `AKONT` | CHAR | 10 | Reconciliation Account in General Ledger |
| `ZTERM` | CHAR | 4 | Terms of Payment Key |

**데이터 타입:** CHAR(5), CLNT(1)

📄 [전체 테이블 구조 보기](zlfb1_02.html)

---

### ZLFM1_02

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Delete flag for vendor at purchasing level |
| `WAERS` | CUKY | 5 | Purchase order currency |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zlfm1_02.html)

---

### ZMARA_02

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS02_002

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

📄 [전체 테이블 구조 보기](zmara_02.html)

---

### ZMKPF_02

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zmkpf_02.html)

---

### ZMSEG_02

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 4 | ### |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), NUMC(6), CLNT(1), CUKY(1), QUAN(1)

📄 [전체 테이블 구조 보기](zmseg_02.html)

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

📄 [전체 테이블 구조 보기](zpdt19_002.html)

---

### ZPRO07_002

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | Reconciliation Account in General Ledger |
| `ZTERM` | CHAR | 4 | Terms of Payment Key |

**데이터 타입:** CHAR(5), CLNT(1)

📄 [전체 테이블 구조 보기](zpro07_002.html)

---

### ZPRO11_002

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📄 [전체 테이블 구조 보기](zpro11_002.html)

---

### ZRBKP_02

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |
| `RMWWR` | CURR | 13 | Gross invoice amount in document currency |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(2), DATS(2), CURR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zrbkp_02.html)

---

### ZRSEG_02

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `WRBTR` | CURR | 13 | Amount in document currency |
| `WMWST` | CURR | 13 | Tax Amount in Document Currency |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CURR(2), CLNT(1), QUAN(1)

📄 [전체 테이블 구조 보기](zrseg_02.html)

---

### ZTCURR02

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `AENAME` | CHAR | 12 | Name of person who changed object |
| `AEDATE` | DATS | 8 | Date of Last Change |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📄 [전체 테이블 구조 보기](ztcurr02.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
