# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT06_001](zedt06_001.md) 📄 [HTML](zedt06_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT06_002](zedt06_002.md) 📄 [HTML](zedt06_002.html) | - | 24 | MANDT, ZCODE, ZPERNR |
| [ZEDT06_004](zedt06_004.md) 📄 [HTML](zedt06_004.html) | - | 40 | MANDT, ZCODE, ZPERNR ... (+3) |

---

## 테이블 상세 정보

### ZEDT06_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt06_001.md) | 📄 [HTML로 보기](zedt06_001.html)

---

### ZEDT06_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt06_002.md) | 📄 [HTML로 보기](zedt06_002.html)

---

### ZEDT06_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | ### |
| `ZGRADE` | CHAR | 1 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), CURR(2), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt06_004.md) | 📄 [HTML로 보기](zedt06_004.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
