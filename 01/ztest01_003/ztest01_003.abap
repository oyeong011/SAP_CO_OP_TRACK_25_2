
*&---------------------------------------------------------------------*

*& Report ZTEST01_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZTEST01_003.



include
ZTEST01_003_CLS
.

include
ZTEST01_003_TOP
.

include
ZTEST01_003_SCR
.

include
ZTEST01_003_F01
.

include
ZTEST01_003_PBO
.

include
ZTEST01_003_PAI
.

"=============================================================="

" INITIALIZATION"

"=============================================================="

INITIALIZATION.

  PERFORM INITIALIZATION.

"=============================================================="

" AT SELECTION-SCREEN OUTPUT"

"=============================================================="

AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_OUTPUT.





"=============================================================="

" AT SELECTION-SCREEN"

" (### ##, ### ##, ### ## ## #)"

"=============================================================="

AT SELECTION-SCREEN.

  PERFORM AT_SELECTION_SCREEN.





"=============================================================="

" AT SELECTION-SCREEN ON VALUE-REQUEST (F4 ##)"

"=============================================================="




* #: AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

*     PERFORM F4_FILE.








"=============================================================="

" START-OF-SELECTION (## ## ##)"

"=============================================================="

START-OF-SELECTION.



  PERFORM CHECK_MANDATORY.   "## ## ##"

  PERFORM CHECK_AUTH.        "## ##"



  PERFORM INI_DATA.          "## ### SELECT"

  PERFORM MODIFY_DATA.       "##/##/### ##"





"=============================================================="

" END-OF-SELECTION (### ## ## / ## ##)"

"=============================================================="

END-OF-SELECTION.



  CHECK GV_ERR_FLAG IS INITIAL.



  PERFORM END_OF_SELECTION.  "## 100 ## # ALV ##"