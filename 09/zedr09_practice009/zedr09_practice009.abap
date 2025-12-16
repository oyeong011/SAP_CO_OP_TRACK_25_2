
*&---------------------------------------------------------------------*

*& Report ZEDR09_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_PRACTICE009 MESSAGE-ID ZMED09.



include
ZEDR09_PRACTICE009_TOP
.

include
ZEDR09_PRACTICE009_SCR
.

include
ZEDR09_PRACTICE009_F01
.

include
ZEDR09_PRACTICE009_PBO
.

include
ZEDR09_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_DATE. "#### ###



"######

START-OF-SELECTION.

  PERFORM CHECK_SCREEN. "### ## ##

  PERFORM SELECT_DATA.

  PERFORM MODIFY_DATA.



  IF GT_EMP[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I013. "##### ## #### ####

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######

* T100 --> #######