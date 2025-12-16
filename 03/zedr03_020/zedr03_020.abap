
*&---------------------------------------------------------------------*

*& Report ZEDR03_017_CLASS_ALV

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_020 MESSAGE-ID ZMED03.



include
ZEDR03_020_CLS
.

include
ZEDR03_020_TOP
.

include
ZEDR03_020_SCR
.

include
ZEDR03_020_F01
.

include
ZEDR03_020_PBO
.

include
ZEDR03_020_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



END-OF-SELECTION.

  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########