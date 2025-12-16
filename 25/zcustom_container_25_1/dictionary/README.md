# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT25_001](zedt25_001.md) 📄 [HTML](zedt25_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT25_002](zedt25_002.md) 📄 [HTML](zedt25_002.html) | - | 22 | MANDT, ZCODE, ZPERNR |
| [ZEDT25_100](zedt25_100.md) 📄 [HTML](zedt25_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT25_101](zedt25_101.md) 📄 [HTML](zedt25_101.html) | - | 39 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT25_102](zedt25_102.md) 📄 [HTML](zedt25_102.html) | - | 31 | MANDT, ZPERNR, ZDEPCODE ... (+2) |
| [ZEDT25_103](zedt25_103.md) 📄 [HTML](zedt25_103.html) | - | 14 | MANDT, ZPERNR |
| [ZEDT25_104](zedt25_104.md) 📄 [HTML](zedt25_104.html) | - | 20 | MANDT, ZPERNR, ZDEPCODE ... (+3) |
| [ZEDT25_105](zedt25_105.md) 📄 [HTML](zedt25_105.html) | - | 22 | MANDT, ZPERNR, ZYEAR |
| [ZEDT25_106](zedt25_106.md) 📄 [HTML](zedt25_106.html) | - | 20 | MANDT, ZPERNR, ZYEAR ... (+2) |

---

## 테이블 상세 정보

### ZEDT25_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 20 | - |
| `ZENAME` | CHAR | 20 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |
| `CNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_001.md) | 📄 [HTML로 보기](zedt25_001.html)

---

### ZEDT25_002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 1 | - |
| `ZMNAME` | CHAR | 20 | ### |
| `ZMGUBUN` | CHAR | 1 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt25_002.md) | 📄 [HTML로 보기](zedt25_002.html)

---

### ZEDT25_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS025_002

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

📋 [마크다운으로 보기](zedt25_100.md) | 📄 [HTML로 보기](zedt25_100.html)

---

### ZEDT25_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMTART` | CHAR | 3 | - |
| `ZMATNAME` | CHAR | 20 | ### |
| `ZVOLUM` | CHAR | 3 | - |
| `VOLUM` | QUAN | 13 | Volume |
| `VRKME` | UNIT | 3 | Sales Unit |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), TIMS(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zedt25_101.md) | 📄 [HTML로 보기](zedt25_101.html)

---

### ZEDT25_102

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, DATBI, DATAB`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZDEPRANK` | CHAR | 1 | - |
| `ZEDATE` | DATS | 8 | - |
| `ZQDATE` | DATS | 8 | - |
| `ZQFLAG` | CHAR | 1 | - |
| `CNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(6), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_102.md) | 📄 [HTML로 보기](zedt25_102.html)

---

### ZEDT25_103

**Key 필드:** `MANDT, ZPERNR`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZADDRESS` | CHAR | 20 | - |
| `CNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt25_103.md) | 📄 [HTML로 보기](zedt25_103.html)

---

### ZEDT25_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK` | CHAR | 1 | - |
| `CNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt25_104.md) | 📄 [HTML로 보기](zedt25_104.html)

---

### ZEDT25_105

**Key 필드:** `MANDT, ZPERNR, ZYEAR`

**INCLUDE 구조:** ZEDS025_002

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

📋 [마크다운으로 보기](zedt25_105.md) | 📄 [HTML로 보기](zedt25_105.html)

---

### ZEDT25_106

**Key 필드:** `MANDT, ZPERNR, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS025_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY` | CURR | 13 | - |
| `ZBANKCODE` | CHAR | 3 | - |
| `ZACCOUNT` | CHAR | 20 | - |
| `CNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt25_106.md) | 📄 [HTML로 보기](zedt25_106.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
