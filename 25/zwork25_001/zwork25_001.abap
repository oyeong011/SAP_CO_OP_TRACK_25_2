
*&---------------------------------------------------------------------*

*& Report ZWORK25_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK25_001.



include
ZWORK25_001_CLS
.

include
ZWORK25_001_TOP
.

include
ZWORK25_001_SCR
.

include
ZWORK25_001_F01
.

include
ZWORK25_001_PBO
.

include
ZWORK25_001_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.

  P_DATE = SY-DATUM.



" #### P_KURST #### ##

AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN_OUTPUT.



" ### F4 ##

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM F4_FILE.



" FUNCTION KEY 1 (### ####)

AT SELECTION-SCREEN.

  PERFORM HANDLE_FUNCTION_KEY.

  PERFORM CHECK_SELECTION.



START-OF-SELECTION.

  PERFORM CONVERT_DATE_TO_GDATU.   " P_DATE -> GV_GDATU (INVERTED DATE)

  PERFORM UPLOAD_EXCEL.            " ## -> GT_DATA

  PERFORM BUILD_FIELDCAT.          " ALV ###### ##

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   EXCEL UPLOAD FAILED