# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT10_1004](zedt10_1004.md) 📄 [HTML](zedt10_1004.html) | - | 34 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT10_T001](zedt10_t001.md) 📄 [HTML](zedt10_t001.html) | - | 4 | MANDT, BUKRS |
| [ZEDT10_T001L](zedt10_t001l.md) 📄 [HTML](zedt10_t001l.html) | - | 4 | MANDT, WERKS, LGORT |

---

## 테이블 상세 정보

### ZEDT10_1004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 10 | - |
| `ZMNAME` | CHAR | 40 | ### |
| `ZSUM` | CURR | 12 | - |
| `ZWAERS` | CUKY | 5 | Currency Key |
| `ZGRADE` | CHAR | 1 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(7), INT1(2), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt10_1004.md) | 📄 [HTML로 보기](zedt10_1004.html)

---

### ZEDT10_T001

**Key 필드:** `MANDT, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUTXT` | CHAR | 25 | Name of Company Code or Company |
| `LAND1` | CHAR | 3 | Country Key |

**데이터 타입:** CHAR(3), CLNT(1)

📋 [마크다운으로 보기](zedt10_t001.md) | 📄 [HTML로 보기](zedt10_t001.html)

---

### ZEDT10_T001L

**Key 필드:** `MANDT, WERKS, LGORT`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LGOBE` | CHAR | 16 | Description of Storage Location |

**데이터 타입:** CHAR(3), CLNT(1)

📋 [마크다운으로 보기](zedt10_t001l.md) | 📄 [HTML로 보기](zedt10_t001l.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
