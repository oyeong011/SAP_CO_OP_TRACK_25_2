# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDS10_002](zeds10_002.md) 📄 [HTML](zeds10_002.html) | - | 6 | - |
| [ZEDT10_105](zedt10_105.md) 📄 [HTML](zedt10_105.html) | - | 23 | MANDT, ZPERNR |
| [ZEDT10_106](zedt10_106.md) 📄 [HTML](zedt10_106.html) | - | 21 | MANDT, ZPERNR, ZYEAR ... (+2) |

---

## 테이블 상세 정보

### ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Last Changed By |
| `AEDATE` | DATS | 8 | Date of Last Change |

*... 외 1개 필드*

**데이터 타입:** CHAR(2), DATS(2), TIMS(2)

📋 [마크다운으로 보기](zeds10_002.md) | 📄 [HTML로 보기](zeds10_002.html)

---

### ZEDT10_105

**Key 필드:** `MANDT, ZPERNR`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZYEAR` | NUMC | 4 | - |
| `ZMON01` | CURR | 13 | 1### |
| `ZMON02` | CURR | 13 | 2### |
| `ZMON03` | CURR | 13 | 3### |
| `ZMON04` | CURR | 13 | 4### |

*... 외 5개 필드*

**데이터 타입:** CURR(12), CHAR(3), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt10_105.md) | 📄 [HTML로 보기](zedt10_105.html)

---

### ZEDT10_106

**Key 필드:** `MANDT, ZPERNR, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY` | CURR | 13 | - |
| `ZBANKCODE` | CHAR | 3 | - |
| `ZACCOUNT` | CHAR | 20 | - |
| `ZWAERS` | CUKY | 5 | Currency Key |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt10_106.md) | 📄 [HTML로 보기](zedt10_106.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
