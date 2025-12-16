# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT06_LFA1](zedt06_lfa1.md) 📄 [HTML](zedt06_lfa1.html) | - | 22 | MANDT, LIFNR |
| [ZEDT06_LFB1](zedt06_lfb1.md) 📄 [HTML](zedt06_lfb1.html) | - | 41 | MANDT, LIFNR, BUKRS |
| [ZEDT06_LFM1](zedt06_lfm1.md) 📄 [HTML](zedt06_lfm1.html) | - | 21 | MANDT, LIFNR |

---

## 테이블 상세 정보

### ZEDT06_LFA1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 5 | ### ## |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt06_lfa1.md) | 📄 [HTML로 보기](zedt06_lfa1.html)

---

### ZEDT06_LFB1

**Key 필드:** `MANDT, LIFNR, BUKRS`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 5 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zedt06_lfb1.md) | 📄 [HTML로 보기](zedt06_lfb1.html)

---

### ZEDT06_LFM1

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS06_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zedt06_lfm1.md) | 📄 [HTML로 보기](zedt06_lfm1.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
