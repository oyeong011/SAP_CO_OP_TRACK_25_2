
*&---------------------------------------------------------------------*

*& Report ZEDR21_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR21_PRACTICE009 MESSAGE-ID ZMED21.



include
ZEDR21_PRACTICE009_TOP
.

include
ZEDR21_PRACTICE009_SCR
.

include
ZEDR21_PRACTICE009_F01
.

include
ZEDR21_PRACTICE009_PBO
.

include
ZEDR21_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_DATE.



START-OF-SELECTION.

  PERFORM CHECK_DATA.

  PERFORM SELECT_DATA.





  PERFORM MODIFY_DATA.



  IF GT_EMPLOYEE[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

    ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######