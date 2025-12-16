# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZLFA1_14](zlfa1_14.html) | - | 21 | MANDT, LIFNR |
| [ZLFB1_14](zlfb1_14.html) | - | 13 | MANDT, LIFNR, BUKRS |
| [ZLFM1_14](zlfm1_14.html) | - | 19 | MANDT, LIFNR, EKORG |

---

## 테이블 상세 정보

### ZLFA1_14

**Key 필드:** `MANDT, LIFNR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 35 | - |
| `LAND1` | CHAR | 3 | ### |
| `KTOKK` | CHAR | 4 | ##### |
| `STCD1` | CHAR | 16 | - |
| `STCD2` | CHAR | 11 | ##### |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zlfa1_14.html)

---

### ZLFB1_14

**Key 필드:** `MANDT, LIFNR, BUKRS`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | ##### |
| `AKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |
| `CRNAME` | CHAR | 12 | Created By |
| `CRDATE` | DATS | 8 | Creation date |

*... 외 4개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zlfb1_14.html)

---

### ZLFM1_14

**Key 필드:** `MANDT, LIFNR, EKORG`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | - |
| `LOEVM` | CHAR | 1 | ##### |
| `WAERS` | CUKY | 5 | ###### |
| `MWSKZ` | CHAR | 2 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zlfm1_14.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
