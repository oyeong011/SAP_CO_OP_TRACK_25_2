
"====================================================================="

include structure
ZWORK11_001_SCR
.

"* ##: ##### ## ## ## ##

"====================================================================="

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-B01. " ## #### ### ##(T01) ## ##



  PARAMETERS: P_DATE   TYPE C LENGTH 8.                 " ## ## ### (YYYYMMDD ##)

  PARAMETERS: P_FILE   TYPE RLGRAP-FILENAME.            " #### ## ## ##

  PARAMETERS: P_KURST  TYPE KURST DEFAULT 'M' MODIF ID M1 VISIBLE LENGTH 1. " ## ## ### ###



SELECTION-SCREEN END OF BLOCK B1.