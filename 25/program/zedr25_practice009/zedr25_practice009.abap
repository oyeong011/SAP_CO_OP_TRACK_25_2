
*&---------------------------------------------------------------------*

*& Report ZEDR25_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_PRACTICE009 MESSAGE-ID ZMED25.



include
ZEDR25_PRACTICE009_TOP
.

include
ZEDR25_PRACTICE009_SCR
.

include
ZEDR25_PRACTICE009_F01
.

include
ZEDR25_PRACTICE009_PBO
.

include
ZEDR25_PRACTICE009_PAI
.



INITIALIZATION.

PERFORM SET_INIT.



START-OF-SELECTION.

PERFORM CHECK_DATA.



PERFORM GET_DATA.

PERFORM MODIFY_DATA.



IF GT_EMP[] IS NOT INITIAL.

  CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######

* T100 --> #######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## ### #####.