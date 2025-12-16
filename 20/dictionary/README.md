# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS20_001](zeds20_001.html) | - | 9 | - |
| [ZEDS20_002](zeds20_002.html) | - | 6 | - |
| [ZEDT20_000](zedt20_000.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT20_001](zedt20_001.html) | - | 17 | MANDT, ZCODE, ZPERNR |
| [ZEDT20_002](zedt20_002.html) | - | 22 | MANDT, ZCODE, ZPERNR |
| [ZEDT20_003](zedt20_003.html) | - | 3 | MANDT, ZMGUBUN |
| [ZEDT20_004](zedt20_004.html) | - | 29 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT20_100](zedt20_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT20_101](zedt20_101.html) | - | 39 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT20_102](zedt20_102.html) | - | 31 | MANDT, ZPERNR, ZDEPCODE ... (+2) |
| [ZEDT20_103](zedt20_103.html) | - | 14 | MANDT, ZPERNR |
| [ZEDT20_104](zedt20_104.html) | - | 25 | MANDT, ZPERNR, ZDEPCODE ... (+3) |
| [ZEDT20_105](zedt20_105.html) | - | 22 | MANDT, ZPERNR, ZYEAR |
| [ZEDT20_106](zedt20_106.html) | - | 20 | MANDT, ZPERNR, ZYEAR ... (+2) |
| [ZEDT20_200](zedt20_200.html) | - | 30 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZEDT20_BKPF](zedt20_bkpf.html) | - | 9 | MANDT, BUKRS, BELNR ... (+1) |
| [ZEDT20_BSEG](zedt20_bseg.html) | - | 17 | MANDT, BUKRS, BELNR ... (+2) |
| [ZEDT20_BSIK](zedt20_bsik.html) | - | 19 | MANDT, BUKRS, LIFNR ... (+2) |
| [ZEDT20_EKKO](zedt20_ekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT20_EKPO](zedt20_ekpo.html) | - | 11 | MANDT, EBELN, EBELP |
| [ZEDT20_LFA1](zedt20_lfa1.html) | - | 14 | MANDT, LIFNR |
| [ZEDT20_LFB1](zedt20_lfb1.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZEDT20_LFM1](zedt20_lfm1.html) | - | 14 | MANDT, LIFNR |
| [ZEDT20_MARA](zedt20_mara.html) | - | 7 | MANDT, MATNR |
| [ZEDT20_MARD](zedt20_mard.html) | - | 5 | MANDT, MATNR, WERKS ... (+1) |
| [ZEDT20_MKPF](zedt20_mkpf.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZEDT20_MSEG](zedt20_mseg.html) | - | 22 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT20_RBKP](zedt20_rbkp.html) | - | 9 | MANDT, BELNR, GJAHR |
| [ZEDT20_RSEG](zedt20_rseg.html) | - | 22 | MANDT, BELNR, GJAHR ... (+1) |
| [ZEDT20_T001](zedt20_t001.html) | - | 3 | MANDT, BUKRS |
| [ZTCURR20](ztcurr20.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS20_001

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

📄 [전체 테이블 구조 보기](zeds20_001.html)

---

### ZEDS20_002

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

📄 [전체 테이블 구조 보기](zeds20_002.html)

---

### ZEDT20_000

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS20_002

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

📄 [전체 테이블 구조 보기](zedt20_000.html)

---

### ZEDT20_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS20_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |
| `ZMNAME` | CHAR | 20 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt20_001.html)

---

### ZEDT20_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS20_002

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

📄 [전체 테이블 구조 보기](zedt20_002.html)

---

### ZEDT20_003

**Key 필드:** `MANDT, ZMGUBUN`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMGNAME` | CHAR | 20 | ##### |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt20_003.html)

---

### ZEDT20_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, SZEM, ZEXAM`

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

📄 [전체 테이블 구조 보기](zedt20_004.html)

---

### ZEDT20_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS20_002

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

📄 [전체 테이블 구조 보기](zedt20_100.html)

---

### ZEDT20_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS20_002

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

📄 [전체 테이블 구조 보기](zedt20_101.html)

---

### ZEDT20_102

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, DATBI, DATAB`

**INCLUDE 구조:** ZEDS20_002

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

📄 [전체 테이블 구조 보기](zedt20_102.html)

---

### ZEDT20_103

**Key 필드:** `MANDT, ZPERNR`

**INCLUDE 구조:** ZEDS20_002

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

📄 [전체 테이블 구조 보기](zedt20_103.html)

---

### ZEDT20_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS20_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Last Changed By |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zedt20_104.html)

---

### ZEDT20_105

**Key 필드:** `MANDT, ZPERNR, ZYEAR`

**INCLUDE 구조:** ZEDS20_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMON01` | CURR | 13 | - |
| `ZMON02` | CURR | 13 | - |
| `ZMON03` | CURR | 13 | - |
| `ZMON04` | CURR | 13 | - |
| `ZMON05` | CURR | 13 | - |

*... 외 5개 필드*

**데이터 타입:** CURR(12), CHAR(3), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt20_105.html)

---

### ZEDT20_106

**Key 필드:** `MANDT, ZPERNR, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS20_002

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

📄 [전체 테이블 구조 보기](zedt20_106.html)

---

### ZEDT20_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS20_002

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

📄 [전체 테이블 구조 보기](zedt20_200.html)

---

### ZEDT20_BKPF

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

📄 [전체 테이블 구조 보기](zedt20_bkpf.html)

---

### ZEDT20_BSEG

**Key 필드:** `MANDT, BUKRS, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `HKONT` | CHAR | 10 | General Ledger Account |
| `SHZKG` | CHAR | 1 | Debit/Credit Indicator |
| `DMBTR` | CURR | 13 | Amount in local currency |
| `MENGE` | QUAN | 15 | - |
| `MEINS` | UNIT | 3 | Base Unit of Measure |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), NUMC(3), CLNT(1), CURR(1), QUAN(1)

📄 [전체 테이블 구조 보기](zedt20_bseg.html)

---

### ZEDT20_BSIK

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

📄 [전체 테이블 구조 보기](zedt20_bsik.html)

---

### ZEDT20_EKKO

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

📄 [전체 테이블 구조 보기](zedt20_ekko.html)

---

### ZEDT20_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 15 | - |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | CURR | 11 | Net Price in Purchasing Document (in Document Currency) |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📄 [전체 테이블 구조 보기](zedt20_ekpo.html)

---

### ZEDT20_LFA1

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

📄 [전체 테이블 구조 보기](zedt20_lfa1.html)

---

### ZEDT20_LFB1

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📄 [전체 테이블 구조 보기](zedt20_lfb1.html)

---

### ZEDT20_LFM1

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zedt20_lfm1.html)

---

### ZEDT20_MARA

**Key 필드:** `MANDT, MATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAKTX` | CHAR | 40 | Material Description |
| `MTART` | CHAR | 4 | Material Type |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | CURR | 11 | Net Price in Purchasing Document (in Document Currency) |
| `WAERS` | CUKY | 5 | Currency Key |

**데이터 타입:** CHAR(3), CLNT(1), UNIT(1), CURR(1), CUKY(1)

📄 [전체 테이블 구조 보기](zedt20_mara.html)

---

### ZEDT20_MARD

**Key 필드:** `MANDT, MATNR, WERKS, LGORT`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZNOTE` | CHAR | 100 | Text (100 characters) |

**데이터 타입:** CHAR(4), CLNT(1)

📄 [전체 테이블 구조 보기](zedt20_mard.html)

---

### ZEDT20_MKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zedt20_mkpf.html)

---

### ZEDT20_MSEG

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

**데이터 타입:** CHAR(10), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📄 [전체 테이블 구조 보기](zedt20_mseg.html)

---

### ZEDT20_RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |

*... 외 1개 필드*

**데이터 타입:** CHAR(4), DATS(2), CLNT(1), NUMC(1), CUKY(1)

📄 [전체 테이블 구조 보기](zedt20_rbkp.html)

---

### ZEDT20_RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `MENGE` | QUAN | 15 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), NUMC(3), CURR(2), CLNT(1), QUAN(1)

📄 [전체 테이블 구조 보기](zedt20_rseg.html)

---

### ZEDT20_T001

**Key 필드:** `MANDT, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LAND1` | CHAR | 3 | Country Key |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt20_t001.html)

---

### ZTCURR20

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `UNAME` | CHAR | 12 | User Name |
| `CRDATE` | DATS | 8 | Created On |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📄 [전체 테이블 구조 보기](ztcurr20.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
