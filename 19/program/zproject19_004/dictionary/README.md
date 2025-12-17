# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZBKPF19](zbkpf19.md) 📄 [HTML](zbkpf19.html) | - | 17 | BUKRS, LIFNR, GJAHR ... (+1) |
| [ZBSEG19](zbseg19.md) 📄 [HTML](zbseg19.html) | - | 22 | BUKRS, LIFNR, GJAHR ... (+1) |
| [ZEDT19_200](zedt19_200.md) 📄 [HTML](zedt19_200.html) | - | 24 | MANDT, ZWERKS, ZLGORT ... (+1) |
| [ZMSEG19](zmseg19.md) 📄 [HTML](zmseg19.html) | - | 27 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP19](zrbkp19.md) 📄 [HTML](zrbkp19.html) | - | 9 | MANDT, BELNR, GJAHR |
| [ZRSEG19](zrseg19.md) 📄 [HTML](zrseg19.html) | - | 22 | MANDT, BELNR, GJAHR ... (+1) |

---

## 테이블 상세 정보

### ZBKPF19

**Key 필드:** `BUKRS, LIFNR, GJAHR, BELNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `ZMWSKZ` | CHAR | 2 | ### |

*... 외 3개 필드*

**데이터 타입:** CHAR(7), DATS(3), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zbkpf19.md) | 📄 [HTML로 보기](zbkpf19.html)

---

### ZBSEG19

**Key 필드:** `BUKRS, LIFNR, GJAHR, BELNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(3), NUMC(1), CUKY(1), CURR(1)

📋 [마크다운으로 보기](zbseg19.md) | 📄 [HTML로 보기](zbseg19.html)

---

### ZEDT19_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS19_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `MTART` | CHAR | 4 | Material Type |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt19_200.md) | 📄 [HTML로 보기](zedt19_200.html)

---

### ZMSEG19

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `ZWERKS` | CHAR | 4 | - |
| `ZLGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zmseg19.md) | 📄 [HTML로 보기](zmseg19.html)

---

### ZRBKP19

**Key 필드:** `MANDT, BELNR, GJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `BUKRS` | CHAR | 4 | Company Code |
| `WAERS` | CUKY | 5 | Currency Key |
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |

*... 외 1개 필드*

**데이터 타입:** CHAR(4), DATS(2), CLNT(1), NUMC(1), CUKY(1)

📋 [마크다운으로 보기](zrbkp19.md) | 📄 [HTML로 보기](zrbkp19.html)

---

### ZRSEG19

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | Company Code |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `DMBTR` | CURR | 13 | Amount in local currency |
| `MWSTS` | CURR | 13 | Tax Amount in Local Currency |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), NUMC(2), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zrseg19.md) | 📄 [HTML로 보기](zrseg19.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
