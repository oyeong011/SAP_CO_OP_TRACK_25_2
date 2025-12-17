
*&---------------------------------------------------------------------*

*& Report ZEDR03_017_CLASS_ALV

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_018_DOCKING MESSAGE-ID ZMED03.



include
ZEDR03_018_TOP
.

include
ZEDR03_018_SCR
.

include
ZEDR03_018_F01
.

include
ZEDR03_018_PBO
.

include
ZEDR03_018_PAI
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

    MESSAGE I100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####