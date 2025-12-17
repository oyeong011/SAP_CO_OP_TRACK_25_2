# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT19_0000](zedt19_0000.md) 📄 [HTML](zedt19_0000.html) | - | 9 | MANDT, ZCODE19 |
| [ZEDT19_0001](zedt19_0001.md) 📄 [HTML](zedt19_0001.html) | - | 18 | ZCODE, ZPERNR |
| [ZEDT19_100](zedt19_100.md) 📄 [HTML](zedt19_100.html) | - | 36 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT19_101](zedt19_101.md) 📄 [HTML](zedt19_101.html) | - | 32 | MANDT, ZORDNO, ZIDCODE ... (+1) |
| [ZEDT19_102](zedt19_102.md) 📄 [HTML](zedt19_102.html) | - | 30 | MANDT, ZPERNR, ZDEPCODE ... (+2) |
| [ZEDT19_103](zedt19_103.md) 📄 [HTML](zedt19_103.html) | - | 13 | MANDT, ZPERNR |
| [ZEDT19_104](zedt19_104.md) 📄 [HTML](zedt19_104.html) | - | 24 | MANDT, ZPERNR, ZDEPCODE |
| [ZEDT19_105](zedt19_105.md) 📄 [HTML](zedt19_105.html) | - | 21 | MANDT, ZPERNR, ZYEAR |
| [ZEDT19_106](zedt19_106.md) 📄 [HTML](zedt19_106.html) | - | 18 | MANDT, ZPERNR, ZYEAR ... (+2) |
| [ZEDT19_200](zedt19_200.md) 📄 [HTML](zedt19_200.html) | - | 24 | MANDT, ZWERKS, ZLGORT ... (+1) |

---

## 테이블 상세 정보

### ZEDT19_0000

**Key 필드:** `MANDT, ZCODE19`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPERNR19` | CHAR | 10 | ZPERNR19 |
| `ZKNAME19` | CHAR | 20 | ZKNAME19 |
| `ZENAME19` | CHAR | 20 | ZENAME19 |
| `ZGUBUN19` | CHAR | 1 | ZGENDER19 |
| `ZTEL19` | CHAR | 16 | ZTEL19 |

**데이터 타입:** CHAR(6), CLNT(1)

📋 [마크다운으로 보기](zedt19_0000.md) | 📄 [HTML로 보기](zedt19_0000.html)

---

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

### ZEDT19_100

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

📋 [마크다운으로 보기](zedt19_100.md) | 📄 [HTML로 보기](zedt19_100.html)

---

### ZEDT19_101

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

**데이터 타입:** CHAR(11), DATS(4), TIMS(2), CLNT(1), QUAN(1)

📋 [마크다운으로 보기](zedt19_101.md) | 📄 [HTML로 보기](zedt19_101.html)

---

### ZEDT19_102

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE, DATBI, DATAB`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZDEPRANK` | CHAR | 1 | - |
| `ZEDATE` | DATS | 8 | - |
| `ZQDATE` | DATS | 8 | - |
| `ZQFLAG` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(6), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt19_102.md) | 📄 [HTML로 보기](zedt19_102.html)

---

### ZEDT19_103

**Key 필드:** `MANDT, ZPERNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZADDRESS` | CHAR | 20 | - |
| `CRNAME19` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt19_103.md) | 📄 [HTML로 보기](zedt19_103.html)

---

### ZEDT19_104

**Key 필드:** `MANDT, ZPERNR, ZDEPCODE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZYEAR` | NUMC | 4 | - |
| `DATABI` | DATS | 8 | Valid To Date |
| `DATAB` | DATS | 8 | Valid-From Date |
| `ZRANK` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📋 [마크다운으로 보기](zedt19_104.md) | 📄 [HTML로 보기](zedt19_104.html)

---

### ZEDT19_105

**Key 필드:** `MANDT, ZPERNR, ZYEAR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMON01` | DEC | 17 | 1### |
| `ZMON02` | DEC | 17 | 2### |
| `ZMON03` | DEC | 17 | 3### |
| `ZMON04` | DEC | 17 | 4### |
| `ZMON05` | DEC | 17 | 5### |

*... 외 5개 필드*

**데이터 타입:** DEC(12), CHAR(3), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt19_105.md) | 📄 [HTML로 보기](zedt19_105.html)

---

### ZEDT19_106

**Key 필드:** `MANDT, ZPERNR, ZYEAR, DATBI, DATAB`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZSALARY` | DEC | 17 | - |
| `ZBANKCODE` | CHAR | 3 | - |
| `ZACCOUNT` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 3개 필드*

**데이터 타입:** CHAR(5), DATS(4), CLNT(1), NUMC(1), DEC(1)

📋 [마크다운으로 보기](zedt19_106.md) | 📄 [HTML로 보기](zedt19_106.html)

---

### ZEDT19_200

**Key 필드:** `MANDT, ZWERKS, ZLGORT, ZMATNR`

**INCLUDE 구조:** ZEDS19_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMATNAME` | CHAR | 20 | ### |
| `MTART` | CHAR | 4 | Material Type |
| `STPRS` | CURR | 11 | Standard price |
| `WAERS` | CUKY | 5 | Currency Key |
| `MENGE` | QUAN | 13 | Quantity |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zedt19_200.md) | 📄 [HTML로 보기](zedt19_200.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
