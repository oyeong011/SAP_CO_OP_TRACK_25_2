# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT05_102](zedt05_102.html) | - | 30 | ZPERNR, ZDEPCODE, DATBI ... (+1) |
| [ZEDT05_103](zedt05_103.html) | - | 13 | ZPERNR |
| [ZEDT05_104](zedt05_104.html) | - | 24 | ZPERNR, ZDEPCODE, ZYEAR ... (+2) |
| [ZEDT05_105](zedt05_105.html) | - | 21 | ZPERNR, ZYEAR |
| [ZEDT05_106](zedt05_106.html) | - | 0 | - |

---

## 테이블 상세 정보

### ZEDT05_102

**Key 필드:** `ZPERNR, ZDEPCODE, DATBI, DATAB`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZDEPRANK` | CHAR | 1 | - |
| `ZEDATE` | DATS | 8 | - |
| `ZQDATE` | DATS | 8 | - |
| `ZQFLAG` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(6), DATS(6), TIMS(2)

📄 [전체 테이블 구조 보기](zedt05_102.html)

---

### ZEDT05_103

**Key 필드:** `ZPERNR`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPNAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZADDRESS` | CHAR | 20 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(6), DATS(2), TIMS(2)

📄 [전체 테이블 구조 보기](zedt05_103.html)

---

### ZEDT05_104

**Key 필드:** `ZPERNR, ZDEPCODE, ZYEAR, DATBI, DATAB`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZRANK` | CHAR | 1 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |
| `CRZEIT` | TIMS | 6 | Time created |
| `AENAME` | CHAR | 12 | Name of person who changed object |

*... 외 2개 필드*

**데이터 타입:** CHAR(5), DATS(4), TIMS(2), NUMC(1)

📄 [전체 테이블 구조 보기](zedt05_104.html)

---

### ZEDT05_105

**Key 필드:** `ZPERNR, ZYEAR`

**INCLUDE 구조:** ZEDS05_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZMON01` | CURR | 13 | 1### |
| `ZMON02` | CURR | 13 | 2### |
| `ZMON03` | CURR | 13 | 3### |
| `ZMON04` | CURR | 13 | 4### |
| `ZMON05` | CURR | 13 | 5### |

*... 외 5개 필드*

**데이터 타입:** CURR(12), CHAR(3), DATS(2), TIMS(2), NUMC(1)

📄 [전체 테이블 구조 보기](zedt05_105.html)

---

### ZEDT05_106

📄 [전체 테이블 구조 보기](zedt05_106.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
