# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZLFA1_13](zlfa1_13.md) 📄 [HTML](zlfa1_13.html) | - | 17 | MANDT, LIFNR |
| [ZLFB1_13](zlfb1_13.md) 📄 [HTML](zlfb1_13.html) | - | 37 | MANDT, LIFNR |
| [ZLFM1_13](zlfm1_13.md) 📄 [HTML](zlfm1_13.html) | - | 14 | MANDT, LIFNR |

---

## 테이블 상세 정보

### ZLFA1_13

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `ORT01` | CHAR | 25 | City |
| `PSTLZ` | CHAR | 10 | Postal Code |
| `KTOKK` | CHAR | 4 | ##### |

*... 외 3개 필드*

**데이터 타입:** CHAR(9), CLNT(1)

📋 [마크다운으로 보기](zlfa1_13.md) | 📄 [HTML로 보기](zlfa1_13.html)

---

### ZLFB1_13

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | ####(Reconciliation Account) |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zlfb1_13.md) | 📄 [HTML로 보기](zlfb1_13.html)

---

### ZLFM1_13

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zlfm1_13.md) | 📄 [HTML로 보기](zlfm1_13.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
