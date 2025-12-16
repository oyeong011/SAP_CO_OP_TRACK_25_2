# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZMKPF19](zmkpf19.md) 📄 [HTML](zmkpf19.html) | - | 6 | MANDT, MBLNR, MJAHR |
| [ZMSEG19](zmseg19.md) 📄 [HTML](zmseg19.html) | - | 27 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZPDT19_002](zpdt19_002.md) 📄 [HTML](zpdt19_002.html) | - | 31 | LIFNR, BUKRS |
| [ZPDT19_005](zpdt19_005.md) 📄 [HTML](zpdt19_005.html) | - | 18 | MANDT, EBELN, EBELP |

---

## 테이블 상세 정보

### ZMKPF19

**Key 필드:** `MANDT, MBLNR, MJAHR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |

**데이터 타입:** CHAR(2), DATS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zmkpf19.md) | 📄 [HTML로 보기](zmkpf19.html)

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

### ZPDT19_002

**Key 필드:** `LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `ZAKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5)

📋 [마크다운으로 보기](zpdt19_002.md) | 📄 [HTML로 보기](zpdt19_002.html)

---

### ZPDT19_005

**Key 필드:** `MANDT, EBELN, EBELP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNR` | CHAR | 10 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | Purchase Order Quantity |
| `MEINS` | UNIT | 3 | Purchase Order Unit of Measure |
| `PRDAT` | DATS | 8 | Date of last forecast |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), CLNT(1), NUMC(1), QUAN(1), UNIT(1)

📋 [마크다운으로 보기](zpdt19_005.md) | 📄 [HTML로 보기](zpdt19_005.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
