# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZTCURR05](ztcurr05.md) 📄 [HTML](ztcurr05.html) | - | 10 | MANDT, KURST, FCURR ... (+2) |

---

## 테이블 상세 정보

### ZTCURR05

**Key 필드:** `MANDT, KURST, FCURR, TCURR, GDATU`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `UKURS` | DEC | 9 | Exchange Rate |
| `FFACT` | DEC | 9 | Ratio for the "from" currency units |
| `TFACT` | DEC | 9 | Ratio for the "to" currency units |
| `ERNAM` | CHAR | 12 | Name of Person Who Created the Object |
| `ERDAT` | DATS | 8 | Date on Which Record Was Created |

**데이터 타입:** CHAR(3), DEC(3), CUKY(2), CLNT(1), DATS(1)

📋 [마크다운으로 보기](ztcurr05.md) | 📄 [HTML로 보기](ztcurr05.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
