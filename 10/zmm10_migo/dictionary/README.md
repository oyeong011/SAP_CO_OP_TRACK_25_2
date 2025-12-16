# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT10_EKBE](zedt10_ekbe.html) | - | 40 | MANDT, EBELN, EBELP ... (+5) |
| [ZEDT10_EKKO](zedt10_ekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT10_EKPO](zedt10_ekpo.html) | - | 15 | MANDT, EBELN, EBELP |
| [ZEDT10_MKPF](zedt10_mkpf.html) | - | 8 | MANDT, MBLNR, MJAHR |
| [ZEDT10_MSEG](zedt10_mseg.html) | - | 21 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZEDT10_T003](zedt10_t003.html) | - | 7 | MANDT, BLART |

---

## 테이블 상세 정보

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

### ZEDT10_T003

**Key 필드:** `MANDT, BLART`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LTEXT` | CHAR | 40 | Long Text |
| `NUMKR` | CHAR | 2 | Number range |
| `XSTORN` | CHAR | 1 | Indicates Whether Invoice Has Been Cancelled |

**데이터 타입:** CHAR(4), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_t003.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
