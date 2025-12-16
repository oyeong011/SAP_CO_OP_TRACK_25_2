
*&---------------------------------------------------------------------*

*& Report ZEDR06_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_PRACTICE009 MESSAGE-ID ZMED06.



include
ZEDR06_PRACTICE009_TOP
.

include
ZEDR06_PRACTICE009_SCR
.

include
ZEDR06_PRACTICE009_F01
.

include
ZEDR06_PRACTICE009_PBO
.

include
ZEDR06_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM INIT_DATA.



AT SELECTION-SCREEN.

  PERFORM VAILD_CHECK_DATA.



START-OF-SELECTION .

  PERFORM GET_DATA.

  PERFORM MODIFY_DATE.



  CALL SCREEN 100.