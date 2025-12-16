# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS21_001](zeds21_001.md) 📄 [HTML](zeds21_001.html) | - | 9 | - |
| [ZEDS21_002](zeds21_002.md) 📄 [HTML](zeds21_002.html) | - | 6 | - |
| [ZEDT21_100](zedt21_100.md) 📄 [HTML](zedt21_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT21_101](zedt21_101.md) 📄 [HTML](zedt21_101.html) | - | 38 | MANDT, ZORDNO21, ZIDCODE21 ... (+2) |

---

## 테이블 상세 정보

### ZEDS21_001

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MANDT` | CLNT | 3 | Client |
| `ZCODE21` | CHAR | 10 | - |
| `ZPERNR21` | CHAR | 10 | - |
| `ZKNAME21` | CHAR | 10 | - |
| `ZENAME21` | CHAR | 10 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(6), CLNT(1)

📋 [마크다운으로 보기](zeds21_001.md) | 📄 [HTML로 보기](zeds21_001.html)

---

### ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Created On |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Last Changed By |
| `AEDATE` | DATS | 8 | Date of Last Change |

*... 외 1개 필드*

**데이터 타입:** CHAR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds21_002.md) | 📄 [HTML로 보기](zeds21_002.html)

---

### ZEDT21_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMTART` | CHAR | 3 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `ZVOLUM` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |
| `VRKME` | UNIT | 3 | Sales Unit |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), CURR(3), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt21_100.md) | 📄 [HTML로 보기](zedt21_100.html)

---

### ZEDT21_101

**Key 필드:** `MANDT, ZORDNO21, ZIDCODE21, ZMATNR21, ZMTART21`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME21` | CHAR | 20 | ### |
| `ZVOLUM21` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |
| `VRKME` | UNIT | 3 | Sales Unit |
| `ZSLAMT21` | CURR | 13 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), TIMS(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zedt21_101.md) | 📄 [HTML로 보기](zedt21_101.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
