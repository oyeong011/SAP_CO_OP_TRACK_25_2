# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT21_101](zedt21_101.md) 📄 [HTML](zedt21_101.html) | - | 38 | MANDT, ZORDNO21, ZIDCODE21 ... (+2) |
| [ZEDT21_102](zedt21_102.md) 📄 [HTML](zedt21_102.html) | - | 30 | MANDT, ZPERNR21, ZDEPCODE21 ... (+2) |
| [ZEDT21_103](zedt21_103.md) 📄 [HTML](zedt21_103.html) | - | 12 | MANDT, ZPERNR21 |
| [ZEDT21_104](zedt21_104.md) 📄 [HTML](zedt21_104.html) | - | 25 | MANDT, ZPERNR21, ZDEPCODE21 ... (+3) |
| [ZEDT21_105](zedt21_105.md) 📄 [HTML](zedt21_105.html) | - | 22 | MANDT, ZPERNR21, ZYEAR21 |
| [ZEDT21_106](zedt21_106.md) 📄 [HTML](zedt21_106.html) | - | 20 | MANDT, ZPERNR21, ZYEAR21 ... (+2) |

---

## 테이블 상세 정보

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

### ZEDT21_102

**Key 필드:** `MANDT, ZPERNR21, ZDEPCODE21, DATBI, DATAB`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZDEPRANK21` | CHAR | 1 | - |
| `ZEDATE21` | DATS | 8 | - |
| `ZQDATE21` | DATS | 8 | - |
| `ZQFLAG21` | CHAR | 1 | - |
| `CRNAM` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(6), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt21_102.md) | 📄 [HTML로 보기](zedt21_102.html)

---

### ZEDT21_103

**Key 필드:** `MANDT, ZPERNR21`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME21` | CHAR | 10 | - |
| `ZGENDER21` | CHAR | 1 | - |
| `ZADDRESS21` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Created On |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt21_103.md) | 📄 [HTML로 보기](zedt21_103.html)

---

### ZEDT21_104

**Key 필드:** `MANDT, ZPERNR21, ZDEPCODE21, ZYEAR21, DATBI, DATAB`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK21` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Created On |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Last Changed By |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt21_104.md) | 📄 [HTML로 보기](zedt21_104.html)

---

### ZEDT21_105

**Key 필드:** `MANDT, ZPERNR21, ZYEAR21`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMON01` | CURR | 13 | 1### |
| `ZMON02` | CURR | 13 | 2### |
| `ZMON03` | CURR | 13 | 3### |
| `ZMON04` | CURR | 13 | 4### |
| `ZMON05` | CURR | 13 | 5### |

*... 외 5개 필드*

**데이터 타입:** CURR(12), CHAR(3), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt21_105.md) | 📄 [HTML로 보기](zedt21_105.html)

---

### ZEDT21_106

**Key 필드:** `MANDT, ZPERNR21, ZYEAR21, DATBI, DATAB`

**INCLUDE 구조:** ZEDS21_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY21` | CURR | 13 | - |
| `ZBANKCODE21` | CHAR | 3 | - |
| `ZACCOUNT21` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Created On |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt21_106.md) | 📄 [HTML로 보기](zedt21_106.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
