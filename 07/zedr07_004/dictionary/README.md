# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS07_001](zeds07_001.md) 📄 [HTML](zeds07_001.html) | - | 14 | - |
| [ZEDS07_002](zeds07_002.md) 📄 [HTML](zeds07_002.html) | - | 6 | - |
| [ZEDT07_004](zedt07_004.md) 📄 [HTML](zedt07_004.html) | - | 34 | MANDT, ZCODE, ZPERNR ... (+3) |

---

## 테이블 상세 정보

### ZEDS07_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPERNR` | CHAR | 10 | - |
| `ZCODE` | CHAR | 10 | - |
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds07_001.md) | 📄 [HTML로 보기](zeds07_001.html)

---

### ZEDS07_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |
| `AEDATE` | DATS | 8 | Date of Last Change |

*... 외 1개 필드*

**데이터 타입:** CHAR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds07_002.md) | 📄 [HTML로 보기](zeds07_002.html)

---

### ZEDT07_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 10 | - |
| `ZMNAME` | CHAR | 10 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWARS` | CUKY | 5 | - |
| `ZGRADE` | CHAR | 10 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(10), CLNT(1), CURR(1), CUKY(1)

📋 [마크다운으로 보기](zedt07_004.md) | 📄 [HTML로 보기](zedt07_004.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
