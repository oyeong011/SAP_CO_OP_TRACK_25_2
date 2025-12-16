# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT25_ZRBKP](zedt25_zrbkp.html) | - | 48 | MANDT, BELNR, GJAHR |
| [ZEDT25_ZRSEG](zedt25_zrseg.html) | - | 34 | MANDT, BELNR, GJAHR ... (+1) |
| [ZEDT25_ZTERM](zedt25_zterm.html) | - | 14 | MANDT, ZTERM |

---

## 테이블 상세 정보

### ZEDT25_ZRBKP

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

**데이터 타입:** CHAR(12), NUMC(2), DATS(2), CURR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt25_zrbkp.html)

---

### ZEDT25_ZRSEG

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | Purchasing Document Number |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 10 | - |
| `BUKRS` | CHAR | 4 | Company Code |
| `TXZ01` | CHAR | 20 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), NUMC(5), CURR(2), QUAN(2), UNIT(2)

📄 [전체 테이블 구조 보기](zedt25_zrseg.html)

---

### ZEDT25_ZTERM

**Key 필드:** `MANDT, ZTERM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `TEXT` | CHAR | 40 | Character field of length 40 |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt25_zterm.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
