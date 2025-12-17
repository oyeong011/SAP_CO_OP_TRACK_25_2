
*&---------------------------------------------------------------------*

*& Report ZEDR01_025

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_025 MESSAGE-ID ZMED01.



include
ZEDR01_025_CLS
.

include
ZEDR01_025_TOP
.

include
ZEDR01_025_SCR
.

include
ZEDR01_025_F01
.

include
ZEDR01_025_PBO
.

include
ZEDR01_025_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########.