# Dictionary Tables
이 폴더에는 다음 테이블 정의가 포함되어 있습니다.

## 테이블 목록

| 테이블명 | 설명 | 필드 수 | Key 필드 |
|---------|------|---------|----------|
| [ZBKPF01](zbkpf01.html) | - | 26 | MANDT, BUKRS, BELNR ... (+1) |
| [ZBSEG01](zbseg01.html) | - | 29 | MANDT, BUKRS, BELNR ... (+2) |
| [ZEKKO01](zekko01.html) | - | 17 | MANDT, EBELN |
| [ZEKPO01](zekpo01.html) | - | 20 | MANDT, EBELN, EBELP ... (+1) |
| [ZLFA1_01](zlfa1_01.html) | - | 10 | MANDT, LIFNR |
| [ZLFB1_01](zlfb1_01.html) | - | 10 | MANDT, LIFNR |
| [ZLFM1_01](zlfm1_01.html) | - | 14 | MANDT, LIFNR |
| [ZMAT01](zmat01.html) | - | 42 | MANDT, WERKS, LGORT ... (+1) |
| [ZMKPF01](zmkpf01.html) | - | 18 | MANDT, MBLNR |
| [ZMSEG01](zmseg01.html) | - | 27 | MANDT, MBLNR, MJAHR ... (+1) |
| [ZRBKP01](zrbkp01.html) | - | 38 | MANDT, BELNR, GJAHR |
| [ZRSEG01](zrseg01.html) | - | 32 | MANDT, BELNR, GJAHR ... (+1) |
| [ZSKA1_01](zska1_01.html) | - | 15 | MANDT, KTOPL, KTOSL ... (+2) |
| [ZTAXCODE01](ztaxcode01.html) | - | 8 | MANDT, MWSKZ |

---

## 테이블 상세 정보

### ZBKPF01

**Key 필드:** `MANDT, BUKRS, BELNR, GJAHR`

**INCLUDE 구조:** ZEDS01_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `CPUDT` | DATS | 8 | Day On Which Accounting Document Was Entered |
| `CPUTM` | TIMS | 6 | Time of Entry |

*... 외 5개 필드*

**데이터 타입:** CHAR(10), DATS(5), TIMS(3), NUMC(2), CLNT(1)

📄 [전체 테이블 구조 보기](zbkpf01.html)

---

### ZBSEG01

**Key 필드:** `MANDT, BUKRS, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BSCHL` | CHAR | 2 | Posting Key |
| `KOART` | CHAR | 1 | Account type |
| `HKONT` | CHAR | 10 | General Ledger Account |
| `SHKZG` | CHAR | 1 | Debit/Credit Indicator |
| `SAKNR` | CHAR | 10 | G/L Account Number |

*... 외 5개 필드*

**데이터 타입:** CHAR(12), NUMC(2), CURR(2), CLNT(1)

📄 [전체 테이블 구조 보기](zbseg01.html)

---

### ZEKKO01

**Key 필드:** `MANDT, EBELN`

**INCLUDE 구조:** ZEDS01_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | Purchasing Group |
| `EKORG` | CHAR | 4 | Purchasing Organization |
| `LIFNR` | CHAR | 10 | ##### |
| `BEDAT` | DATS | 8 | Purchase Order Date |

*... 외 5개 필드*

**데이터 타입:** CHAR(9), DATS(3), TIMS(2), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zekko01.html)

---

### ZEKPO01

**Key 필드:** `MANDT, EBELN, EBELP, MATNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAKTX` | CHAR | 40 | Material Description |
| `MENGE` | QUAN | 13 | Quantity |
| `MEINS` | UNIT | 3 | Base Unit of Measure |
| `BPRME` | UNIT | 3 | Order Price Unit (Purchasing) |
| `PRDAT` | DATS | 8 | Date of last forecast |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), UNIT(2), CURR(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zekpo01.html)

---

### ZLFA1_01

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

📄 [전체 테이블 구조 보기](zlfa1_01.html)

---

### ZLFB1_01

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `BUKRS` | CHAR | 4 | - |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `AKONT` | CHAR | 10 | ####(Reconciliation Account) |
| `ZTERM` | CHAR | 4 | - |
| `BANKL` | CHAR | 3 | - |

*... 외 1개 필드*

**데이터 타입:** CHAR(7), CLNT(1)

📄 [전체 테이블 구조 보기](zlfb1_01.html)

---

### ZLFM1_01

**Key 필드:** `MANDT, LIFNR`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EKORG` | CHAR | 4 | - |
| `EKGRP` | CHAR | 3 | - |
| `LOEVM` | CHAR | 1 | Deletion Indicator |
| `WAERS` | CUKY | 5 | Currency Key |
| `MWSKZ` | CHAR | 2 | - |

**데이터 타입:** CHAR(5), CLNT(1), CUKY(1)

📄 [전체 테이블 구조 보기](zlfm1_01.html)

---

### ZMAT01

**Key 필드:** `MANDT, WERKS, LGORT, MATNR`

**INCLUDE 구조:** ZEDS01_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MAKTX` | CHAR | 40 | Material Description |
| `MTART` | CHAR | 4 | - |
| `MATKL` | CHAR | 9 | Material Group |
| `VPRSV` | CHAR | 1 | Price control indicator |
| `STPRS` | CURR | 11 | Standard price |

*... 외 5개 필드*

**데이터 타입:** CHAR(14), CURR(2), UNIT(2), DATS(2), TIMS(2)

📄 [전체 테이블 구조 보기](zmat01.html)

---

### ZMKPF01

**Key 필드:** `MANDT, MBLNR`

**INCLUDE 구조:** ZEDS01_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MJAHR` | NUMC | 4 | Material Document Year |
| `BLART` | CHAR | 2 | Document type |
| `BLDAT` | DATS | 8 | Document Date in Document |
| `BUDAT` | DATS | 8 | Posting Date in the Document |
| `BKTXT` | CHAR | 25 | Document Header Text |

*... 외 5개 필드*

**데이터 타입:** CHAR(7), DATS(4), TIMS(2), CLNT(1), NUMC(1)

📄 [전체 테이블 구조 보기](zmkpf01.html)

---

### ZMSEG01

**Key 필드:** `MANDT, MBLNR, MJAHR, ZEILE`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `MATNR` | CHAR | 18 | - |
| `WERKS` | CHAR | 4 | ### |
| `LGORT` | CHAR | 4 | - |
| `LIFNR` | CHAR | 10 | ##### |
| `EBELN` | CHAR | 10 | ###### |

*... 외 5개 필드*

**데이터 타입:** CHAR(13), NUMC(5), CLNT(1), QUAN(1), UNIT(1)

📄 [전체 테이블 구조 보기](zmseg01.html)

---

### ZRBKP01

**Key 필드:** `MANDT, BELNR, GJAHR`

**INCLUDE 구조:** ZEDS01_002

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `LIFNR` | CHAR | 10 | ##### |
| `BUKRS` | CHAR | 4 | Company Code |
| `WAERS` | CUKY | 5 | Currency Key |
| `KURSF` | DEC | 9 | Exchange rate |
| `BLART` | CHAR | 2 | Document type |

*... 외 5개 필드*

**데이터 타입:** CHAR(11), DATS(4), NUMC(2), CURR(2), TIMS(2)

📄 [전체 테이블 구조 보기](zrbkp01.html)

---

### ZRSEG01

**Key 필드:** `MANDT, BELNR, GJAHR, BUZEI`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `EBELN` | CHAR | 10 | ###### |
| `EBELP` | NUMC | 5 | Item Number of Purchasing Document |
| `MATNR` | CHAR | 18 | - |
| `BUKRS` | CHAR | 4 | - |
| `WERKS` | CHAR | 4 | ### |

*... 외 5개 필드*

**데이터 타입:** CHAR(12), NUMC(4), UNIT(3), QUAN(2), CLNT(1)

📄 [전체 테이블 구조 보기](zrseg01.html)

---

### ZSKA1_01

**Key 필드:** `MANDT, KTOPL, KTOSL, SAKNR, BKLAS`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `KTOKS` | CHAR | 4 | G/L Account Group |
| `KOART` | CHAR | 1 | Account type |
| `TEXT` | CHAR | 40 | Character field of length 40 |
| `IS_RECON` | CHAR | 1 | Single-Character Flag |
| `ACC_TYPE` | CHAR | 1 | Single-Character Flag |

**데이터 타입:** CHAR(9), CLNT(1)

📄 [전체 테이블 구조 보기](zska1_01.html)

---

### ZTAXCODE01

**Key 필드:** `MANDT, MWSKZ`

**주요 필드:**

| 필드명 | 데이터 타입 | 길이 | 설명 |
|--------|------------|------|------|
| `TEXT` | CHAR | 40 | Character field of length 40 |

**데이터 타입:** CHAR(2), CLNT(1)

📄 [전체 테이블 구조 보기](ztaxcode01.html)

---

> 💡 **팁**: 각 테이블명을 클릭하면 상세한 테이블 구조를 확인할 수 있습니다.
