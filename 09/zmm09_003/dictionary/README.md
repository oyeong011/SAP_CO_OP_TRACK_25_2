# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZBKPF09](zbkpf09.html) | #### ## | 12 | MANDT, BUKRS, BELNR ... (+1) |
| [ZBSEG09](zbseg09.html) | ## ## #### | 30 | MANDT, BUKRS, BELNR ... (+2) |
| [ZEKKO_09](zekko_09.html) | - | 11 | MANDT, EBELN |
| [ZEKPO_09](zekpo_09.html) | - | 36 | MANDT, EBELN, EBELP |
| [ZMARA09](zmara09.html) | - | 31 | MANDT, WERKS, LGORT ... (+1) |
| [ZMAST09](zmast09.html) | BOM# ## ## | 8 | MANDT, MATNR, WERKS ... (+1) |
| [ZMKPF09](zmkpf09.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG09](zmseg09.html) | - | 53 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZSKA109](zska109.html) | - | 10 | MANDT, SAKNR |
| [ZSTPO09](zstpo09.html) | BOM ## | 6 | MANDT, STLNR, STLKN |

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

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
