
*&---------------------------------------------------------------------*

*& Report ZEDR09_037

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_037.



include
ZEDR09_037_CLS
. "CLS# ### TOP ## ##

include
ZEDR09_037_TOP
.

include
ZEDR09_037_SCR
.

include
ZEDR09_037_F01
.

include
ZEDR09_037_PBO
.

include
ZEDR09_037_PAI
.



INITIALIZATION.

  PERFORM SET_INIT. "####



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    IF S_ZPERNR IS INITIAL.

      MESSAGE '##### #### ## ##### #####.' TYPE 'I'.

      EXIT.

    ENDIF.

  ENDIF.



PERFORM SELECT_DATA.



IF GT_STUDENT[] IS NOT INITIAL.

  CALL SCREEN 100.

ELSE.

 MESSAGE '### ### #######.' TYPE 'I'.

 EXIT.

ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########