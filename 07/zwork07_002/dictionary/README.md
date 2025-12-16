# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZEDT07_000](zedt07_000.html) | - | 9 | MANDT, ZCODE07, ZPERNR07 |
| [ZPRO11_007](zpro11_007.html) | - | 19 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZTCURR07](ztcurr07.html) | - | 8 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZEDT07_000

**Key 필드:** `MANDT, ZCODE07, ZPERNR07`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `ZKNAME07` | CHAR | 20 | - |
| `ZENAME07` | CHAR | 20 | - |
| `ZGUBUN07` | CHAR | 1 | - |
| `ZTEL07` | CHAR | 16 | - |

**데이터 타입:** CHAR(6), CLNT(1)

📄 [전체 테이블 구조 보기](zedt07_000.html)

---

### ZPRO11_007

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | Material Number |
| `WERKS` | CHAR | 4 | Plant |
| `LGORT` | CHAR | 4 | Storage Location |
| `LIFNR` | CHAR | 10 | Account Number of Vendor or Creditor |
| `WAERS` | CUKY | 5 | Currency Key |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), NUMC(3), CLNT(1), CUKY(1), QUAN(1)

📄 [전체 테이블 구조 보기](zpro11_007.html)

---

### ZTCURR07

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |

**데이터 타입:** DEC(3), CHAR(2), CUKY(2), CLNT(1)

📄 [전체 테이블 구조 보기](ztcurr07.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
