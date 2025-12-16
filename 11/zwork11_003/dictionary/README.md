# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT11_0000](zedt11_0000.html) | - | 9 | MANDT, ZCODE11 |
| [ZLFM1_11](zlfm1_11.html) | - | 9 | MANDT, LIFNR, EKORG |
| [ZPRO07_011](zpro07_011.html) | - | 1 | MANDT |
| [ZTCURR11](ztcurr11.html) | - | 8 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDT11_0000

**Key 필드:** `MANDT, ZCODE11`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZPERNR11` | CHAR | 10 | - |
| `ZKNAME11` | CHAR | 10 | - |
| `ZENAME11` | CHAR | 10 | - |
| `ZGUBUN11` | CHAR | 1 | - |
| `ZTEL11` | CHAR | 16 | - |

**데이터 타입:** CHAR(6), CLNT(1)

📄 [전체 테이블 구조 보기](zedt11_0000.html)

---

### ZLFM1_11

**Key 필드:** `MANDT, LIFNR, EKORG`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | Tax on Sales/Purchases Code |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zlfm1_11.html)

---

### ZPRO07_011

**Key 필드:** `MANDT`

**데이터 타입:** CLNT(1)

📄 [전체 테이블 구조 보기](zpro07_011.html)

---

### ZTCURR11

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |

**데이터 타입:** DEC(3), CHAR(2), CUKY(2), CLNT(1)

📄 [전체 테이블 구조 보기](ztcurr11.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
