# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT19_0001](zedt19_0001.md) 📄 [HTML](zedt19_0001.html) | - | 18 | ZCODE, ZPERNR |
| [ZEDT19_002](zedt19_002.md) 📄 [HTML](zedt19_002.html) | - | 22 | MANDT, ZCODE, ZPERNR |
| [ZEDT19_004](zedt19_004.md) 📄 [HTML](zedt19_004.html) | - | 34 | MANDT, ZCODE, ZPERNR ... (+3) |

---

## 테이블 상세 정보

### ZEDT19_0001

**Key 필드:** `ZCODE, ZPERNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | ZKNAME19 |
| `ZENAME` | CHAR | 20 | ZENAME19 |
| `ZGENDER` | CHAR | 1 | ZGENDER19 |
| `ZTEL` | CHAR | 16 | ZTEL19 |
| `ZSUM` | CURR | 13 | - |

*... 외 3개 필드*

**데이터 타입:** CHAR(9), CURR(1)

📋 [마크다운으로 보기](zedt19_0001.md) | 📄 [HTML로 보기](zedt19_0001.html)

---

### ZEDT19_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS19_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWARES` | CUKY | 5 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt19_002.md) | 📄 [HTML로 보기](zedt19_002.html)

---

### ZEDT19_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWARES` | CUKY | 5 | - |
| `ZGRADE` | CHAR | 1 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(9), CLNT(1), CURR(1), CUKY(1), INT8(1)

📋 [마크다운으로 보기](zedt19_004.md) | 📄 [HTML로 보기](zedt19_004.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
