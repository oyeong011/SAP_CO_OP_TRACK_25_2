
*&---------------------------------------------------------------------*

*& Report ZTEST13_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZTEST13_001.



include
ZTEST13_001TOP
.

include
ZTEST13_001C01
.

include
ZTEST13_001S01
.

include
ZTEST13_001I01
.

include
ZTEST13_001O01
.

include
ZTEST13_001F01
.






*----------------------------------------------------------------------*

* INITIALIZATION

*----------------------------------------------------------------------*




INITIALIZATION.

  PERFORM INITIALIZATION.






*----------------------------------------------------------------------*

* AT SELECTION-SCREEN OUTPUT

*----------------------------------------------------------------------*




AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_OUTPUT.






*----------------------------------------------------------------------*

* AT SELECTION-SCREEN.

*----------------------------------------------------------------------*




AT SELECTION-SCREEN.






*----------------------------------------------------------------------*

* AT SELECTION-SCREEN ON VALUE-REQUEST

*----------------------------------------------------------------------*

* AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_XXXX.

* PERFORM SELECTION_SCREEN_VALUE_REQUEST.



*----------------------------------------------------------------------*

* START-OF-SELECTION

*----------------------------------------------------------------------*




START-OF-SELECTION.

  PERFORM CHECK_MANDATORY.

  PERFORM CHECK_AUTH.

  PERFORM INIT_DATA.

  PERFORM MODIFY_DATA.






*----------------------------------------------------------------------*

* END-OF-SELECTION

*----------------------------------------------------------------------*




END-OF-SELECTION.

  CHECK GV_ERRL_FLAG IS INITIAL.

  PERFORM END_OF_SELECTION.