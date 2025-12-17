
*&---------------------------------------------------------------------*

*& Report ZEDR03_017_CLASS_ALV

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_018_SPLITTER MESSAGE-ID ZMED03.



include
ZEDR03_018S_TOP
.

include
ZEDR03_018S_SCR
.

include
ZEDR03_018S_F01
.

include
ZEDR03_018S_PBO
.

include
ZEDR03_018S_PAI
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