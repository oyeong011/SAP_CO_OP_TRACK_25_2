# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT10_001](zedt10_001.html) | - | 16 | MANDT, ZCODE, ZPERNR |
| [ZEDT10_T024](zedt10_t024.html) | - | 3 | MANDT, EKGRP |
| [ZEDT10_T024E](zedt10_t024e.html) | - | 4 | MANDT, EKORG |

---

## 테이블 상세 정보

### ZEDT10_001

**Key 필드:** `MANDT, ZCODE, ZPERNR`

**INCLUDE 구조:** ZEDS10_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME` | CHAR | 10 | ## ## |
| `ZENAME` | CHAR | 10 | - |
| `ZGENDER` | CHAR | 1 | - |
| `ZTEL` | CHAR | 16 | - |
| `CRNAME` | CHAR | 12 | Created By |

*... 외 5개 필드*

**데이터 타입:** CHAR(8), DATS(2), TIMS(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_001.html)

---

### ZEDT10_T024

**Key 필드:** `MANDT, EKGRP`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKNAM` | CHAR | 18 | Description of purchasing group |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_t024.html)

---

### ZEDT10_T024E

**Key 필드:** `MANDT, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKOTX` | CHAR | 20 | Description of purchasing organization |
| `BUKRS` | CHAR | 4 | Company Code |

**데이터 타입:** CHAR(3), CLNT(1)

📄 [전체 테이블 구조 보기](zedt10_t024e.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
