# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZPDT19_001](zpdt19_001.md) 📄 [HTML](zpdt19_001.html) | - | 14 | LIFNR |
| [ZPDT19_002](zpdt19_002.md) 📄 [HTML](zpdt19_002.html) | - | 31 | LIFNR, BUKRS |
| [ZPDT19_003](zpdt19_003.md) 📄 [HTML](zpdt19_003.html) | - | 13 | LIFNR, EKORG |

---

## 테이블 상세 정보

### ZPDT19_001

**Key 필드:** `LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `ZKTOKK` | CHAR | 4 | - |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7)

📋 [마크다운으로 보기](zpdt19_001.md) | 📄 [HTML로 보기](zpdt19_001.html)

---

### ZPDT19_002

**Key 필드:** `LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `ZAKONT` | CHAR | 10 | - |
| `ZTERM` | CHAR | 4 | - |

**데이터 타입:** CHAR(5)

📋 [마크다운으로 보기](zpdt19_002.md) | 📄 [HTML로 보기](zpdt19_002.html)

---

### ZPDT19_003

**Key 필드:** `LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `ZMWSKZ` | CHAR | 2 | ### |

**데이터 타입:** CHAR(5), CUKY(1)

📋 [마크다운으로 보기](zpdt19_003.md) | 📄 [HTML로 보기](zpdt19_003.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
