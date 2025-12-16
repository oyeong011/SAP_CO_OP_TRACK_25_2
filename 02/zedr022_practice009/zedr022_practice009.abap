
*&---------------------------------------------------------------------*

*& Report ZEDR022_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_PRACTICE009 MESSAGE-ID ZMED22_1.



include
ZEDR022_PRACTICE009_TOP
.

include
ZEDR022_PRACTICE009_SCR
.

include
ZEDR022_PRACTICE009_F01
.

include
ZEDR022_PRACTICE009_PBO
.

include
ZEDR022_PRACTICE009_PAI
.



INITIALIZATION.

PERFORM SET_DATE."## ### ### #######

"#### ## #### # # ### ### ##

"#### # ## ### ## ####### ##, #####, ### #, ### ## ##fix



START-OF-SELECTION.

  PERFORM CHECK_DATA.



  PERFORM SELECT_DATA.

  PERFORM MODIFY_DATA.



  IF GT_EMPL IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001."#### #### ## ### ##

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######

* T100 --> #######