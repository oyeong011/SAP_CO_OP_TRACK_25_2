# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEKKO_14](zekko_14.md) 📄 [HTML](zekko_14.html) | - | 15 | MANDT, EBELN |
| [ZEKPO_14](zekpo_14.md) 📄 [HTML](zekpo_14.html) | - | 20 | MANDT, EBELN, EBELP |
| [ZMARA_14](zmara_14.md) 📄 [HTML](zmara_14.html) | - | 17 | MANDT, WERKS, LGORT ... (+1) |

---

## 테이블 상세 정보

### ZEKKO_14

**Key 필드:** `MANDT, EBELN`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | - |
| `EKORG` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | ##### |
| `BEDAT` | DATS | 8 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zekko_14.md) | 📄 [HTML로 보기](zekko_14.html)

---

### ZEKPO_14

**Key 필드:** `MANDT, EBELN, EBELP`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 10 | - |
| `MAKTX` | CHAR | 20 | ### |
| `MENGE` | QUAN | 13 | - |
| `MEINS` | UNIT | 3 | ##1 |
| `BPRME` | UNIT | 3 | ##2 |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(3), UNIT(2), TIMS(2), CLNT(1)

📋 [마크다운으로 보기](zekpo_14.md) | 📄 [HTML로 보기](zekpo_14.html)

---

### ZMARA_14

**Key 필드:** `MANDT, WERKS, LGORT, MATNR`

**INCLUDE 구조:** ZEDS14_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAKTX` | CHAR | 20 | ### |
| `MTART` | CHAR | 4 | - |
| `STPRS` | CURR | 11 | - |
| `WAERS` | CUKY | 5 | - |
| `MENGE` | QUAN | 13 | - |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(2), TIMS(2), CLNT(1), CURR(1)

📋 [마크다운으로 보기](zmara_14.md) | 📄 [HTML로 보기](zmara_14.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
