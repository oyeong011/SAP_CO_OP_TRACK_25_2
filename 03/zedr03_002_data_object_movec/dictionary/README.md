# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS03_001](zeds03_001.md) 📄 [HTML](zeds03_001.html) | - | 9 | - |
| [ZEDS03_002](zeds03_002.md) 📄 [HTML](zeds03_002.html) | - | 6 | - |
| [ZEDT03_001](zedt03_001.md) 📄 [HTML](zedt03_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT03_002](zedt03_002.md) 📄 [HTML](zedt03_002.html) | - | 25 | MANDT, ZCODE, ZPERNR |
| [ZEDT03_BSIK](zedt03_bsik.md) 📄 [HTML](zedt03_bsik.html) | - | 21 | MANDT, BUKRS, LIFNR ... (+2) |
| [ZEDT03_EKKO](zedt03_ekko.md) 📄 [HTML](zedt03_ekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT03_EKPO](zedt03_ekpo.md) 📄 [HTML](zedt03_ekpo.html) | - | 11 | MANDT, EBELN, EBELP |
| [ZEDT03_LFA1](zedt03_lfa1.md) 📄 [HTML](zedt03_lfa1.html) | - | 15 | MANDT, LIFNR |
| [ZEDT03_LFB1](zedt03_lfb1.md) 📄 [HTML](zedt03_lfb1.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZEDT03_LFM1](zedt03_lfm1.md) 📄 [HTML](zedt03_lfm1.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZEDT03_MKPF](zedt03_mkpf.md) 📄 [HTML](zedt03_mkpf.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZEDT03_MSEG](zedt03_mseg.md) 📄 [HTML](zedt03_mseg.html) | - | 23 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT03_RBKP](zedt03_rbkp.md) 📄 [HTML](zedt03_rbkp.html) | - | 13 | MANDT, BELNR, GJAHR |
| [ZEDT03_RSEG](zedt03_rseg.md) 📄 [HTML](zedt03_rseg.html) | - | 15 | MANDT, BELNR, GJAHR ... (+1) |
| [ZPDT19_003](zpdt19_003.md) 📄 [HTML](zpdt19_003.html) | - | 13 | LIFNR, EKORG |
| [ZPRO07_003](zpro07_003.md) 📄 [HTML](zpro07_003.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZPRO11_003](zpro11_003.md) 📄 [HTML](zpro11_003.html) | - | 14 | MANDT, LIFNR, EKORG |
| [ZTCURR03](ztcurr03.md) 📄 [HTML](ztcurr03.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDS03_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MANDT` | CLNT | 3 | Client |
| `ZCODE` | CHAR | 10 | - |
| `ZPERNR` | CHAR | 10 | ######## |
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(6), CLNT(1)

📋 [마크다운으로 보기](zeds03_001.md) | 📄 [HTML로 보기](zeds03_001.html)

---

### ZEDS03_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Field of type DATS |
| `CRZEIT` | TIMS | 6 | Field of type TIMS |
| `AENAME` | CHAR | 12 | Last Changed By |
| `AEDATE` | DATS | 8 | Date of Last Change |

*... 외 1개 필드*

**데이터 타입:** CHAR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds03_002.md) | 📄 [HTML로 보기](zeds03_002.html)

---

### ZEDT03_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS03_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | #### #### |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt03_001.md) | 📄 [HTML로 보기](zedt03_001.html)

---

### ZEDT03_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS03_002

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

📋 [마크다운으로 보기](zedt03_002.md) | 📄 [HTML로 보기](zedt03_002.html)

---

### ZEDT03_BSIK

**Key 필드:** `MANDT, BUKRS, LIFNR, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), DATS(4), CURR(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt03_bsik.md) | 📄 [HTML로 보기](zedt03_bsik.html)

---

### ZEDT03_EKKO

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

📋 [마크다운으로 보기](zedt03_ekko.md) | 📄 [HTML로 보기](zedt03_ekko.html)

---

### ZEDT03_EKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Purchase Order Unit of Measure |
| `BPRME` | CURR | 11 | Net price |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zedt03_ekpo.md) | 📄 [HTML로 보기](zedt03_ekpo.html)

---

### ZEDT03_LFA1

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

📋 [마크다운으로 보기](zedt03_lfa1.md) | 📄 [HTML로 보기](zedt03_lfa1.html)

---

### ZEDT03_LFB1

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zedt03_lfb1.md) | 📄 [HTML로 보기](zedt03_lfb1.html)

---

### ZEDT03_LFM1

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt03_lfm1.md) | 📄 [HTML로 보기](zedt03_lfm1.html)

---

### ZEDT03_MKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt03_mkpf.md) | 📄 [HTML로 보기](zedt03_mkpf.html)

---

### ZEDT03_MSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | Storage Location |
| `LIFNR` | CHAR | 10 | Vendor's account number |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(4), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zedt03_mseg.md) | 📄 [HTML로 보기](zedt03_mseg.html)

---

### ZEDT03_RBKP

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(5), NUMC(2), DATS(2), CURR(2), CLNT(1)

📋 [마크다운으로 보기](zedt03_rbkp.md) | 📄 [HTML로 보기](zedt03_rbkp.html)

---

### ZEDT03_RSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | Material Number |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), NUMC(3), CLNT(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zedt03_rseg.md) | 📄 [HTML로 보기](zedt03_rseg.html)

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

### ZPRO07_003

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zpro07_003.md) | 📄 [HTML로 보기](zpro07_003.html)

---

### ZPRO11_003

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zpro11_003.md) | 📄 [HTML로 보기](zpro11_003.html)

---

### ZTCURR03

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

📋 [마크다운으로 보기](ztcurr03.md) | 📄 [HTML로 보기](ztcurr03.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
