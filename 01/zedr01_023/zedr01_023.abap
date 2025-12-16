
*&---------------------------------------------------------------------*

*& Report ZEDR01_023

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR01_023 MESSAGE-ID ZMED01.



include
ZEDR01_023_TOP
.

include
ZEDR01_023_SCR
.

include
ZEDR01_023_F01
.

include
ZEDR01_023_PBO
.

include
ZEDR01_023_PAI
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

* T100 --> DOCKING SPLITTER CONTAINER