# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT06_BKPF](zedt06_bkpf.html) | - | 23 | MANDT, BELNR, GJAHR ... (+1) |
| [ZEDT06_BSEG](zedt06_bseg.html) | - | 24 | MANDT, BELNR, GJAHR ... (+1) |
| [ZEDT06_EKKO](zedt06_ekko.html) | - | 8 | MANDT, EBELN, BUKRS ... (+1) |
| [ZEDT06_EKPO](zedt06_ekpo.html) | - | 11 | MANDT, EBELN, EBELP |
| [ZEDT06_LFM1](zedt06_lfm1.html) | - | 21 | MANDT, LIFNR |
| [ZEDT06_MKPF](zedt06_mkpf.html) | - | 14 | MANDT, MBLNR |
| [ZEDT06_MSEG](zedt06_mseg.html) | - | 32 | MANDT, MBLNR, MJAHR ... (+1) |

---

## 테이블 상세 정보

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

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
