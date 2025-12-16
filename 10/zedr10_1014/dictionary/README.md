# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT10_004](zedt10_004.md) 📄 [HTML](zedt10_004.html) | - | 32 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT10_100](zedt10_100.md) 📄 [HTML](zedt10_100.html) | - | 42 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT10_1000](zedt10_1000.md) 📄 [HTML](zedt10_1000.html) | - | 9 | MANDT, ZMAJOR, ZMNAME |
| [ZEDT10_1002](zedt10_1002.md) 📄 [HTML](zedt10_1002.html) | - | 20 | MANDT, ZCODE, ZPERNR |
| [ZEDT10_1004](zedt10_1004.md) 📄 [HTML](zedt10_1004.html) | - | 34 | MANDT, ZCODE, ZPERNR ... (+3) |
| [ZEDT10_101](zedt10_101.md) 📄 [HTML](zedt10_101.html) | - | 39 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT10_103](zedt10_103.md) 📄 [HTML](zedt10_103.html) | - | 14 | MANDT, ZPERNR |
| [ZEDT10_104](zedt10_104.md) 📄 [HTML](zedt10_104.html) | - | 25 | MANDT, ZPERNR, ZDEPCODE ... (+3) |
| [ZEDT10_105](zedt10_105.md) 📄 [HTML](zedt10_105.html) | - | 23 | MANDT, ZPERNR |
| [ZEDT10_106](zedt10_106.md) 📄 [HTML](zedt10_106.html) | - | 21 | MANDT, ZPERNR, ZYEAR ... (+2) |

---

## 테이블 상세 정보

### ZEDT10_004

**Key 필드:** `MANDT, ZCODE, ZPERNR, ZSCHOOL, ZSEM, ZEXAM`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 10 | - |
| `ZMNAME` | CHAR | 40 | ### |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | Currency Key |
| `ZGRADE` | CHAR | 1 | - |

*... 외 2개 필드*

**데이터 타입:** CHAR(9), CURR(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt10_004.md) | 📄 [HTML로 보기](zedt10_004.html)

---

### ZEDT10_100

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS10_002

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

📋 [마크다운으로 보기](zedt10_100.md) | 📄 [HTML로 보기](zedt10_100.html)

---

### ZEDT10_1000

**Key 필드:** `MANDT, ZMAJOR, ZMNAME`

**데이터 타입:** CHAR(2), CLNT(1)

📋 [마크다운으로 보기](zedt10_1000.md) | 📄 [HTML로 보기](zedt10_1000.html)

---

### ZEDT10_1002

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMAJOR` | CHAR | 10 | - |
| `ZSUM` | CURR | 13 | - |
| `ZWAERS` | CUKY | 5 | Currency Key |
| `ZFLAG` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt10_1002.md) | 📄 [HTML로 보기](zedt10_1002.html)

---

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

### ZEDT10_101

**Key 필드:** `MANDT, ZORDNO, ZIDCODE, ZMATNR`

**INCLUDE 구조:** ZEDS10_002

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

📋 [마크다운으로 보기](zedt10_101.md) | 📄 [HTML로 보기](zedt10_101.html)

---

### ZEDT10_103

**Key 필드:** `MANDT, ZPERNR`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZADDRESS` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt10_103.md) | 📄 [HTML로 보기](zedt10_103.html)

---

### ZEDT10_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Last Changed By |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt10_104.md) | 📄 [HTML로 보기](zedt10_104.html)

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
