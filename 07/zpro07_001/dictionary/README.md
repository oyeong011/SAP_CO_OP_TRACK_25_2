# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZPRO07_001](zpro07_001.md) 📄 [HTML](zpro07_001.html) | - | 15 | MANDT, LIFNR |
| [ZPRO07_002](zpro07_002.md) 📄 [HTML](zpro07_002.html) | - | 34 | MANDT, LIFNR, BUKRS |
| [ZPRO07_003](zpro07_003.md) 📄 [HTML](zpro07_003.html) | - | 14 | MANDT, LIFNR, EKORG |

---

## 테이블 상세 정보

### ZPRO07_001

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `NAME1` | CHAR | 30 | Name |
| `LAND1` | CHAR | 3 | Country Key |
| `KTOKK` | CHAR | 4 | Vendor account group |
| `STCD1` | CHAR | 16 | Tax Number 1 |
| `STCD2` | CHAR | 11 | Tax Number 2 |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📋 [마크다운으로 보기](zpro07_001.md) | 📄 [HTML로 보기](zpro07_001.html)

---

### ZPRO07_002

**Key 필드:** `MANDT, LIFNR, BUKRS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | Reconciliation Account in General Ledger |
| `ZTERM` | CHAR | 4 | Terms of Payment Key |

**데이터 타입:** CHAR(5), CLNT(1)

📋 [마크다운으로 보기](zpro07_002.md) | 📄 [HTML로 보기](zpro07_002.html)

---

### ZPRO07_003

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📋 [마크다운으로 보기](zpro07_003.md) | 📄 [HTML로 보기](zpro07_003.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
