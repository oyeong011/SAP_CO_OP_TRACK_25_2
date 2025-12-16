# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_14](zekko_14.html) | - | 15 | MANDT, EBELN |
| [ZEKPO_14](zekpo_14.html) | - | 20 | MANDT, EBELN, EBELP |
| [ZLFA1_14](zlfa1_14.html) | - | 21 | MANDT, LIFNR |
| [ZLFB1_14](zlfb1_14.html) | - | 13 | MANDT, LIFNR, BUKRS |
| [ZMKPF_14](zmkpf_14.html) | - | 15 | MANDT, MBLNR, MJAHR |
| [ZMSEG_14](zmseg_14.html) | - | 27 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP_14](zrbkp_14.html) | - | 39 | MANDT, BELNR, GJAHR |
| [ZRSEG_14](zrseg_14.html) | - | 24 | MANDT, BELNR, GJAHR ... (+1) |

---

## 테이블 상세 정보

### ZEKKO_14

**Key 필드:** `MANDT, EBELN`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | - |
| `EKORG` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | ##### |
| `BEDAT` | DATS | 8 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zekko_14.html)

---

### ZEKPO_14

**Key 필드:** `MANDT, EBELN, EBELP`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | - |
| `MEINS` | UNIT | 3 | ##1 |
| `BPRME` | UNIT | 3 | ##2 |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(3), UNIT(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zekpo_14.html)

---

### ZLFA1_14

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | - |
| `LAND1` | CHAR | 3 | ### |
| `KTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | - |
| `STCD2` | CHAR | 11 | ##### |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zlfa1_14.html)

---

### ZLFB1_14

**Key 필드:** `MANDT, LIFNR, BUKRS`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | ##### |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zlfb1_14.html)

---

### ZMKPF_14

**Key 필드:** `MANDT, MBLNR, MJAHR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `EBELN` | CHAR | 10 | Purchase order number |
| `WERKS` | CHAR | 4 | Plant |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zmkpf_14.html)

---

### ZMSEG_14

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Vendor's account number |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(12), NUMC(3), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zmseg_14.html)

---

### ZRBKP_14

**Key 필드:** `MANDT, BELNR, GJAHR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

*... 외 5개 필드*

**데이터 타입:** CHAR(14), DATS(4), NUMC(2), CURR(2), TIMS(2)

📄 [전체 테이블 구조 보기](zrbkp_14.html)

---

### ZRSEG_14

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | ### |
| `WERKS` | CHAR | 4 | Plant |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), UNIT(2), CURR(2), DATS(2)

📄 [전체 테이블 구조 보기](zrseg_14.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
