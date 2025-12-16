# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZBKPF09](zbkpf09.html) | #### ## | 12 | MANDT, BUKRS, BELNR ... (+1) |
| [ZEKKO_09](zekko_09.html) | - | 11 | MANDT, EBELN |
| [ZEKPO_09](zekpo_09.html) | - | 36 | MANDT, EBELN, EBELP |
| [ZMARA09](zmara09.html) | - | 31 | MANDT, WERKS, LGORT ... (+1) |
| [ZMSEG09](zmseg09.html) | - | 53 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP09](zrbkp09.html) | ## ## | 45 | MANDT, BELNR, GJAHR |
| [ZRSEG09](zrseg09.html) | ## ### | 30 | MANDT, BELNR, GJAHR ... (+1) |
| [ZRSEG24](zrseg24.html) | - | 23 | MANDT, BELNR, GJAHR ... (+1) |

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

### ZRSEG24

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 10 | - |
| `TXZ01` | CHAR | 20 | ### |
| `WERKS` | CHAR | 4 | Plant |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), NUMC(3), CURR(2), UNIT(2), CLNT(1)

📄 [전체 테이블 구조 보기](zrseg24.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
