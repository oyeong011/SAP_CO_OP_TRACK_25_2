# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT25_ZEKKO](zedt25_zekko.md) 📄 [HTML](zedt25_zekko.html) | - | 8 | MANDT, EBELN |
| [ZEDT25_ZEKPO](zedt25_zekpo.md) 📄 [HTML](zedt25_zekpo.html) | - | 16 | MANDT, EBELN, EBELP |
| [ZEDT25_ZMKPF](zedt25_zmkpf.md) 📄 [HTML](zedt25_zmkpf.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZEDT25_ZMSEG](zedt25_zmseg.md) 📄 [HTML](zedt25_zmseg.html) | - | 24 | MANDT, MBLNR, MJAHR ... (+1) |

---

## 테이블 상세 정보

### ZEDT25_ZEKKO

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

📋 [마크다운으로 보기](zedt25_zekko.md) | 📄 [HTML로 보기](zedt25_zekko.html)

---

### ZEDT25_ZEKPO

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `PRDAT` | DATS | 8 | Date of last forecast |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), UNIT(2), CLNT(1), NUMC(1), QUAN(1)

📋 [마크다운으로 보기](zedt25_zekpo.md) | 📄 [HTML로 보기](zedt25_zekpo.html)

---

### ZEDT25_ZMKPF

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt25_zmkpf.md) | 📄 [HTML로 보기](zedt25_zmkpf.html)

---

### ZEDT25_ZMSEG

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `ZWERKS` | CHAR | 4 | Plant |
| `ZLGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Vendor's account number |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📋 [마크다운으로 보기](zedt25_zmseg.md) | 📄 [HTML로 보기](zedt25_zmseg.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
